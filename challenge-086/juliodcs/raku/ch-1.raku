#! /usr/bin/raku

sub diff_pair($a, @n, $i = 0) {
    return 0 if $i > @n.elems - 1;
    return 1 if @n[$i+1 .. *].grep: { abs(@n[$i] - $_) == $a };
    return diff_pair $a, @n, $i+1;
}

if @*ARGS.elems > 0 {
    say diff_pair @*ARGS[0], @*ARGS[1 .. *];
    exit 0;
}

use Test;

ok  diff_pair(7, [10, 8, 12, 15, 5]), 'test1';
ok  diff_pair(6, [1, 5, 2, 9, 7]), 'test2';
ok !diff_pair(6, [10, 30, 20, 50, 40]), 'test3';

done-testing;
