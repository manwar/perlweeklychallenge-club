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

ch-2.pl - Mountain Array

=head1 SYNOPSIS

  perl ch-2.pl 0 2 4 6 4 2 0
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Return true if the array is a valid mountain array:

- length >= 3
- strictly increasing up to a peak (not first/last)
- strictly decreasing after the peak

=cut

my $ARR_CHECK = compile( ArrayRef [Int] );

sub is_mountain_array ($ints) {
    ($ints) = $ARR_CHECK->($ints);
    my $n = scalar @$ints;
    return 0 if $n < 3;

    my $i = 1;
    $i++ while $i < $n && $ints->[ $i - 1 ] < $ints->[$i];
    return 0 if $i == 1 || $i == $n;

    $i++ while $i < $n && $ints->[ $i - 1 ] > $ints->[$i];
    return $i == $n ? 1 : 0;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { 0 + $_ } @args;
    my $out  = is_mountain_array( \@ints ) ? 'true' : 'false';
    say 'Input:  @ints = (' . join( ', ', @ints ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ints => [ 1, 2, 3, 4, 5 ],       expected => 0 },
        { label => 'Example 2', ints => [ 0, 2, 4, 6, 4, 2, 0 ], expected => 1 },
        { label => 'Example 3', ints => [ 5, 4, 3, 2, 1 ],       expected => 0 },
        { label => 'Example 4', ints => [ 1, 3, 5, 5, 4, 2 ],    expected => 0 },
        { label => 'Example 5', ints => [ 1, 3, 2 ],             expected => 1 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( is_mountain_array( $case->{ints} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 is_mountain_array($ints)

Returns 1 if the array is mountain, otherwise 0.

=cut

