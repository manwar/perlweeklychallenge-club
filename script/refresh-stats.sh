fetch-pwc-stats --members members.json --source challenge-001 --current
mv pwc-current.json stats/pwc-challenge-001.json
fetch-pwc-stats --members members.json --source challenge-002 --current
mv pwc-current.json stats/pwc-challenge-002.json
fetch-pwc-stats --members members.json --source challenge-003 --current
mv pwc-current.json stats/pwc-challenge-003.json
fetch-pwc-stats --members members.json --source challenge-004 --current
mv pwc-current.json stats/pwc-challenge-004.json
fetch-pwc-stats --members members.json --source challenge-005 --current
mv pwc-current.json stats/pwc-challenge-005.json
fetch-pwc-stats --members members.json --source challenge-006 --current
mv pwc-current.json stats/pwc-challenge-006.json
fetch-pwc-stats --members members.json --source challenge-007 --current
mv pwc-current.json stats/pwc-challenge-007.json
fetch-pwc-stats --members members.json --source challenge-008 --current
mv pwc-current.json stats/pwc-challenge-008.json
fetch-pwc-stats --members members.json --source challenge-009 --current
mv pwc-current.json stats/pwc-challenge-009.json
fetch-pwc-stats --members members.json --source challenge-010 --current
mv pwc-current.json stats/pwc-challenge-010.json
fetch-pwc-stats --members members.json --source challenge-011 --current
mv pwc-current.json stats/pwc-challenge-011.json
fetch-pwc-stats --members members.json --source challenge-012 --current
mv pwc-current.json stats/pwc-challenge-012.json
fetch-pwc-stats --members members.json --source challenge-013 --current
mv pwc-current.json stats/pwc-challenge-013.json
fetch-pwc-stats --members members.json --source challenge-014 --current
mv pwc-current.json stats/pwc-challenge-014.json
fetch-pwc-stats --members members.json --source challenge-015 --current
mv pwc-current.json stats/pwc-challenge-015.json
fetch-pwc-stats --members members.json --source challenge-016 --current
mv pwc-current.json stats/

fetch-pwc-stats --members members.json --source challenge-001 --summary
fetch-pwc-stats --members members.json --source challenge-002 --master pwc-summary.json --update
fetch-pwc-stats --members members.json --source challenge-003 --master pwc-summary.json --update
fetch-pwc-stats --members members.json --source challenge-004 --master pwc-summary.json --update
fetch-pwc-stats --members members.json --source challenge-005 --master pwc-summary.json --update
fetch-pwc-stats --members members.json --source challenge-006 --master pwc-summary.json --update
fetch-pwc-stats --members members.json --source challenge-007 --master pwc-summary.json --update
fetch-pwc-stats --members members.json --source challenge-008 --master pwc-summary.json --update
fetch-pwc-stats --members members.json --source challenge-009 --master pwc-summary.json --update
fetch-pwc-stats --members members.json --source challenge-010 --master pwc-summary.json --update
fetch-pwc-stats --members members.json --source challenge-011 --master pwc-summary.json --update
fetch-pwc-stats --members members.json --source challenge-012 --master pwc-summary.json --update
fetch-pwc-stats --members members.json --source challenge-013 --master pwc-summary.json --update
fetch-pwc-stats --members members.json --source challenge-014 --master pwc-summary.json --update
fetch-pwc-stats --members members.json --source challenge-015 --master pwc-summary.json --update
mv pwc-summary.json stats/pwc-master-stats.json

echo Now fetch current stats
echo ups
echo upl
echo upb
