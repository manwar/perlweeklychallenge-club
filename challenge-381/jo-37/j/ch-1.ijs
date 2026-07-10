#!/usr/local/bin/jconsole

same_row_col =: _(adverb define)
   NB. append transposed matrix to itself
   append_tr =. ([ , |:)

   NB. test if items of left arg are
   NB. contained in rows of right arg
   in_row =. e."1

   NB. numbers 1 ... n
   nums =. >:@i.@#

   NB. flatten to 1-d
   ravel =. ,

   NB. logical AND over all items
   all =. *./

   NB. append transposed matrix, test sequence
   NB. 1 ... n in each row, flatten to 1-d and
   NB. test if all items are one
   ([: all [: ravel nums in_row append_tr) f. : [:
)

Examples =: ". L:0 cutopen 0 : 0
4 4 $ 1 2 3 4 2 3 4 1 3 4 1 2 4 1 2 3
1 1 $ 1
3 3 $ 1 2 5 5 1 2 2 5 1
3 3 $ 1 2 3 1 2 3 1 2 3
3 3 $ 1 2 3 3 1 2 3 2 1 
)

Expected =: 1; 1; 0; 0; 0

3 : 0 (2}. ARGV)
if.
    1 <: # y
do.
    echo same_row_col ". S:0 y
elseif.
    0 = # y
do.
    try.
        assert Expected -: same_row_col&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs ROW..." to process matrix'
    echo 'or   "./ch-1.ijs"        to run the examples'
end.
)

exit ''