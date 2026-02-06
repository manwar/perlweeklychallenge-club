#!/usr/local/bin/jconsole

Rle =: ([: (#@> ; <@:({.@>)) ] </.~ [: +/\. [: -. 1 ,~ 2&(-:/\))
reducelist =: (#~ 2&|)~&>/@Rle (^:^:_) (*@#)

Examples =: 'aabbccdd'; 'abccba'; 'abcdef'; 'aabbaeaccdd'; 'mississippi'
Expected =: ''; ''; 'abcdef'; 'aea'; ('m','')
]Tests =: (< 5 2 $ 1 2 1 2 3 4 3 4 5 6), (< 'a'; 'ab'; 'abc'; 'abc'; 'ab'; 'abcd'), (<'abcccba')
]TExp =: (< 1 2 $ 5 6), (<'a';'abcd'), (<'abcba')
3 : 0 (2}. ARGV)
if.
    1 <: # y
do.
    
elseif.
    0 = # y
do.
    try.
        assert. Expected -: reducelist&.> Examples
        echo Tests
        echo reducelist&.> Tests
        assert. TExp -: reducelist&.> Tests
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