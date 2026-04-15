#!/usr/bin/env perl

# Perl Weekly Challenge 369 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-369/

use Modern::Perl;

@ARGV==3 or die "usage: $0 title...\n";
my @words = map {'"'.$_.'"'} split_and_fill(@ARGV);
if (@words == 1) {
    say $words[0];
}
else {
    say "(", join(", ", @words), ")";
}

sub split_and_fill {
    my($word, $size, $filler) = @_;
    length($filler)==1 or die "filler must be one character\n";
    if ($word eq "") {
        return ($filler x $size);
    }
    else {
        my @words;
        while ($word ne "") {
            if (length($word) > $size) {
                push @words, substr($word, 0, $size);
                $word = substr($word, $size);
            }
            else {
                push @words, $word . ($filler x ($size - length($word)));
                $word = "";
            }
        }
        return @words;
    }
}
