#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

{   my %STEP = (U => [0, -1],
                D => [0, 1],
                L => [-1, 0],
                R => [1, 0]);
    sub meeting_point_coord($path) {
        my ($x, $y) = (0, 0);
        for my $step (split //, $path) {
            $x += $STEP{$step}->[0];
            $y += $STEP{$step}->[1];
            return 1 if 0 == $x && 0 == $y;
        }
        return
    }
}

sub meeting_point($path) {
    my %distance = map +($_ => 0), qw( U D L R );
    for my $step (split //, $path) {
        ++$distance{$step};
        return 1 if $distance{U} == $distance{D}
                 && $distance{L} == $distance{R};
    }
    return
}

use Test2::V0 -no_srand;
plan(2 * 5 + 2);

use constant {
    true  => bool(1),
    false => bool(0)};

for my $test ([\&meeting_point, 'hash'], [\&meeting_point_coord, 'coord']) {
    is $test->[0]('ULD'), false, 'Example 1 ' . $test->[1];
    is $test->[0]('ULDR'), true, 'Example 2 ' . $test->[1];
    is $test->[0]('UUURRRDDD'), false, 'Example 3 ' . $test->[1];
    is $test->[0]('UURRRDDLLL'), true, 'Example 4 ' . $test->[1];
    is $test->[0]('RRUULLDDRRUU'), true, 'Example 5 ' . $test->[1];
}

# Interestingly, using coordinates is faster for shorter paths, while
# the hash approach is faster for longer strings.
use Benchmark qw{ cmpthese };
for my $path('UULLDDRR', 'UULLDR' x 250) {
    my $mp = meeting_point($path);

    is $mp, meeting_point_coord($path),
        'Same length(' . length($path) . ') ' . ($mp ? 1 : 0);

    cmpthese(-3, {
        hash  => sub { meeting_point($path) },
        coord => sub { meeting_point_coord($path) }
    });
}
