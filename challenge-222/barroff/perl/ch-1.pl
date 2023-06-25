#!/usr/bin/env perl

use v5.36;
use strict;
use warnings;

use experimental qw(switch);

use List::Util qw( uniq );

sub last_member (@numbers) {
    return 0 unless @numbers;
    return $numbers[0] if @numbers == 1;
    my @sorted_numbers = sort { $a < $b } @numbers;
    $sorted_numbers[0] == $sorted_numbers[1]
      ? last_member( @sorted_numbers[ 2 .. -1 ] )
      : last_member( @sorted_numbers[ 2 .. -1 ],
        $sorted_numbers[0] - $sorted_numbers[1] );
}

sub last_member2 (@numbers) {
    given ( scalar @numbers ) {
        when ( $_ == 0 ) { return 0 }
        when ( $_ == 1 ) { return $numbers[0] }
        default {
            my @sorted_numbers = sort { $a < $b } @numbers;
            return $sorted_numbers[0] == $sorted_numbers[1]
              ? last_member( @sorted_numbers[ 2 .. -1 ] )
              : last_member( @sorted_numbers[ 2 .. -1 ],
                $sorted_numbers[0] - $sorted_numbers[1] );
        }
    }
}

#| Run test cases
sub MAIN() {
    use Test2::V0 qw( is plan );
    plan 6;

    is last_member( 2, 7, 4, 1, 8, 1 ), 1, 'works for (2, 7, 4, 1, 8, 1)';
    is last_member(1),                  1, 'works for (1)';
    is last_member( 1, 1 ),             0, 'works for (1, 1)';

    is last_member2( 2, 7, 4, 1, 8, 1 ), 1, 'works for (2, 7, 4, 1, 8, 1)';
    is last_member2(1),                  1, 'works for (1)';
    is last_member2( 1, 1 ),             0, 'works for (1, 1)';
}

MAIN();
