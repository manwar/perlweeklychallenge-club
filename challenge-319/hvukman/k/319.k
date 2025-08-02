// vowels as ints
vowels: `i$"aeiou"
check: {0< +/(~0=(&1=,//((x[0]=vowels);(|x)[0]=vowels)))}

inp:  ("unicode";"xml";"raku";"perl")
+/check'`i$'inp

inp2: ("the";"weekly";"challenge")
+/ check'`i$'inp2

inp3: ("perl";"python";"postres")
+/ check'`i$'inp3


