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

pod2usage(
    -message => "$0: Expects 2 natural numbers",
    -exitval => 1,
  )
  if @ARGV != 2
  or any { !looks_like_number($_) || $_ < 1 } @ARGV;

my ( $M, $N ) = @ARGV;

say format_list( common_factors( $M, $N ) );

sub common_factors ( $m, $n ) {

    # we grep for numbers from 1 to min($m,$n) that are factors of both $m and
    # $n. since all numbers larger than min($m,$n) can't be a factor of that
    # minimum we don't have to check them
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

=pod

=head1 NAME

wk-082 ch-1 - Common Factors

=head1 SYNOPSIS

Prints the common factors of two given natural numbers M and N

ch-1.pl <M> <N>

=head1 ARGUMENTS

=over 8

=item B<N> The first natural number

=item B<M> The second natural number

=back

=cut
