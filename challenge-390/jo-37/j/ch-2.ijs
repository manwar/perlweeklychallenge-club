#!/usr/local/bin/jconsole

NB. find lexicographically smallest result
NB. of applying permitted moves specified by x on y
order_characters =: _(adverb define)
  NB. find the lexicographically smallest from
  NB. all rotations of y
  min_rot =. [: {. [: /:~ i.@# |."0 _ ]

  NB. if x > 1: sort y
  NB. otherwise apply "min_rot"
  [: : ((min_rot@])`(/:~@])@.(1&<@[) f.)
)

Examples =: cutopen L:0 cutopen 0 : 0
dbca 1
geeks 2
cbaed 3
fedcba 4
perl 1
oloolooo 1
oloooolo 1
)

Expected =: cutopen 0 : 0
adbc
eegks
abcde
abcdef
erlp
looloooo
looloooo
)

3 : 0 (2}. ARGV)
if.
    1 <: # y
do.
    echo (". 1 {:: y) order_characters 0 {:: y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: (".@] order_characters [)&>/&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-2.ijs STR K" to process string and number'
    echo 'or   "./ch-2.ijs"       to run the examples'
end.
)

exit ''