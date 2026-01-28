#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'mesh';

sub main ( $input_string, $i ) {
    # Make sure i is in the range 0 - 25.
    $i %= 26;

    if ( $i == 0 ) {
        # Short cut if there is no transformation required
        say $input_string;
        return;
    }

    # Create mapping of old and new letters
    my @old_letters = my @new_letters = ( "a" .. "z" );
    push @new_letters, splice( @new_letters, 0, $i );

    push @old_letters, map { uc } @old_letters;
    push @new_letters, map { uc } @new_letters;
    my %mapping = mesh \@old_letters, \@new_letters;

    # Print the "encrypted" string
    say join "", map { $mapping{$_} // $_ } split //, $input_string;
}

main(@ARGV);
