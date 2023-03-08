#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

my @keyboard_rows = qw(qwertyuiop asdfghjkl zxcvbnm);
my %keyboard_map;

# Create a hash map to store the keyboard layout
for my $i ( 0 .. 2 ) {
    my $row = $keyboard_rows[$i];
    $keyboard_map{$_} = $i + 1 for split( '', $row );
}

# Function to check if a word can be typed using only one row of the keyboard
sub is_single_row_word {
    my ($word) = @_;
    my $row = $keyboard_map{ lc( substr( $word, 0, 1 ) ) };
    for my $c ( split( '', lc($word) ) ) {
        return 0 if $keyboard_map{$c} != $row;
    }
    return 1;
}

# Test example 1
my @words1            = ( "Hello", "Alaska", "Dad", "Peace" );
my @single_row_words1 = grep { is_single_row_word($_) } @words1;
is_deeply( \@single_row_words1, [ "Alaska", "Dad" ], "Example 1" );

# Test example 2
my @words2            = ( "OMG", "Bye" );
my @single_row_words2 = grep { is_single_row_word($_) } @words2;
is_deeply( \@single_row_words2, [], "Example 2" );

done_testing();
