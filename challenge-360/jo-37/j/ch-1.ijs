#!/usr/local/bin/jconsole

TextJustifier =: ]`((i.@] + [: <. 2 %~ -) #@])`(#&'*'@[) }

Examples =: cutopen 0 : 0
5 Hi 
10 Code 
9 Hello 
4 Perl 
7 A  
)

Expected =: cutopen 0 : 0
*Hi**
***Code***
**Hello**
Perl
***A***
)

3 : 0 (2}. ARGV)
if.
    2 = # y
do.
    l =. ". > {: y
    str =. > {. y
    echo  l TextJustifier^:(l > #str) str
elseif.
    0 = # y
do.
    try.
        assert. Expected -: <@(".@[ TextJustifier ])&>/@(' '&cutopen)@> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs STR L" to process string and length'
    echo 'or   "./ch-1.ijs"       to run the examples'
end.
)

exit ''