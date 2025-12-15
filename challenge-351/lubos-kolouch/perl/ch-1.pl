#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use List::Util      qw(min max sum0);
use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Num);

=pod

=head1 NAME

ch-1.pl - Special Average

=head1 SYNOPSIS

  perl ch-1.pl 8000 5000 6000 2000 3000 7000
  perl ch-1.pl                       # runs the embedded tests

=head1 DESCRIPTION

Computes the average of the given integers after excluding every occurrence of
the minimum and maximum values. If removing the extremes leaves no elements,
the function returns C<0>, matching the examples in the challenge statement.

=cut

my $LIST_CHECK = compile( ArrayRef[Num] );

sub special_average ($ints) {
    ($ints) = $LIST_CHECK->($ints);
    return 0 unless @$ints;

    my $min = min(@$ints);
    my $max = max(@$ints);
    return 0 if $min == $max;

    my $min_count = grep { $_ == $min } @$ints;
    my $max_count = grep { $_ == $max } @$ints;

    my $remaining = @$ints - $min_count - $max_count;
    return 0 if $remaining <= 0;

    my $total = sum0(@$ints) - ( $min * $min_count ) - ( $max * $max_count );
    return $total / $remaining;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    my @ints = map { 0 + $_ } @args;
    my $avg  = special_average( \@ints );
    say 'Input:  @ints = (' . join( ', ', @ints ) . ')';
    say "Output: $avg";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ints => [ 8000, 5000, 6000, 2000, 3000, 7000 ], expected => 5250 },
        { label => 'Example 2', ints => [ 100_000, 80_000, 110_000, 90_000 ],   expected => 95_000 },
        { label => 'Example 3', ints => [ (2500) x 4 ],                          expected => 0 },
        { label => 'Example 4', ints => [2000],                                  expected => 0 },
        { label => 'Example 5', ints => [ 1000, 2000, 3000, 4000, 5000, 6000 ],  expected => 3500 },
    );

    Test::More::plan( tests => scalar @cases );

    for my $case (@cases) {
        my $got = special_average( $case->{ints} );
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 special_average($ints)

Accepts an array reference of numbers and returns the average after removing
all values equal to the minimum or maximum of the array. Returns C<0> when no
values remain after the removal.

=cut
