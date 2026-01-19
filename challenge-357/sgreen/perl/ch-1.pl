#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($int) {
    if ( $int < 1 or $int > 9999 or $int % 1111 == 0 ) {
        say -1;
        return;
    }

    my $count = 0;
    while ( $int != 6174 ) {
        my $small_number =
          join( "", sort { $a <=> $b } ( split //, sprintf( "%04d", $int ) ) );
        my $big_number = reverse($small_number);
        $int = $big_number - $small_number;
        $count++;
    }

    say $count;
}

main($ARGV[0]);