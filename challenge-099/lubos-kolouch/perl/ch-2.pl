#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-2.pl - Unique Subsequence

=head1 SYNOPSIS

  perl ch-2.pl                 # runs the embedded tests
  perl ch-2.pl littleit lit     # prints the number of matching subsequences

=head1 DESCRIPTION

Given strings C<S> and C<T>, count how many distinct subsequences of C<S>
(keeping character order) equal C<T>.

This uses a classic dynamic programming approach:

Let C<dp[j]> be the number of ways to form the first C<j> characters of C<T>
from the characters processed so far in C<S>. For each character in C<S>, we
update C<dp> from right to left to avoid double-counting.

=cut

sub unique_subsequence_count ( $s, $t ) {
    my $m = length($t);

    my @dp = (0) x ( $m + 1 );
    $dp[0] = 1;

    for my $ch ( split //, $s ) {
        for ( my $j = $m ; $j >= 1 ; --$j ) {
            my $tch = substr( $t, $j - 1, 1 );
            $dp[$j] += $dp[ $j - 1 ] if $ch eq $tch;
        }
    }

    return $dp[$m];
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    Test::More::is( unique_subsequence_count( 'littleit', 'lit' ), 5, 'Example 1' );
    Test::More::is( unique_subsequence_count( 'london',   'lon' ), 3, 'Example 2' );

    Test::More::done_testing();
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <S> <T>\n" if @args != 2;
    say unique_subsequence_count( $args[0], $args[1] );
}

_run_cli(@ARGV);
