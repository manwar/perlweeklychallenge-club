#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use List::Util      qw(max);
use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int Str);

=pod

=head1 NAME

ch-1.pl - Ones and Zeroes

=head1 SYNOPSIS

  perl ch-1.pl 5 3 10 0001 111001 1 0
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a list of binary strings and limits for the number of 0s (x) and 1s (y),
find the size of the largest subset whose total counts of 0s and 1s do not
exceed the limits.

This is a 0/1 knapsack over (zeros, ones) with value 1 per string.

=cut

my $ARGS_CHECK = compile( Int, Int, ArrayRef [Str] );

sub ones_and_zeroes ($x, $y, $strs) {
    ( $x, $y, $strs ) = $ARGS_CHECK->( $x, $y, $strs );
    die 'Expected non-negative limits' if $x < 0 || $y < 0;

    my @dp;
    for my $i ( 0 .. $x ) {
        $dp[$i] = [ (0) x ( $y + 1 ) ];
    }

    for my $s (@$strs) {
        die 'Expected binary strings' if $s =~ /[^01]/;
        my $zeros = ( $s =~ tr/0// );
        my $ones  = length($s) - $zeros;

        for ( my $i = $x; $i >= $zeros; --$i ) {
            for ( my $j = $y; $j >= $ones; --$j ) {
                my $candidate = $dp[$i - $zeros][$j - $ones] + 1;
                $dp[$i][$j] = $candidate if $candidate > $dp[$i][$j];
            }
        }
    }

    return $dp[$x][$y];
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <x> <y> <bin1> [bin2...]\n" if @args < 3;
    my $x = shift @args;
    my $y = shift @args;
    my $out = ones_and_zeroes( 0 + $x, 0 + $y, \@args );
    say 'Output: ' . $out;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label => 'Example 1',
            str   => [ '10', '0001', '111001', '1', '0' ],
            x     => 5,
            y     => 3,
            expected => 4,
        },
        {
            label => 'Example 2',
            str   => [ '10', '1', '0' ],
            x     => 1,
            y     => 1,
            expected => 2,
        },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = ones_and_zeroes( $case->{x}, $case->{y}, $case->{str} );
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 ones_and_zeroes($x, $y, $strs)

Returns the maximum subset size with at most C<$x> zeros and C<$y> ones.

=cut
