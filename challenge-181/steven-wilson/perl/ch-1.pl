#!/usr/bin/env perl
# Week 181 Task 1: Sentence Order
# You are given a paragraph.

# Write a script to order each sentence alphanumerically and print the whole paragraph.
# Example

# Input:
#     All he could think about was how it would all end. There was
#     still a bit of uncertainty in the equation, but the basics
#     were there for anyone to see. No matter how much he tried to
#     see the positive, it wasn't anywhere to be seen. The end was
#     coming and it wasn't going to be pretty.

# Ouput:
#     about All all could end he how it think was would. a anyone
#     basics bit but equation, for in of see still the the There
#     there to uncertainty was were. anywhere be he how it matter
#     much No positive, see seen the to to tried wasn't. and be
#     coming end going it pretty The to was wasn't.

use strict;
use warnings;
use feature qw/ say /;
use String::Util qw/ trim /;

my $input
    = "All he could think about was how it would all end. "
    . "There was still a bit of uncertainty in the equation, "
    . "but the basics were there for anyone to see. No matter "
    . "how much he tried to see the positive, it wasn't anywhere "
    . "to be seen. The end was coming and it wasn't going to be pretty.";
say order_sentences($input);

sub order_sentences {
    my $input    = shift;
    my @sentence = map { trim($_) } split /\./, $input;
    my $output;

    foreach (@sentence) {
        $output .= join " ",
            sort { no warnings; $a <=> $b; "\L$a" cmp "\L$b" } split /\s+/,
            $_;
        $output .= ".  ";
    }
    trim($output);
}
