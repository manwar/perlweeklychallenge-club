raku -e 'say (([\+] |@*ARGS) »==« (reverse [\R+] |@*ARGS)).grep: :k, *.so;' $@
# TimToady's FP solution from RosettaCode, updated to use :k and R+ .
