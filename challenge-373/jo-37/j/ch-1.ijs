#!/usr/local/bin/jconsole

equal_list =: -:&;

Examples =: <;._1 L:0 '|'&cutopen L:0 cutopen 0 : 0
 a bc| ab c
 a b c| a bc
 a bc| a c b
 ab c |  a bc
 p e r l| perl
)
Expected =: 1; 1; 0; 1; 1

3 : 0 (2}. ARGV)
if.
    2 = # y
do.
    echo equal_list&>/ <;._1 L:0 ' '&, L: 0 y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: equal_list&>/&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs A1 A2" to process arrays'
    echo 'where arrays are space separated strings'
    echo 'two adjacent spaces procuce an empty string'
    echo 'or   "./ch-1.ijs"           to run the examples'
end.
)

exit ''