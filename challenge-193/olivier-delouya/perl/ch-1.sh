binstr='$max=2**$n; $nd=1x${n}; for($i=0; $i<$max; $i++) {printf "%0${n}b ", $i};'

perl -se "$binstr" -- -n=2

perl -se "$binstr" -- -n=3
