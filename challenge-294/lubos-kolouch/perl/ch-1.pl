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

ch-1.pl - Consecutive Sequence (WWC 294 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl 10 4 20 1 3 2
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an unsorted array of integers.
Write a script to return the length of the longest consecutive elements sequence.
Return -1 if there is no sequence of length greater than 1.

=cut

my $INTS_CHECK = compile( ArrayRef [Int] );

sub longest_consecutive_sequence ($ints) {
    ($ints) = $INTS_CHECK->($ints);
    my %nums = map { $_ => 1 } @$ints;
    my $max_length = 0;

    for my $num (@$ints) {
        # Only check sequence starting from the smallest element
        if ( !exists $nums{ $num - 1 } ) {
            my $current_num    = $num;
            my $current_length = 1;

            while ( exists $nums{ $current_num + 1 } ) {
                $current_num++;
                $current_length++;
            }

            $max_length = $current_length if $current_length > $max_length;
        }
    }

    return $max_length > 1 ? $max_length : -1;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { int($_) } @args;
    my $out  = longest_consecutive_sequence( \@ints );
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', ints => [ 10, 4, 20, 1, 3, 2 ],           expected => 4 },
        { label => 'Example 2', ints => [ 0, 6, 1, 8, 5, 2, 4, 3, 0, 7 ], expected => 9 },
        { label => 'Example 3', ints => [ 10, 30, 20 ],                   expected => -1 },
        { label => 'Example 4', ints => [ 1, 9, 3, 10, 4, 20, 2 ],        expected => 4 },
        { label => 'Example 5', ints => [ 5, 6, 1, 2, 3, 4 ],             expected => 6 },
        { label => 'Example 6', ints => [ 100, 4, 200, 1, 3, 2 ],         expected => 4 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( longest_consecutive_sequence( $case->{ints} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 longest_consecutive_sequence(\@ints)

Returns the length of the longest consecutive elements sequence, or -1 if <= 1.

=cut
