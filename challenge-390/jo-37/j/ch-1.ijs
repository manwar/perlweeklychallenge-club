#!/usr/local/bin/jconsole

require 'regex'

NB. decode (nested) strings in the format 'K[str]'
decode_str =: _(adverb define)
  NB. matches inner encodings, capturing K and string
  rh =. rxcomp '(\d+)\[([^][]+)\]'

  NB. - convert x to numeric
  NB. - repeat y x-times
  NB. - remove boxing
  repeat =. ;@(".@>@[ # ])

  NB. match K and str and apply "repeat" between them
  decode =. [: repeat/ ] rxfrom~ (rh; 1 2) rxmatch ]

  NB. find inner encodings and decode until all are resolved
  NB. "f:" requires J9.8, which is still beta!
  rh&(decode rxapply)^:_ f: 'private' : [:
)

Examples =: cutopen 0 : 0
2[3[a]]
10[a]
a2[b]c3[d]e
2[a2[b]c]
1[a]2[b3[c]]
)

Expected =: cutopen 0 : 0
aaaaaa
aaaaaaaaaa
abbcddde
abbcabbc
abcccbccc
)

3 : 0 (2}. ARGV)
if.
    1 <: # y
do.
    echo decode_str 0{:: y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: decode_str&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs STR" to process string'
    echo 'or   "./ch-1.ijs"     to run the examples'
end.
)

exit ''