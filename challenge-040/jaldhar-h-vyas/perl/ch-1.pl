#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub Z {
    my $numArrays = scalar @_;

    my @result;

    for my $i (0 .. scalar @{ $_[0] } - 1) {
        my @row;

        for my $j (0 .. $numArrays - 1) {
            push @row, $_[$j]->[$i];
        }

        push @result, \@row;
    }

    return @result;
}

my @array1 = (qw/ I L O V E Y O U /);
my @array2 = (qw/ 2 4 0 3 2 0 1 9 /);
my @array3 = (qw/ ! ? £ $ % ^ & * /);

for my $i (Z(\@array1, \@array2, \@array3)) {
    say join q{ }, @{ $i };
}