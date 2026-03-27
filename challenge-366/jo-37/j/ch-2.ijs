#!/usr/local/bin/jconsole

require 'regex'

count_valid =: {{
splittime =. ((2 4 0 0)"_ ^:(-.@*@#)@('^([0-2?])([0-9?]):([0-5?])([0-9?])$'&([: _1&".@>@}.@, rxmatches rxfrom ])))
join_h =. (10&*@[ + _31"_^:(0&>@]))/@:(2&{.) , 2&}.
cnt_h =. {&(24 10 4 3 2 1 0)@((_41 _21 _11 _7 _1 23)&I.)
cnt_m1 =. {&(6 1)@(0&<:)
cnt_m2 =. {&(10 1)@(0&<:)
*/@:(cnt_h`cnt_m1`cnt_m2 "0)@join_h@splittime y
}}

Examples =: cutopen 0 : 0
?2:34
?4:?0
??:??
?3:45
2?:15
)

Expected =: (3;12;1440;3;4)

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo count_valid > {.y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: count_valid&.> Examples
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