#!/usr/bin/perl -s

use v5.16;
use warnings;
use List::Util 'reduce';

our $textwidth //= 72;

die <<EOS unless @ARGV;
usage: $0 [-textwidth=L] PARAGRAPH

-textwidth=L
    specify maximum line length

PARAGRAPH
    text taken as a single paragraph

EOS


say reduce {
        # match the last line.
        $a =~/(.*)$/;
        # Append the next word separated by a newline if the textwidth
        # would be exceeded or a space otherwise.
        $a . (length($b) + length($1) + 1 > $textwidth ? "\n" : " ") . $b;
    } split /\s+/, shift;
