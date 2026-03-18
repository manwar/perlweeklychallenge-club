#!/usr/local/bin/jconsole

NB. alpha index repeated digit sum, use as:
NB. m airds string
NB. where m is the number of digit summations
NB. use boxed m to see intermediate results
NB. or _ to proceed to a fixed point
airds =: {{
    alpha =. a. {~ 97+i.26
    ai =. >:@(alpha&i.)
    join =. ;@(8!:0)
    ds =. ":@(+/)@:("."0)
    ".@(ds^:u)@join@:ai@] f.
}}

Examples =: cutopen 0 : 0
5 abc 
2 az 
1 cat 
2 dog 
3 perl 
)

Expected =: (6 9 6 8 6)

3 : 0 (2}. ARGV)
if.
    2 = # y
do.
    k =. ". > {: y
    str =. > {. y
    echo k airds str
elseif.
    0 = # y
do.
    try.
        assert. Expected -: (".@[ airds)&>/@(' '&cutopen)@> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs STR K" to process string and number'
    echo 'or   "./ch-1.ijs"       to run the examples'
end.
)

exit ''