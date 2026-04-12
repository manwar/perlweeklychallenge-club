#!/usr/local/bin/jconsole

remove =: {. , >:@[ }. ] NB. remove item at index x from y
shl =: 1&(|.!.0)  NB. shift left, insert zero
idx =: i:~ <. 1 i.~ = *. shl@] > ] NB. find first index of x in y preceding a larger number
                                   NB. or the index of the last ocurrence of x in y 
bigger =: idx remove ]
todigits =: 10&#.^:_1 NB. convert number to list of decimal digits

Examples =: 5 15456; 3 7332; 2 2231; 5 543251; 1 1921
Expected =: 1546; 732; 231; 54321; 921

3 : 0 (2}. ARGV)
if.
    2 = # y
do.
    echo bigger&.(a:`todigits)/ ". > y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: bigger&.(a:`todigits)/&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs DIGIT NUM" to process numbers'
    echo 'or   "./ch-1.ijs"           to run the examples'
end.
)

exit ''