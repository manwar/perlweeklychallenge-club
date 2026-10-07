#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use List::Util      qw(max);
use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);

=pod

=head1 NAME

ch-2.pl - Jump Game (WWC 295 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl 2 3 1 1 4
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of integers where each element represents your maximum jump
length from that position.
Return the minimum number of jumps to reach the last index. If you cannot reach the
last index, return -1.

=cut

my $INTS_CHECK = compile( ArrayRef [Int] );

sub min_jumps ($ints) {
    ($ints) = $INTS_CHECK->($ints);
    my $n = scalar @$ints;

    return 0  if $n <= 1;
    return -1 if $ints->[0] == 0;

    my $jumps       = 0;
    my $current_end = 0;
    my $farthest    = 0;

    for my $i ( 0 .. $n - 2 ) {
        $farthest = max( $farthest, $i + $ints->[$i] );

        if ( $i == $current_end ) {
            $jumps++;
            $current_end = $farthest;

            return $jumps if $current_end >= $n - 1;
        }

        return -1 if $farthest <= $i;
    }

    return -1;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { int($_) } @args;
    my $out  = min_jumps( \@ints );
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ints => [ 2, 3, 1, 1, 4 ], expected => 2 },
        { label => 'Example 2', ints => [ 2, 3, 0, 4 ],    expected => 2 },
        { label => 'Example 3', ints => [ 2, 0, 0, 4 ],    expected => -1 },
        { label => 'Example 4', ints => [ 1, 1, 1, 1 ],    expected => 3 },
        { label => 'Example 5', ints => [0],               expected => 0 },
        { label => 'Example 6', ints => [ 1, 0, 1, 0 ],    expected => -1 },
        { label => 'Example 7', ints => [ 2, 1 ],          expected => 1 },
        { label => 'Example 8', ints => [ 1, 2, 3 ],       expected => 2 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( min_jumps( $case->{ints} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 min_jumps(\@ints)

Returns the minimum number of jumps to reach the last index, or -1 if unreachable.

=cut
