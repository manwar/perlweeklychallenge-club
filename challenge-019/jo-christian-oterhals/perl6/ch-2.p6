#!/usr/bin/env perl6

# Perl Weekly Challenge 019
#
# Answer submitted by Jo Christian Oterhals
#
# Task 2
# Write a script that can wrap the given paragraph at a specified column using the greedy algorithm.

sub MAIN(Int :$line-width=72, *@paragraphs) {
    my $argfiles = @paragraphs.elems == 0 ?? $*IN !! IO::ArgFiles.new(@paragraphs);
    for $argfiles.lines -> $paragraph {
        my $space-left = $line-width;
        for $paragraph.split(/ ' '+ /) -> $word {
            if $word.chars + 1 > $space-left {
                say "";
                $space-left = $line-width - $word.chars;
            }
            else {
                $space-left -= ($word.chars + 1);
            }
            print "$word ";
        }
    }
    say "";
}