#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params qw(compile);
use Types::Standard qw(Str);

=pod

=head1 NAME

ch-2.pl - Scramble String

=head1 SYNOPSIS

  perl ch-2.pl string1 string2
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given two strings A and B of the same length, determine if B is a scramble
of A. A scramble operation involves splitting the string into two non-empty
parts, optionally swapping them, and recursively scrambling each part.

=cut

my $ARGS_CHECK = compile(Str, Str);

sub scramble_string ($s1, $s2) {
    ( $s1, $s2 ) = $ARGS_CHECK->(@_);

    # Memoization
    state %memo;
    my $key = "$s1|$s2";
    return $memo{$key} if exists $memo{$key};

    if ( $s1 eq $s2 ) {
        $memo{$key} = 1;
        return 1;
    }

    # Early exit: character counts must match
    my @cnt1 = (0) x 26;
    my @cnt2 = (0) x 26;
    for my $ch ( split //, $s1 ) { $cnt1[ ord($ch) - 97 ]++ }
    for my $ch ( split //, $s2 ) { $cnt2[ ord($ch) - 97 ]++ }
    for my $i ( 0 .. 25 ) {
        if ( $cnt1[$i] != $cnt2[$i] ) {
            $memo{$key} = 0;
            return 0;
        }
    }

    my $n = length $s1;
    for my $i ( 1 .. $n - 1 ) {

        # No swap
        if ( scramble_string( substr( $s1, 0, $i ), substr( $s2, 0, $i ) )
            && scramble_string( substr( $s1, $i ), substr( $s2, $i ) ) )
        {
            $memo{$key} = 1;
            return 1;
        }

        # Swap
        if ( scramble_string( substr( $s1, 0, $i ), substr( $s2, $n - $i ) )
            && scramble_string( substr( $s1, $i ), substr( $s2, 0, $n - $i ) ) )
        {
            $memo{$key} = 1;
            return 1;
        }
    }

    $memo{$key} = 0;
    return 0;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 <string1> <string2>\n" if @args != 2;

    my ( $s1, $s2 ) = @args;
    my $out = scramble_string( $s1, $s2 ) ? 'true' : 'false';
    say qq{Input: \$s1 = "$s1", \$s2 = "$s2"};
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', s1 => 'great', s2 => 'rgeat', expected => 1 },
        { label => 'Example 2', s1 => 'abcde', s2 => 'caebd', expected => 0 },
        { label => 'Example 3', s1 => 'a',     s2 => 'a',     expected => 1 },
        { label => 'Example 4', s1 => 'abc',   s2 => 'bca',   expected => 1 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = scramble_string( $case->{s1}, $case->{s2} );
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 scramble_string($s1, $s2)

Returns a boolean indicating whether C<$s2> is a scramble of C<$s1>
using recursive splitting with optional swapping and memoization.

=cut
