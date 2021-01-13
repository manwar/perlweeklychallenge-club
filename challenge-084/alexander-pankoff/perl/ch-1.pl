#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use Scalar::Util qw(looks_like_number);

use Pod::Usage;

use constant SIGNED_32_BIT_INTEGER_MINIMUM => -2**31;
use constant SIGNED_32_BIT_INTEGER_MAXIMUM => 2**31 - 1;

my ($N) = @ARGV;

pod2usage(
    -message => "$0: Expects one integer number",
    -exitval => 1,
  )
  if !defined $N
  or $N !~ m/^-?[0-9]+/;

say reverse_integer($N);

sub reverse_integer($n) {
    my $is_negative = $n =~ s/^-//;

    my $reversed =
      join( '', ( $is_negative ? '-' : '' ), reverse( split( //, $n ) ) );

    return 0
      if $reversed < SIGNED_32_BIT_INTEGER_MINIMUM
      || $reversed > SIGNED_32_BIT_INTEGER_MAXIMUM;

    return $reversed;
}

=pod

=head1 NAME

wk-084 ch-1 - Reverse Integer

=head1 SYNOPSIS

This script will print the reverse of the given integer. If the result doesn't
fit into a signed 32-bit integers the result will be 0

ch-1.pl <N>

=head1 ARGUMENTS

=over 8

=item B<N> The input number


=back

=cut
