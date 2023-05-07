#!/usr/bin/env perl

use v5.36;
use strict;
use warnings;

sub count_places ($zeros) {
    return int( ( length($zeros) - 1 ) / 2 );
}

sub number_placement ( $count, @numbers ) {
    my $joined_numbers = join '', @numbers;
    my @captures       = $joined_numbers =~ m/ (0+) /gx;
    return List::Util::sum( map( &count_places($_), @captures ) ) >= $count
      ? 1
      : 0;
}

#| Run test cases
sub MAIN() {
    use Test2::V0 qw( is plan );
    plan 4;

    is number_placement( 1, ( 1, 0, 0, 0, 1 ) ), 1, 'works for 1, (1,0,0,0,1)';
    is number_placement( 2, ( 1, 0, 0, 0, 1 ) ), 0, 'works for 2, (1,0,0,0,1)';
    is number_placement( 3, ( 1, 0, 0, 0, 0, 0, 0, 0, 1 ) ), 1,
      'works for 3, (1,0,0,0,0,0,0,0,1)';
    is number_placement( 4, ( 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1 ) ), 1,
      'works for 4, (1,0,0,0,0,0,0,0,1,0,0,0,1)';
}

MAIN();
