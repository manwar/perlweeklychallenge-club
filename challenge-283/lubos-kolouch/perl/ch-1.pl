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

ch-1.pl - Unique Number

=head1 SYNOPSIS

  perl ch-1.pl 3 3 1
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given an array where every element appears more than once except one, return
the element that appears exactly once.

=cut

my $LIST_CHECK = compile( ArrayRef [Int] );

sub unique_number ($ints) {
    ($ints) = $LIST_CHECK->($ints);
    my %count;
    $count{$_}++ for @$ints;
    for my $v (@$ints) {
        return $v if $count{$v} == 1;
    }
    die 'No unique element found';
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { 0 + $_ } @args;
    say 'Input:  @ints = (' . join( ', ', @ints ) . ')';
    say 'Output: ' . unique_number( \@ints );
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ints => [ 3, 3, 1 ],          expected => 1 },
        { label => 'Example 2', ints => [ 3, 2, 4, 2, 4 ],    expected => 3 },
        { label => 'Example 3', ints => [1],                 expected => 1 },
        { label => 'Example 4', ints => [ 4, 3, 1, 1, 1, 4 ], expected => 3 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( unique_number( $case->{ints} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 unique_number($ints)

Returns the element that appears exactly once.

=cut
