#!/usr/local/bin/jconsole

spaces =. +/@:(' '&=)
gaps =. <:@#
divmod =. ((0: , ])`(<.@%~ , |)@.(0&<@[))
spbx =. <@(#&' ')
insert =. >@{:@] ,~ >@{.@] joinstring [
rearrange =: cutopen ([ insert [: spbx"0 gaps@[ divmod spaces@]) f. ] 

rearrange&.> '  challenge  ';'coding  is  fun';'a b c  d';'  team      pwc  ';'   the  weekly  challenge  '

Examples =: '|' cutopen '  challenge  |coding  is  fun|a b c  d|  team      pwc  |   the  weekly  challenge  '
Expected =: '|' cutopen 'challenge    |coding  is  fun|a b c d |team          pwc|the    weekly    challenge '

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo rearrange&.> {. y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: rearrange&.> Examples
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