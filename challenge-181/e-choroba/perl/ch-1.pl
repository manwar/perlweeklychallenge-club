#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use constant WIDTH => 59;  # Anything up to 63 works.

sub sentence_order ($paragraph) {
    my @out;
    for my $sentence (split /\./, $paragraph) {
        my @words = sort { lc $a cmp lc $b } split ' ', $sentence;
        last unless @words;

        $words[-1] .= '.';
        push @out, @words;
    }
    return paragraph(@out)
}

sub paragraph (@words) {
    my @lines = ("");

    while (@words) {
        my $word = shift @words;
        die "Word $word too long" if WIDTH < length $word;

        my $maybe_space = length $lines[-1] ? ' ' : "";
        if (WIDTH < length "$lines[-1]$maybe_space$word") {
            push @lines, $word;
        } else {
            $lines[-1] .= "$maybe_space$word";
        }
    }

    return join "\n", @lines, ""
}

my $in = << '__INPUT__';
All he could think about was how it would all end. There was
still a bit of uncertainty in the equation, but the basics
were there for anyone to see. No matter how much he tried to
see the positive, it wasn't anywhere to be seen. The end was
coming and it wasn't going to be pretty.
__INPUT__

my $expect = << '__EXPECT__';
about All all could end he how it think was would. a anyone
basics bit but equation, for in of see still the the There
there to uncertainty was were. anywhere be he how it matter
much No positive, see seen the to to tried wasn't. and be
coming end going it pretty The to was wasn't.
__EXPECT__

use Test::More tests => 1;

is sentence_order($in), $expect;
