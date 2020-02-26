#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures };
no warnings
  qw{ experimental::postderef experimental::signatures };

my $vals->@* = ( ' + ', ' - ', '' );
my $source->@* = ( 1, '', 2, '', 3, '', 4, '', 5, '', 6, '', 7, '', 8, '', 9 );

challenge( $source, $vals, 1 );

sub challenge ( $source, $vals, $index ) {

    # check to see if this is correct
    if ( $index >= scalar $source->@* ) {
        my $string = join '', $source->@*;
        my $result = eval $string;
        say qq{  $result = $string } if $result == 100;
        return;
    }

    # recursively add to the array
    my $next->@* = map { $_ } $source->@*;
    for my $v ( $vals->@* ) {
        $next->[$index] = $v;
        challenge( $next, $vals, $index + 2 );
    }
    return;
}
exit;
