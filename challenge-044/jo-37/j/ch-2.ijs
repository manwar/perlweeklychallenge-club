#!/usr/local/bin/jconsole

make_it_long =: ([: |. ] , {{ (] [ 1 Z: 1&=) y }} F: (-:`<:@.(2&|))) : [:
make_it_short =: <:@<.@(2&^.) + [: +/ #: : [:

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo make_it_long ". 0 {:: y
    echo make_it_short ". 0 {:: y
else.
    echo 'Call "./ch-2.ijs N" to process number'
end.
)

exit ''