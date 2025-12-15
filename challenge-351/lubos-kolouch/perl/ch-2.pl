#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Num);

=pod

=head1 NAME

ch-2.pl - Arithmetic Progression

=head1 SYNOPSIS

  perl ch-2.pl 9 1 7 5 3
  perl ch-2.pl             # runs the embedded tests

=head1 DESCRIPTION

Determines whether the supplied list of numbers can be rearranged into an
arithmetic progression, i.e. a sequence where every adjacent pair shares the
same difference. Floating point values are allowed; a tiny tolerance is used
when comparing differences to avoid spurious failures from rounding.

=cut

my $LIST_CHECK = compile( ArrayRef[Num] );
use constant EPSILON => 1e-9;

sub can_form_arithmetic_progression ($nums) {
    ($nums) = $LIST_CHECK->($nums);
    return 1 if @$nums <= 2;

    my @sorted = sort { $a <=> $b } @$nums;
    my $diff   = $sorted[1] - $sorted[0];

    for my $i ( 2 .. $#sorted ) {
        my $current = $sorted[$i] - $sorted[ $i - 1 ];
        return 0 if abs( $current - $diff ) > EPSILON;
    }

    return 1;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    my @nums = map { 0 + $_ } @args;
    my $result = can_form_arithmetic_progression( \@nums ) ? 'true' : 'false';
    say 'Input:  @num = (' . join( ', ', @nums ) . ')';
    say "Output: $result";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', nums => [ 1, 3, 5, 7, 9 ],       expected => 1 },
        { label => 'Example 2', nums => [ 9, 1, 7, 5, 3 ],       expected => 1 },
        { label => 'Example 3', nums => [ 1, 2, 4, 8, 16 ],      expected => 0 },
        { label => 'Example 4', nums => [ 5, -1, 3, 1, -3 ],     expected => 1 },
        { label => 'Example 5', nums => [ 1.5, 3, 0, 4.5, 6 ],   expected => 1 },
    );

    Test::More::plan( tests => scalar @cases );

    for my $case (@cases) {
        my $got = can_form_arithmetic_progression( $case->{nums} ) ? 1 : 0;
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 can_form_arithmetic_progression($nums)

Accepts an array reference of numbers and returns a boolean indicating whether
the numbers can be reordered so adjacent elements share a constant difference.

=cut
