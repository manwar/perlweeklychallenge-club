#!/usr/local/bin/jconsole

WordSorter =: (' ' joinstring ] /: tolower&.>)@(' ' cutopen ,&' ')

Examples =: cutopen 0 : 0
The quick brown fox
Hello    World!   How   are you?
Hello
Hello, World! How are you?
I have 2 apples and 3 bananas!
)

Expected =: cutopen 0 : 0
brown fox quick The
are Hello How World! you?
Hello
are Hello, How World! you?
2 3 and apples bananas! have I
)

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo WordSorter > {. y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: WordSorter&.> Examples
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