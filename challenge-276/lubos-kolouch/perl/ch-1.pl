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

ch-1.pl - Complete Day

=head1 SYNOPSIS

  perl ch-1.pl 12 12 30 24 24
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given an array of integers C<@hours>, count pairs (i < j) such that the sum
of the pair is a multiple of 24.

=cut

my $ARR_CHECK = compile( ArrayRef [Int] );

sub complete_day_pairs ($hours) {
    ($hours) = $ARR_CHECK->($hours);

    my @count = (0) x 24;
    for my $h (@$hours) {
        $count[ $h % 24 ]++;
    }

    my $pairs = 0;
    $pairs += $count[0] * ( $count[0] - 1 ) / 2;
    $pairs += $count[12] * ( $count[12] - 1 ) / 2;

    for my $r ( 1 .. 11 ) {
        $pairs += $count[$r] * $count[ 24 - $r ];
    }
    return int($pairs);
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @hours = map { 0 + $_ } @args;
    my $out   = complete_day_pairs( \@hours );
    say 'Input:  @hours = (' . join( ', ', @hours ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', hours => [ 12, 12, 30, 24, 24 ], expected => 2 },
        { label => 'Example 2', hours => [ 72, 48, 24, 5 ],      expected => 3 },
        { label => 'Example 3', hours => [ 12, 18, 24 ],         expected => 0 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( complete_day_pairs( $case->{hours} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 complete_day_pairs($hours)

Returns the number of pairs with sum divisible by 24.

=cut

