#!/usr/bin/env perl

# Challenge 025
#
# Task #2
# Create script to implement Chaocipher. Please checkout wiki page for more
# information.

use strict;
use warnings;
use 5.030;

my $left  = "HXUCZVAMDSLKPEFJRIGTWOBNYQ";
my $right = "PTLNBQDEOYSFAVZKGJRIHWXUMC";

sub permute_alphabets {
    my($pos) = @_;

    # permute left alphabet
    $left = substr($left, $pos).substr($left, 0, $pos);
    $left = substr($left, 0, 1).substr($left, 2, 12)
           .substr($left, 1, 1).substr($left, 14);

    # permute right alphabet
    $right = substr($right, $pos).substr($right, 0, $pos);
    $right = substr($right, 1, 25).substr($right, 0, 1);
    $right = substr($right, 0, 2).substr($right, 3, 11)
            .substr($right, 2, 1).substr($right, 14);
}

sub find_pos {
    my($letter, $alphabet) = @_;
    $alphabet =~ /$letter/g;
    my $pos = pos($alphabet)-1;
    return $pos;
}

sub encode {
    my($text) = @_;
    my $encoded = "";
    while ($text ne '') {
        (my $letter, $text) = $text =~ /(.)(.*)/;
        my $pos = find_pos($letter, $right);
        my $code = substr($left, $pos, 1);
        $encoded .= $code;

        permute_alphabets($pos);
    }
    return $encoded;
}

sub decode {
    my($encoded) = @_;
    my $text = "";
    while ($encoded ne '') {
        (my $code, $encoded) = $encoded =~ /(.)(.*)/;
        my $pos = find_pos($code, $left);
        my $letter = substr($right, $pos, 1);
        $text .= $letter;

        permute_alphabets($pos);
    }
    return $text;
}


# main
my($op, $arg) = @ARGV;
if (@ARGV==2 && $op =~ /^enc/i) {
    say encode($arg);
}
elsif (@ARGV==2 && $op =~ /^dec/i) {
    say decode($arg);
}
else {
    say "Usage: ch-2.pl encode|decode text\n";
}
