#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub remove_one(@ints) {
    my @fails = grep $ints[ $_ - 1 ] >= $ints[$_], 1 .. $#ints;

    return ! @fails if 1 != @fails;

    # We can remove the first or last int.
    return 1 if $fails[0] == 1 || $fails[0] == $#ints;

    return 1
        # Remove the lesser number (0 from 6 12 [0] 18)
        if $fails[0] < $#ints && $ints[ $fails[0] - 1 ] < $ints[ $fails[0] + 1 ]
        # Remove the previous number (9 from 2 9 [4] 6)
        || $fails[0] > 1 && $ints[ $fails[0] - 2 ] < $ints[ $fails[0] ];

    return
}

sub remove_one_brute_force(@ints) {
  REMOVE:
    for my $i (0 .. $#ints) {
        my @copy = @ints;
        splice @copy, $i, 1;
        for my $j (1 .. $#copy) {
            next REMOVE if $copy[ $j - 1 ] >= $copy[$j];
        }
        return 1
    }
    return
}

use Test::More tests => 3 + 5;

ok remove_one(0, 2, 9, 4, 6), 'Example 1';
ok ! remove_one(5, 1, 3, 2), 'Example 2';
ok remove_one(2, 2, 3), 'Example 3';

ok remove_one(6, 12, 0, 18), 'Remove the lesser number';
ok remove_one(5, 1, 2, 3), 'First';
ok remove_one(1, 2, 3, 0), 'Last';
ok ! remove_one(0, 2, 9, 1, 6), 'Two removals needed';

use Benchmark qw{ cmpthese };
my @ints = map int(rand(200)), 1 .. 40;
is ! remove_one_brute_force(@ints), ! remove_one(@ints), 'Long';
cmpthese(-3, {
    brute_force => sub { remove_one_brute_force(@ints) },
    optimized   => sub { remove_one(@ints) },
});

__END__
                Rate brute_force   optimized
brute_force  16188/s          --        -90%
optimized   157390/s        872%          --
