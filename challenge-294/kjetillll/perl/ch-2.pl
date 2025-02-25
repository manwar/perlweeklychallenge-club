# https://theweeklychallenge.org/blog/perl-weekly-challenge-294/
# Next lexicographically greater permutation
# Adapted Fischer-Krause algorithm from https://perldoc.perl.org/perlfaq4

use strict; use warnings;

sub next_permutation {
    my @a = @_;
    my $p = $#a || return;
    --$p or return while $a[ $p - 1 ] > $a[ $p ];
    push @a, reverse splice @a, my $q = $p;
    ++$q while $a[ $p - 1 ] > $a[ $q ];
    @a[ $p - 1, $q ] = @a[ $q, $p - 1 ];
    @a
}

print join ' ', next_permutation(@ARGV),"\n" and exit if @ARGV;

for my $test (
    [ [1, 2, 3]           => [1, 3, 2] ],
    [ [2, 1, 3]           => [2, 3, 1] ],
    [ [3, 1, 2]           => [3, 2, 1] ],
    [ [3, 2, 1]           => [] ],
    [ [6,3,9,8,7,5,4,2,1] => [6,4,1,2,3,5,7,8,9] ],
    [ [9,5,6,1,8,7,4,3,2] => [9,5,6,2,1,3,4,7,8] ],
    [ [17,22,16,6,11,23,12,4,19,14,13,18,25,1,7,24,21,20,15,10,9,8,5,3,2]
   => [17,22,16,6,11,23,12,4,19,14,13,18,25,1,8,2,3,5,7,9,10,15,20,21,24] ],
){
    my($input,$expected) = @$test;
    my @got = next_permutation( @$input );
    printf"%-5s   input:    %-20s\n        expected: %s\n        got:      %s\n\n",
        "@$expected" eq "@got" ? 'ok' : 'error',
        "@$input",
        "@$expected",
        "@got",
}
