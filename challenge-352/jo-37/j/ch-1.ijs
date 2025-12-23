#!/usr/local/bin/jconsole

NB. MatchString =: {{~. y #~ 1 < +/"1 +./@E.&>/~ y}}
MatchString =: ~.@(#~ 1&<@(+/"1)@(+./@E.&>/)~)
Examples =: <;._2&.> cutopen 0 : 0
cat cats dog dogcat dogcat rat ratcatdogcat 
hello hell world wor ellow elloworld 
a aa aaa aaaa 
flower flow flight fl fli ig ght 
car carpet carpenter pet enter pen pent 
)

Expected =: <;._2&.> cutopen 0 : 0
cat dog dogcat rat 
hell world wor ellow 
a aa aaa 
flow fl fli ig ght 
car pet enter pen pent 
)

3 : 0 (2}. ARGV)
if.
    1 <: # y
do.
    echo MatchString y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: MatchString &.> Examples
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

exit^:(0&>@(4!:0) <'noexit') ''