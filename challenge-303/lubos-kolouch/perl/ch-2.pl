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

ch-2.pl - Delete and Earn

=head1 SYNOPSIS

  perl ch-2.pl 3 4 2
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Pick a value x to earn x points and delete all occurrences of x-1 and x+1.
Repeat any number of times to maximize points.

This is equivalent to the classic "House Robber" DP over values: for each value
v, you can take (v * count[v]) plus dp[v-2] or skip with dp[v-1].

=cut

my $LIST_CHECK = compile( ArrayRef [Int] );

sub delete_and_earn ($ints) {
    ($ints) = $LIST_CHECK->($ints);
    return 0 if !@$ints;

    my %count;
    $count{$_}++ for @$ints;
    my $max_v = max(keys %count);
    my $prev2 = 0;
    my $prev1 = 0;

    for my $v ( 0 .. $max_v ) {
        my $gain = ( $count{$v} // 0 ) * $v;
        my $cur  = $prev1 > ( $prev2 + $gain ) ? $prev1 : ( $prev2 + $gain );
        ( $prev2, $prev1 ) = ( $prev1, $cur );
    }

    return $prev1;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { 0 + $_ } @args;
    my $out  = delete_and_earn( \@ints );
    say 'Input:  @ints = (' . join( ', ', @ints ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ints => [ 3, 4, 2 ],             expected => 6 },
        { label => 'Example 2', ints => [ 2, 2, 3, 3, 3, 4 ],    expected => 9 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( delete_and_earn( $case->{ints} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 delete_and_earn($ints)

Returns the maximum points obtainable by applying delete-and-earn operations.

=cut
