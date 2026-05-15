#!/usr/local/bin/jconsole

list_division =: _(adverb define)
   seq =. i.@[
   divmod =. #@] #:~ 0 , [
   slot =. [: <@(#~)`+`>/ ] , [ , ]
   raze =. ;
   box_by =. </.~
   chunk =: ] box_by [: raze divmod slot"1 0 seq
   empty =. (0$0)"_
   if_valid =. @.([: {. [ > #@])

   [: : chunk`empty if_valid f.
)

Examples =: ; L:1 ". L:0 cutopen L:0 '|'&cutopen L:0 cutopen 0 : 0
2|1 2 3 4 5
3|1 2 3 4 5 6
2|1 2 3
5|1 2 3 4 5 6 7 8 9 10
4|1 2 3
7|72 57 89 55 36 84 10 95 99 35
)

Expected =: ; L:1 ". L:0 cutopen L:0 '|'&cutopen L:0 (<;._2) 0 : 0
1 2 3|4 5
1 2|3 4|5 6
1 2|3
1 2|3 4|5 6|7 8|9 10

72 57|89 55|36 84|10|95|99|35
)

3 : 0 (2}. ARGV)
if.
    1 < # y
do.
    echo ((_1:)^:(-.@*@#))@(>@{. list_division >@}.)@(". L:0) y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: list_division&>/&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs N L..." to divide list'
    echo 'or   "./ch-1.ijs"        to run the examples'
end.
)

exit ''