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

ch-2.pl - Binary Reflection (WWC 397 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl 7 8 9 10
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of integers.
Write a script to sort the given array in ascending order based on the binary reflection
of each element. If two different numbers have the same binary reflection, the smaller
original number should appear first.

Binary reflection of an integer is obtained by converting it to binary, reversing the bits,
and converting back to decimal.

=cut

my $INTS_CHECK = compile( ArrayRef [Int] );

sub binary_reflection ($num) {
    return 0 if $num == 0;
    my $bin = sprintf( '%b', $num );
    my $rev = reverse $bin;
    return oct( "0b$rev" );
}

sub sort_by_binary_reflection ($arr) {
    ($arr) = $INTS_CHECK->($arr);
    return [] if !@$arr;

    my @decorated = map { [ $_, binary_reflection($_) ] } @$arr;

    @decorated = sort {
        $a->[1] <=> $b->[1] || $a->[0] <=> $b->[0]
    } @decorated;

    return [ map { $_->[0] } @decorated ];
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @arr = map { int($_) } @args;
    my $out = sort_by_binary_reflection( \@arr );
    say 'Output: (' . join( ', ', @$out ) . ')';
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', arr => [ 3, 6, 12 ],       expected => [ 3, 6, 12 ] },
        { label => 'Example 2', arr => [ 1, 2, 4, 8 ],       expected => [ 1, 2, 4, 8 ] },
        { label => 'Example 3', arr => [ 7, 8, 9, 10 ],      expected => [ 8, 10, 7, 9 ] },
        { label => 'Example 4', arr => [ 5, 9, 15, 17 ],     expected => [ 5, 9, 15, 17 ] },
        { label => 'Example 5', arr => [ 11, 13, 14, 19 ],   expected => [ 14, 13, 11, 19 ] },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = sort_by_binary_reflection( $case->{arr} );
        Test::More::is_deeply( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 binary_reflection($num)

Returns the decimal value of the reversed binary representation of $num.

=head2 sort_by_binary_reflection(\@arr)

Sorts @arr ascending by binary reflection, breaking ties by original value.

=cut
