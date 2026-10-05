#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use List::Util      qw(min);
use Type::Params    qw(compile);
use Types::Standard qw(Str);

=pod

=head1 NAME

ch-1.pl - Alternate Case (WWC 394 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl "aAbB"
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given a string containing an equal number of uppercase and lowercase English letters.
Write a script to find the minimum number of adjacent character swaps needed to turn the
given string into an alternate case string.

=cut

my $STR_CHECK = compile(Str);

sub min_swaps_to_alternate ($str) {
    ($str) = $STR_CHECK->($str);

    my @chars = split //, $str;
    my $n     = scalar @chars;
    return 0 if $n <= 1;

    my ( @upper_pos, @lower_pos );
    for my $i ( 0 .. $#chars ) {
        my $c = $chars[$i];
        if ( $c =~ /^[A-Z]\z/ ) {
            push @upper_pos, $i;
        }
        elsif ( $c =~ /^[a-z]\z/ ) {
            push @lower_pos, $i;
        }
        else {
            die "String must contain only English alphabetic letters: $c";
        }
    }

    die 'String must contain equal number of uppercase and lowercase letters'
      if @upper_pos != @lower_pos;

    # Pattern A: Upper at even indices (0, 2, 4...), Lower at odd indices (1, 3, 5...)
    my $swaps_upper_first = 0;
    for my $k ( 0 .. $#upper_pos ) {
        $swaps_upper_first += abs( $upper_pos[$k] - ( 2 * $k ) );
    }

    # Pattern B: Lower at even indices (0, 2, 4...), Upper at odd indices (1, 3, 5...)
    my $swaps_lower_first = 0;
    for my $k ( 0 .. $#lower_pos ) {
        $swaps_lower_first += abs( $lower_pos[$k] - ( 2 * $k ) );
    }

    return min( $swaps_upper_first, $swaps_lower_first );
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $out = min_swaps_to_alternate( $args[0] );
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', str => 'aAbB',   expected => 0 },
        { label => 'Example 2', str => 'AAbb',   expected => 1 },
        { label => 'Example 3', str => 'AAAbbb', expected => 3 },
        { label => 'Example 4', str => 'aABb',   expected => 1 },
        { label => 'Example 5', str => 'bBBAaa', expected => 2 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( min_swaps_to_alternate( $case->{str} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 min_swaps_to_alternate($str)

Calculates the minimum number of adjacent swaps to make the string alternate case.

=cut
