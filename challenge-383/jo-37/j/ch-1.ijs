#!/usr/local/bin/jconsole

similar_lists =: _(adverb define)
   NB. does y contain exactly one unique item?
   singleton =. 1&= @ # @ ~.

   NB. open boxed lists of boxed strings and transpose these
   NB. set missing items to "boxed space"
   open_cols =. |: @: (>!.(<' '))

   NB. test if items from y are contained in x
   in =. e.~

   any =. +./
   all =. *./

   NB. use  "x u1`u2 if v y" to apply "x u2 y" when "x v y" is true,
   NB. or "x u1 y" otherwise
   if =. @.

   true =. 1:

   NB. check if there is a row in x that
   NB. contains all items of y
   common_superset =. any @: (all rows) @: (in rows)

   NB. for each column from y check if it is a singleton
   NB. or if has a common superset in x
   NB. this must be true for all columns
   [: : (>@[ all @: (common_superset`true if (singleton@])"_ 1) open_cols@]) f.
)

Examples =: cutopen L:0 ';' cutopen L:0 '|' cutopen L:0 cutopen 0 : 0
great acting;fine drama|great fine;acting drama
apple pie;banana pie|apple peach;peach banana
perl4 python;raku python|perl4 perl5 raku
enjoy challenge;love weekly challenge|enjoy love
fast car;quick vehicle|quick fast;vehicle car
)

Expected =: 1;0;1;0;1

NB. word list: 'w11 w12...;w21 w22...'
NB. similarites: 's11 s12...;s21 s22...'
3 : 0 (cutopen L:0 @ (';'&cutopen L:0) @ (2&}.) ARGV)
if.
    2 = # y
do.
    echo y
    echo similar_lists~&>/ y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: similar_lists~&>/ &.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs L S" to process word lists and similarities'
    echo 'or   "./ch-1.ijs"     to run the examples'
end.
)

exit ''