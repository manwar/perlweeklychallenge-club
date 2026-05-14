#!/usr/bin/env perl
use strict;
use warnings;
use v5.10;

sub divide_list {
    my ($list_ref, $n) = @_;
    my @list = @$list_ref;
    my $size = scalar @list;

    return -1 if $n > $size;

    my $base_size = int($size / $n);
    my $remainder = $size % $n;

    my @result;
    my $start = 0;

    for my $i (0 .. $n-1) {
        my $chunk_size = $base_size + ($i < $remainder ? 1 : 0);
        my $end = $start + $chunk_size;
        push @result, [ @list[$start..$end-1] ];
        $start = $end;
    }

    return \@result;
}

# Test cases
my @tests = (
    [ [1,2,3,4,5], 2, [ [1,2,3], [4,5] ] ],
    [ [1,2,3,4,5,6], 3, [ [1,2], [3,4], [5,6] ] ],
    [ [1,2,3], 2, [ [1,2], [3] ] ],
    [ [1,2,3,4,5,6,7,8,9,10], 5, [ [1,2], [3,4], [5,6], [7,8], [9,10] ] ],
    [ [1,2,3], 4, -1 ],
    [ [72,57,89,55,36,84,10,95,99,35], 7, [ [72,57], [89,55], [36,84], [10], [95], [99], [35] ] ],
);

for my $test (@tests) {
    my $result = divide_list($test->[0], $test->[1]);
    my $expected = $test->[2];

    if ($expected == -1) {
        say $$result == -1 ? 'ok' : 'not ok';
    } else {
        # For array comparison
        my $match = 1;
        if (ref $result ne 'ARRAY' || ref $expected ne 'ARRAY' || @$result != @$expected) {
            $match = 0;
        } else {
            for my $i (0 .. $#$result) {
                if (ref $result->[$i] ne 'ARRAY' || ref $expected->[$i] ne 'ARRAY' || @{$result->[$i]} != @{$expected->[$i]}) {
                    $match = 0;
                    last;
                }
                for my $j (0 .. @{$result->[$i]}-1) {
                    if ($result->[$i][$j] ne $expected->[$i][$j]) {
                        $match = 0;
                        last;
                    }
                }
                last unless $match;
            }
        }
        say $match ? 'ok' : 'not ok';
    }
}
