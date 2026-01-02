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

ch-2.pl - Strong Pair

=head1 SYNOPSIS

  perl ch-2.pl 1 2 3 4 5
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given an array of integers, return the count of strong pairs (x, y) among the
distinct values, where:

  0 < |x - y| < min(x, y)

Pairs are considered unordered (i.e. (x, y) is the same as (y, x)).

=cut

my $ARR_CHECK = compile( ArrayRef [Int] );

sub strong_pairs ($ints) {
    ($ints) = $ARR_CHECK->($ints);

    my %seen;
    $seen{$_} = 1 for @$ints;
    my @vals = sort { $a <=> $b } keys %seen;

    my $count = 0;
    for my $i ( 0 .. $#vals ) {
        for my $j ( $i + 1 .. $#vals ) {
            my $x = $vals[$i];
            my $y = $vals[$j];
            my $diff = $y - $x;
            next if $diff == 0;
            my $min = $x < $y ? $x : $y;
            ++$count if $diff < $min;
        }
    }
    return $count;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { 0 + $_ } @args;
    my $out  = strong_pairs( \@ints );
    say 'Input:  @ints = (' . join( ', ', @ints ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ints => [ 1, 2, 3, 4, 5 ], expected => 4 },
        { label => 'Example 2', ints => [ 5, 7, 1, 7 ],    expected => 1 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( strong_pairs( $case->{ints} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 strong_pairs($ints)

Counts strong pairs among distinct values.

=cut

