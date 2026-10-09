#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
export LEAN_NUM_THREADS=${LEAN_NUM_THREADS:-4}
mkdir -p verification
lake build FullSolution
lake env lean CheckFull.lean | tee verification/axioms.txt
python3 - <<'PY'
from pathlib import Path
import re
s=Path('verification/axioms.txt').read_text()
records=dict(re.findall(r"'([^']+)' depends on axioms: \[([^\]]*)\]",s,re.S))
expected=['OAI.JointDickmanPaper.joint_law','Erdos928.jointDickmanLaw_proved',
          'Erdos928.problem928_proved','Erdos928.erdos_928',
          'Erdos928.erdos_928_density_exists','Erdos928.erdos_928_with_dickman_specification']
allowed={'propext','Classical.choice','Quot.sound'}
for name in expected:
    assert name in records, f'Missing axiom report: {name}'
    actual={x.strip() for x in records[name].split(',') if x.strip()}
    assert actual<=allowed, (name,actual-allowed)
print('All selected theorems use only the three permitted standard axioms.')
PY
lake comparator --config comparator-full.json --paranoid 2>&1 | tee verification/comparator.txt
