#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(Str);
use Test::More;

=pod

=head1 NAME

ch-1.pl - Closest Palindrome (The Weekly Challenge 288 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl 123
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

This script finds the closest palindrome integer to a given integer string,
excluding the integer itself. If there are multiple palindromes with the same
minimal absolute difference, it returns the smallest one.

=head1 FUNCTIONS

=head2 closest_palindrome($n_str)

Given a string representing an integer, returns the closest palindrome integer as a string.

=cut

signature_for closest_palindrome => (
    method     => 0,
    positional => [ Str ],
);

sub closest_palindrome ($n_str) {
    my $n       = int($n_str);
    my $len     = length($n_str);
    my $is_even = $len % 2 == 0;
    my $mid     = int($len / 2);

    # Obtain the left part of the number
    my $left_len = $is_even ? $mid : $mid + 1;
    my $left     = substr($n_str, 0, $left_len);
    my @candidates;

    for my $i (-1, 0, 1) {
        my $new_left = int($left) + $i;
        next if $new_left < 0;
        my $new_left_str = "$new_left";

        my $palindrome;
        if ($is_even) {
            $palindrome = $new_left_str . reverse($new_left_str);
        } else {
            $palindrome = $new_left_str . reverse(substr($new_left_str, 0, -1));
        }
        push @candidates, $palindrome;
    }

    # Edge cases (e.g. 99 -> 101, 100 -> 99)
    push @candidates, ('9' x ($len - 1)) if $len > 1;
    push @candidates, '1' . ('0' x ($len - 1)) . '1';

    # Remove the original number from candidates
    @candidates = grep { $_ ne $n_str } @candidates;

    # Find the closest palindrome
    my $min_diff           = undef;
    my $closest_palindrome = undef;
    for my $candidate (@candidates) {
        my $diff = abs(int($candidate) - $n);
        if (!defined $min_diff || $diff < $min_diff || ($diff == $min_diff && int($candidate) < int($closest_palindrome))) {
            $min_diff           = $diff;
            $closest_palindrome = $candidate;
        }
    }
    return $closest_palindrome;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $out = closest_palindrome( $args[0] );
    say "Output: $out";
}

sub _run_tests {
    my @cases = (
        { label => 'Example 1', str => '123',  expected => '121' },
        { label => 'Example 2', str => '2',    expected => '1' },
        { label => 'Example 3', str => '1400', expected => '1441' },
        { label => 'Example 4', str => '1001', expected => '999' },
        { label => 'All nines', str => '999',  expected => '1001' },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is( closest_palindrome( $case->{str} ), $case->{expected}, $case->{label} );
    }
    done_testing();
}

_run_cli(@ARGV);

=cut
