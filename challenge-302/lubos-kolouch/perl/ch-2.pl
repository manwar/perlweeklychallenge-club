#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use List::Util      qw(min);
use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);

=pod

=head1 NAME

ch-2.pl - Step by Step

=head1 SYNOPSIS

  perl ch-2.pl -3 2 -3 4 2
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Find the minimum positive start value such that the running sum of start value
plus the array values is never less than 1.

If the minimum prefix sum of the array is min_prefix, then start must satisfy:

  start + min_prefix >= 1  =>  start >= 1 - min_prefix

=cut

my $LIST_CHECK = compile( ArrayRef [Int] );

sub minimum_start_value ($ints) {
    ($ints) = $LIST_CHECK->($ints);
    my $sum = 0;
    my $min_prefix = 0;
    for my $v (@$ints) {
        $sum += $v;
        $min_prefix = $sum if $sum < $min_prefix;
    }
    return 1 - $min_prefix;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { 0 + $_ } @args;
    my $out  = minimum_start_value( \@ints );
    say 'Input:  @ints = (' . join( ', ', @ints ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ints => [ -3, 2, -3, 4, 2 ], expected => 5 },
        { label => 'Example 2', ints => [ 1, 2 ],            expected => 1 },
        { label => 'Example 3', ints => [ 1, -2, -3 ],       expected => 5 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( minimum_start_value( $case->{ints} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 minimum_start_value($ints)

Returns the minimum positive start value such that the step-by-step sum never
drops below 1.

=cut
