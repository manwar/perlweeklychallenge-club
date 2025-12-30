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

ch-2.pl - Digit Count Value

=head1 SYNOPSIS

  perl ch-2.pl 1 2 1 0
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given an array @ints, return true if for every index i, the value i appears
exactly $ints[i] times in the array; otherwise return false.

=cut

my $LIST_CHECK = compile( ArrayRef [Int] );

sub digit_count_value ($ints) {
    ($ints) = $LIST_CHECK->($ints);
    my %count;
    $count{$_}++ for @$ints;

    for my $i ( 0 .. $#$ints ) {
        my $occurs = $count{$i} // 0;
        return 0 if $occurs != $ints->[$i];
    }
    return 1;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { 0 + $_ } @args;
    my $out  = digit_count_value( \@ints ) ? 'true' : 'false';
    say 'Input:  @ints = (' . join( ', ', @ints ) . ')';
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ints => [ 1, 2, 1, 0 ], expected => 1 },
        { label => 'Example 2', ints => [ 0, 3, 0 ],    expected => 0 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = digit_count_value( $case->{ints} ) ? 1 : 0;
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 digit_count_value($ints)

Returns a boolean indicating whether the array satisfies the digit-count rule.

=cut
