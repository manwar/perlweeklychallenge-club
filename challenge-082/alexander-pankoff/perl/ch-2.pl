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

Given three strings <A>, <B> and <C> this script will return whether <C> can be
created by interleaving <A> and <B>

=head1 USAGE

ch-2.pl <A> <B> <C>

=cut

pod2usage(
    -message  => "$0: Need exactly three arguments",
    -exitval  => 1,
    -verbose  => 99,
    -sections => "USAGE|SYNOPSIS",
) if @ARGV != 3;

my ( $A, $B, $C ) = @ARGV;
say is_creatable_by_interleaving( $C, $A, $B );

sub is_creatable_by_interleaving ( $target, $a, $b ) {
    return 0 if length($target) != length($a) + length($b);
    return 1 if !length($target);

    my $head = substr( $target, 0, 1 );
    my $rest = substr( $target, 1 );

    return (
          starts_with( $head, $a )
        ? is_creatable_by_interleaving( $rest, substr( $a, 1 ), $b )
        : 0
      )
      || (
          starts_with( $head, $b )
        ? is_creatable_by_interleaving( $rest, $a, substr( $b, 1 ) )
        : 0
      );
}

sub starts_with ( $char, $str ) {
    return $str =~ m/^$char/;
}
