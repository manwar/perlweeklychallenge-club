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

ch-1.pl - Contiguous Array (WWC 297 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given a binary array of 0s and 1s, find the maximum length of a contiguous
subarray with an equal number of 0 and 1.

=cut

my $ARRAY_CHECK = compile( ArrayRef [Int] );

sub find_max_length ($binary) {
    ($binary) = $ARRAY_CHECK->($binary);
    return 0 if !@$binary;

    my %sum_indices;
    my $max_length     = 0;
    my $cumulative_sum = 0;

    for my $i ( 0 .. $#$binary ) {
        my $val = $binary->[$i];
        die 'Binary array must contain only 0 and 1' if $val != 0 && $val != 1;
        $cumulative_sum += ( $val == 0 ? -1 : 1 );

        if ( $cumulative_sum == 0 ) {
            $max_length = $i + 1;
        }
        elsif ( exists $sum_indices{$cumulative_sum} ) {
            my $length = $i - $sum_indices{$cumulative_sum};
            $max_length = $length if $length > $max_length;
        }
        else {
            $sum_indices{$cumulative_sum} = $i;
        }
    }

    return $max_length;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "CLI not implemented; run without args for tests\n";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', binary => [ 1, 0 ], expected => 2 },
        { label => 'Example 2', binary => [ 0, 1, 0 ], expected => 2 },
        { label => 'Example 3', binary => [ 0, 0, 0, 0, 0 ], expected => 0 },
        { label => 'Example 4', binary => [ 0, 1, 0, 0, 1, 0 ], expected => 4 },
        { label => 'Empty Input', binary => [], expected => 0 },
        { label => 'No Equal Subarray', binary => [ 0, 0, 0, 1, 1 ], expected => 4 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( find_max_length( $case->{binary} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 find_max_length($binary)

Finds the maximum length of a contiguous subarray with equal numbers of 0 and 1.

=cut
