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

ch-1.pl - Maximum Count

=head1 SYNOPSIS

  perl ch-1.pl -3 -2 -1 1 2 3
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Counts positive and negative integers (zero is ignored) and returns the larger
of the two counts.

=cut

my $LIST_CHECK = compile( ArrayRef [Int] );

sub maximum_count ($ints) {
    ($ints) = $LIST_CHECK->($ints);
    my $pos = 0;
    my $neg = 0;
    for my $n (@$ints) {
        ++$pos if $n > 0;
        ++$neg if $n < 0;
    }
    return $pos > $neg ? $pos : $neg;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    my @ints = map { 0 + $_ } @args;
    my $out  = maximum_count( \@ints );
    say 'Input:  @ints = (' . join( ', ', @ints ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ints => [ -3, -2, -1, 1, 2, 3 ], expected => 3 },
        { label => 'Example 2', ints => [ -2, -1, 0, 0, 1 ],     expected => 2 },
        { label => 'Example 3', ints => [ 1, 2, 3, 4 ],          expected => 4 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( maximum_count( $case->{ints} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 maximum_count($ints)

Returns the larger of the positive and negative element counts.

=cut
