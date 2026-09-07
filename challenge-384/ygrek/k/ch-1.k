a:`c$,/("0"+!10;"A"+!26;"a"+!26)
:r:{a@y\x}.'(42 2; 15642094 16; 493 8; 2228519 36; 123456789 64)
expect:("101010";"EEADEE";"755";"1BRJB";"7MyqL")
:[r=expect;;`err@"fail"]
/ reimplement \
decode:{[acc;n;m]:[n=0;acc;o[(m!n),acc;(-m)!n;m]]}[()]
