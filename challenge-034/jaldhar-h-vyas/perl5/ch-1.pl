#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub pick {
    my @range = @{$_[0]};
    my $quantity = $_[1];

    if ($quantity < 1 || $quantity > scalar @range) {
        die "out of range\n";
    }

    my @picked;

    for my $i (0 .. $quantity) {
        my $try = q{ };
        while ($try eq q{ }) {
            $try = $range[int(rand(scalar @range))];
        }
        @range = map { $_ eq $try ? q{ } : $_; } @range;
        push @picked, $try;
    }

    return wantarray ? @picked : $picked[0];
}

sub binarySearch {
    my @haystack = @{$_[0]};
    my $needle = $_[1];

    if (@haystack && scalar @haystack) {
        my $mid = int (scalar @haystack / 2); 

        if ($needle eq $haystack[$mid]) { 
            return 1;
        }

        if ($needle gt $haystack[$mid]) {
            return binarySearch([@haystack[$mid + 1 .. scalar @haystack - 1]],
                $needle);
        } 

        return binarySearch([@haystack[0 .. $mid - 1]], $needle);
    }

    return undef;
}

my @letters = ('a' .. 'z');
my @haystack = pick([@letters], scalar @letters / 2);
my $needle = pick([@letters], 1);
say "is $needle in ", (join q{}, @haystack), '?';
say binarySearch([sort @haystack], $needle) ? 'Yes.' : 'No.';

