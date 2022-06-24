#!/usr/bin/env perl

use strict;
use warnings;
use experimental 'signatures';
use feature 'say';

use List::Util 'max';
use YAML 'LoadFile';

sub check_array ($a) {
    # Check that all rows in the array are the same length
    foreach my $i ( 1 .. $#$a ) {
        if ( scalar( @{ $a->[0] } ) != scalar( @{ $a->[$i] } ) ) {
            die "mismatched array width";
        }
    }

    return $a;
}

sub make_row ( $values1, $values2 ) {
    # Given two arrays, multiple the first value by each of the second values
    my @row = ();
    foreach my $value (@$values1) {
        push @row, map { $value * $_ } @$values2;
    }
    return \@row;
}

sub main ($file_name) {
    # Read the supplied file in YAML format
    my $arrays = LoadFile($file_name);

    if ( scalar(@$arrays) != 2 ) {
        die "Expecting two arrays\n";
    }

    my $array1 = check_array( $arrays->[0] );
    my $array2 = check_array( $arrays->[1] );

    my @solution = ();
    foreach my $row (@$array1) {
        foreach my $second_row (@$array2) {
            push @solution, make_row( $row, $second_row );
        }
    }

    # Format each row uniformly.
    my $max_length = max(
        map {
            max( map { length($_) } @$_ )
        } @solution
    );
    my $fmt = '[' . ( " %${max_length}s" x scalar( @{ $solution[0] } ) ) . " ]\n";

    foreach my $row (@solution) {
        printf $fmt, @$row;
    }
}

main(@ARGV);
