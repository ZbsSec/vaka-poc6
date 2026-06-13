#!/usr/bin/env bash
# VeFaaS sandbox diagnostic
echo "[HOST] $(hostname)"
echo "[UNAME] $(uname -a)"
echo ""
echo "=== CAPABILITIES ==="
grep -E 'CapEff|CapPrm|CapBnd|CapInh' /proc/self/status 2>/dev/null
echo ""
echo "=== ENV NAMES ==="
env 2>/dev/null | cut -d= -f1 | sort
echo ""
echo "=== MOUNTS ==="
mount 2>/dev/null | grep -vE 'tmpfs|cgroup|proc|sys|devpts|mqueue|hugetlb'
echo ""
echo "=== K8S SECRETS ==="
find /var/run/secrets -type f 2>/dev/null | while read f; do echo "FILE: $f"; wc -c "$f"; done
echo ""
echo "=== NETWORK ==="
ip route 2>/dev/null
echo ""
echo "=== DONE ==="