#!/usr/local/bin/jconsole

p =. 1 _1; 1 1; _1 _1
Mountain =: (+./@{. *. *./@(+./))@(p&(e."(1 0)~))@(2&(<\))@:*@(2&(-~/\))

NB. numerize and listify inside boxes
examples =: ".&.> cutopen 0 : 0
1 2 3 4 5
0 2 4 6 4 2 0
5 4 3 2 1
1 3 5 5 4 2
1 3 2
)

3 : 0 (> ".&.> 2}. ARGV)
if.
    1 <: # y
do.
    echo Mountain y
elseif.
    0 = # y
do.
    try.
        assert. (0; 1; 0; 0; 1) -: Mountain &.> examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs N..." to process numbers'
    echo 'or   "./ch-1.ijs"      to run the examples'
end.
)

exit^:(0&>@(4!:0) <'noexit') ''
