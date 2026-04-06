use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str) {
    my $ones = () = $str =~ /1/gi;
    my $zeros = () = $str =~ /0/gi;
    return "1" x ($ones - 1) . "0" x $zeros . "1";
}

is(run("1011"),   "1101",   'Example 1');
is(run("100"),    "001",    'Example 2');
is(run("111000"), "110001", 'Example 3');
is(run("0101"),   "1001",   'Example 4');
is(run("1111"),   "1111",   'Example 5');
