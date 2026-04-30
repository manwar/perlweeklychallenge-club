#!/usr/bin/env perl

# You are given a sequence of 5 lowercase letters, with one letter
# replaced by ‘?’. Each letter maps to its position in the alphabet
# (‘a = 1’, ‘b = 2’, …, ‘z = 26’). The sequence follows a
# repeating pattern of step sizes between consecutive letters. The pattern
# is either a constant step (e.g., ‘+2, +2, +2, +2’) or a simple
# alternating pattern of two distinct steps (e.g., ‘+2, +3, +2, +3’).

use 5.018;
use strict;
use warnings;
use File::JSON::Slurper qw(read_json);

use Test2::V0;
plan tests => 5;

my %char_to_num;
@char_to_num{ "a" .. "z" } = ( 1 .. 26 );
my %num_to_char = reverse %char_to_num;

sub is_const_seq {
    my $step = shift;
    my @cseq = @_;

    return if @cseq < 2;
    my $first = $cseq[0];
    for my $n ( 1 .. $#cseq ) {
        return unless $cseq[$n] == $first + $n * $step;
    }
    return 1;
}

sub is_alt_seq {
    my ( $step1, $step2, @aseq ) = @_;

    return if @aseq < 2;
    my $cum = $aseq[0];
    for my $n ( 1 .. $#aseq ) {
        if ( $n % 2 ) {
            return unless $aseq[$n] == $cum + $step1;
        }
        else {
            return unless $aseq[$n] == $cum + $step2;
        }
        $cum = $aseq[$n];
    }
    return 1;
}

sub missing_letter {
    my @seq = @{ $_[0] };
    printf qq{ Input: \@seq = (%s)\n }, join( ', ' => @seq );
    my $result = q{};

    my @nums = map { $char_to_num{ $_ } } @seq;

    my $missing;
    for ( 0 .. $#nums ) {
        if ( !defined $nums[$_] ) {
            $missing = $_;
        }
    }

    my $lo = $nums[ $missing - 1 ];
    my $hi = $nums[ $missing + 1 ];

    for ( $lo .. $hi ) {
        my @testnums = @nums;
        $testnums[$missing] = $_;
        my $step  = $testnums[1] - $testnums[0];
        my $step2 = $testnums[2] - $testnums[1];
        if ( $step == $step2 ) {
            if ( is_const_seq( $step, @testnums ) ) {
                $result = $num_to_char{ $_ };
            }
        }
        else {
            if ( is_alt_seq( $step, $step2, @testnums ) ) {
                $result = $num_to_char{ $_ };
            }
        }
    }

    printf qq{Output: %s\n}, $result;
    return $result;
}

my $examples_ref = read_json( __FILE__ =~ s/pl$/json/r );
is( missing_letter( $_->{ in } ), $_->{ out }, $_->{ name } )
    for @{ $examples_ref };
