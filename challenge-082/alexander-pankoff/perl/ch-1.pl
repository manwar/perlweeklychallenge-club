#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use autodie;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use Pod::Usage;

use List::Util qw(min all any);
use Scalar::Util qw(looks_like_number);

=pod

=head1 SYNOPSIS

This Script will print a list of common factors from M and N

=head1 USAGE

ch-1.pl <M> <N>

=cut

pod2usage(
    -message  => "$0: Expects 2 postive numbers",
    -exitval  => 1,
    -verbose  => 99,
    -sections => "USAGE|SYNOPSIS",
  )
  if @ARGV != 2
  or any { !looks_like_number($_) || $_ < 1 } @ARGV;

my ( $M, $N ) = @ARGV;
say format_list( common_factors( $M, $N ) );

sub common_factors ( $m, $n ) {
    grep {
        my $check_factor = $_;
        all { is_factor( $check_factor, $_ ) } ( $m, $n );
    } 1 .. min( $m, $n );
}

sub is_factor ( $divisor, $value ) {
    return $value % $divisor == 0;
}

sub format_list(@list) {
    return '(' . join( ', ', @list ) . ')';
}

