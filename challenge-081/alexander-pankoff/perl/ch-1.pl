#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use autodie;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(any);

my ( $A, $B ) = @ARGV;
$A //= "";
$B //= "";

say '(' . join( ', ', map { quote($_) } common_base_strings( $A, $B ) ) . ')';

sub common_base_strings ( $a, $b ) {
    return intersection( [ base_strings($a) ], [ base_strings($b) ] );
}

# finds all base strings of str
sub base_strings($str) {
    my @candidates =
      map { substr( $str, 0, $_ ) } 1 .. length($str);
    return grep { is_base_string( $_, $str ) } @candidates;
}

sub is_base_string ( $base, $str ) {
    return $str =~ /^($base)+$/;
}

# returns a list of elems from $a that are also in $b
sub intersection ( $a, $b ) {
    grep {
        my $a_elem = $_;
        any { $_ eq $a_elem } @$b;
    } @$a;
}

sub quote($str) {
    return '"' . $str . '"';
}
