#!/usr/local/bin/jconsole

all_and_only =: adverb define
   re =. rxcomp (, (('(?=[', m, ']*?') ,"1 0 m) , "1 ')'), '[', m, ']+'
   substrings =. , @ |: @ (m&(] <\~ (] - i. @ >: @ -~)&#))
   take_all_in =. *./@:(m&e.)@> # ]
   for_every =. L:0
   raze =. ;

   raze @: (take_all_in @ substrings for_every) f. @ (re&rxall) : [:
)

Vowels =: 'aeiou'

Examples =: cutopen 0 : 0
aeiou
aaeeeiioouu
aeiouuaxaeiou
uaeiou
aeioaeioa
)

Expected =: cutopen L:0 <;._2 (0 : 0)
aeiou
aaeeeiioouu aaeeeiioou aeeeiioouu aeeeiioou
aeiouua aeiouu aeiou eiouua aeiou
uaeiou uaeio aeiou

)

3 : 0 (2}. ARGV)
all_and_only_vowels =: Vowels all_and_only
if.
    1 = # y
do.
    echo all_and_only_vowels > 0 { y
elseif.
    2 = # y
do.
    all_and_only_these =. (> 1 { y) all_and_only
    echo all_and_only_these > 0 { y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: all_and_only_vowels&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs STR [CHARS]" to process string [and substring chars]'
    echo 'or   "./ch-1.ijs"             to run the examples'
end.
)

exit ''