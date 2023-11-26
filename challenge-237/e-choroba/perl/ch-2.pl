#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub maximise_greatness(@nums) {
    my @sorted = sort { $a <=> $b } @nums;

    # No greatness at all.
    return 0 if $sorted[0] == $sorted[-1];

    my $count   = 0;
    my $less    = 0;
    my $greater = 1;
    while (1) {
        ++$greater while $greater <= $#sorted
                   && $sorted[$greater] == $sorted[$less];
        last if $greater > $#sorted;

        ++$count if $sorted[$less++] < $sorted[$greater++];
        last if $greater > $#sorted;
    }
    return $count
}

use Algorithm::Combinatorics qw{ permutations };
sub maximise_greatness_brute_force(@nums) {
    my $iter = permutations(\@nums);
    my $max_count = 0;
    while (my $p = $iter->next) {
        my $count = grep $nums[$_] < $p->[$_], 0 .. $#nums;
        $max_count = $count if $count > $max_count;
    }
    return $max_count
}

use Test::More tests => 2 * (2 + 4) + 1;

for my $maximise_greatness (
    \&maximise_greatness, \&maximise_greatness_brute_force
) {

    is $maximise_greatness->(1, 3, 5, 2, 1, 3, 1), 4, 'Example 1';
    is $maximise_greatness->(1, 2, 3, 4), 3, 'Example 2';

    is $maximise_greatness->(1, 1, 1), 0, 'Not great';
    is $maximise_greatness->(1, 1, 2, 2, 2), 2, 'More of the greater ones';
    is $maximise_greatness->(1, 1, 1, 2, 2), 2, 'More of the less ones';
    is $maximise_greatness->(1, 2, 2, 2, 3), 2, 'More of the middle ones';
}

use Benchmark qw{ cmpthese };
my @l = map int rand 7, 1 .. 8;
is maximise_greatness(@l), maximise_greatness_brute_force(@l), "same @l";
cmpthese(-3, {
    brute_force => sub { maximise_greatness_brute_force(@l) },
    optimised   => sub { maximise_greatness(@l) },
});

__END__
                Rate brute_force   optimised
brute_force   8.74/s          --       -100%
optimised   210776/s    2412117%          --
