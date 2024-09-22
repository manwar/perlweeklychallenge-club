#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'max';

sub strong_password($password) {
# The minimum number of steps required to make the given string very strong password.

    # Count consecutive characters
    my $cons_count = 0;
    my @c = ( $password =~ /((.)\2{2,})/g );
    for (my $i = 0; $i < $#c; $i++) {
        # For every 3 consecutive characters, we need to replace one
        $cons_count += int( length($c[$i]) / 3 );
    }

    # Additional characters require to make it at least 6 characters
    my $char_count = max( 0, 6 - length($password) );

    # Count the number of missing character types
    my $type_count = 0;
    $type_count++ if $password !~ /[a-z]/;
    $type_count++ if $password !~ /[A-Z]/;
    $type_count++ if $password !~ /[0-9]/;

    # Since the type change can be covered by one of the other required
    #  changes, return the maximum of the two
    my $count = max( $cons_count + $char_count, $type_count );
    say $count;
}

strong_password( $ARGV[0] );