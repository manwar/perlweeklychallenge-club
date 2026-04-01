#!/usr/bin/env perl

# Perl Weekly Challenge 181 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-181/

use Modern::Perl;
use Text::Wrap;

sub read_input {
    local $/;
    my $text = <>;
    $text =~ s/\s+/ /g;
    return $text;
}

sub order_sentences {
    my($text) = @_;
    $text =~ s/\.\s*$//s;   # remove last period
    my @sentences = map {s/^\s+//; s/\s+$//; $_} split(/\./, $text);
    for (@sentences) {
        $_ = (join " ", sort {lc($a) cmp lc($b) || $a cmp $b} split " ", $_).".";
    }
    return join " ", @sentences;
}

sub reflow {
    my($text) = @_;
    local $Text::Wrap::columns = 60;
    return wrap("", "", $text);
}

print reflow(order_sentences(read_input()));
