#!/usr/local/bin/perl

use v5.10;
use warnings;
use strict;

# assumptions:
# matrix does not have to be square
# spiral is clockwise

sub define_matrix {
    open (INPUT, '<', $_[0]) or die "$!: could not open file $_[0]";
    say "Input:";
    my (@line, @matrix);
    while (<INPUT>) {
        chomp;
        say $_;
        s/\s+//g; # remove any whitespace
        s/\[//;
        s/\]//;
        @line = split /,/, $_;
        push (@matrix, [@line]);
    }
    close (INPUT) or die "$!: could not close file $_[0]";
    return ( @matrix );
}

sub return_spiral {
	my @array = @_;
    my @spiral;
# handle special cases
# just one row
    if (scalar(@array) == 1) {
        return ( @{$array[0]} );
# just one column
    } elsif ( scalar ( @{$array[0]} ) == 1 ) {
        for (my $i = 0; $i < scalar(@array); $i++) {
            push ( @spiral, @{$array[$i]}[0] );
        }
        return ( @spiral );
# we have at least a 2 x 2 array
    } else {
# get first row
        push ( @spiral, @{$array[0]} );
# get right column
        my $right_ci = scalar ( @{$array[0]} ) - 1;
        for (my $y = 1; $y < scalar ( @array ); $y++) {
            push ( @spiral, @{$array[$y]}[$right_ci] );
        }
# remove last element from last row
        pop ( @{$array[$#array]} );
# get last row in reversed order
        push ( @spiral, reverse ( @{$array[$#array]} ) );
# get left column
        for (my $i = ($#array - 1); $i > 0; $i--) {
            push ( @spiral, @{$array[$i]}[0] );
        }
# check if resulting array is empty (i.e. we were originally sent
# just a two-row or two-column array to begin with
        if (scalar( @array ) == 2 || scalar ( @{$array[0]} ) == 2) {
            return ( @spiral );
        } else {
# trim array
# trim top row:
        	shift @array;
# trim bottom row:
        	pop @array;
# remove first and last element from remaining rows
            for (my $i = 0; $i < scalar(@array); $i++) {
                shift ( @{$array[$i]} );
                pop   ( @{$array[$i]} );
            }
            return ( @spiral, &return_spiral(@array) );
        }
    }
}

my @matrix = &define_matrix($ARGV[0]);
my @spiral2 = &return_spiral(@matrix);
say "Output:";
say "[ ", join(", ", @spiral2), " ]";
