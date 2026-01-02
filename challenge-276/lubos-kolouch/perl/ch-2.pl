#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);

=pod

=head1 NAME

ch-2.pl - Maximum Frequency

=head1 SYNOPSIS

  perl ch-2.pl 1 2 2 4 1 5
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given an array of positive integers, return the total number of elements in
the array that have the highest frequency.

=cut

my $ARR_CHECK = compile( ArrayRef [Int] );

sub maximum_frequency ($ints) {
    ($ints) = $ARR_CHECK->($ints);

    my %freq;
    $freq{$_}++ for @$ints;
    return 0 if !%freq;

    my $max = 0;
    for my $k ( keys %freq ) {
        $max = $freq{$k} if $freq{$k} > $max;
    }

    my $total = 0;
    $total += $freq{$_} for grep { $freq{$_} == $max } keys %freq;
    return $total;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { 0 + $_ } @args;
    my $out  = maximum_frequency( \@ints );
    say 'Input:  @ints = (' . join( ', ', @ints ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ints => [ 1, 2, 2, 4, 1, 5 ], expected => 4 },
        { label => 'Example 2', ints => [ 1, 2, 3, 4, 5 ],    expected => 5 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( maximum_frequency( $case->{ints} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 maximum_frequency($ints)

Returns the number of array elements that share the maximum frequency.

=cut
