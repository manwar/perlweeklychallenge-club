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

ch-1.pl - Missing Numbers

=head1 SYNOPSIS

  perl ch-1.pl 0 1 3
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given an array of unique numbers of size n, find the missing number in the
range 0..n.

=cut

my $ARR_CHECK = compile( ArrayRef [Int] );

sub missing_number ($array) {
    ($array) = $ARR_CHECK->($array);
    my $n = scalar @$array;
    my $expected = $n * ( $n + 1 ) / 2;
    my $sum      = 0;
    $sum += $_ for @$array;
    return int( $expected - $sum );
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @array = map { 0 + $_ } @args;
    my $out   = missing_number( \@array );
    say 'Input:  @array = (' . join( ', ', @array ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', array => [ 0, 1, 3 ], expected => 2 },
        { label => 'Example 2', array => [ 0, 1 ],    expected => 2 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( missing_number( $case->{array} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 missing_number($array)

Returns the missing number in the range 0..n.

=cut

