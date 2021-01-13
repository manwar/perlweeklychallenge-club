#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use autodie;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use Pod::Usage;

use List::Util qw(min all any pairs);
use Scalar::Util qw(looks_like_number);

pod2usage(
    -message => "$0: Need exactly three arguments",
    -exitval => 1,
) if @ARGV != 3;

my ( $A, $B, $C ) = @ARGV;

say is_creatable_by_interleaving( $C, $A, $B ) ? 1 : 0;

sub is_creatable_by_interleaving ( $target, $a, $b ) {

    # first check whether the total lenght of $a and $b match with the target
    # length
    return 0 if length($target) != length($a) + length($b);

    # we now check wether any of $a or $b starts with the same char as $target
    # if so, we recurse with the rest of $target and the matching item to
    # check the remaining input.
    # otherwise we can't find a way to interleave $a and $b to make $target
    #
    # to prevent checking the length condition above in every recursive case we
    # define a helper without that check. since we consume the input charwise
    # and pairwise, either from $target and $a or from $target and $b that
    # condition won't change
    my $go;
    $go = sub ( $target, $a, $b ) {
        # base case. we consumed all inputs - $target is $a and $b interleaved
        # since we already made sure that the total lengths match up we only
        # need to check wether $target became empty here.
        return 1 if !length($target);

        my $head = substr( $target, 0, 1 );
        my $rest = substr( $target, 1 );

        # the order of $a and $b in the recursice call doesn't matter
        # so we can just run the same routine on (a,b) and (b,a) instead of
        # using two routines with the arguments flipped
        return any(
            sub {
                starts_with( $_->[0], $head )
                  && $go->( $rest, substr( $_->[0], 1 ), $_->[1] );
            },
            pairs( $a, $b, $b, $a )
        );

    };

    $go->( $target, $a, $b );
}

sub starts_with ( $str, $char ) {
    return $str =~ m/^$char/;
}

=pod

=head1 NAME

wk-082 ch-2 - Interleave String

=head1 SYNOPSIS

Given three strings <A>, <B> and <C> this script prints whether <C> can be
created by interleaving <A> and <B>

ch-2.pl <A> <B> <C>

=head1 ARGUMENTS

=over 8

=item B<A> The first input string

=item B<B> The first input string

=item B<C> The target string

=back

=cut
