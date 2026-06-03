#!/usr/bin/env perl
# Perl weekly challenge 376
# Task 2:  Doubled Words
#
# See https://wlmb.github.io/2026/06/01/PWC376/#task-2-doubled-words
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to find, highlight and print doubled words in the string Sn
    FIN
for(@ARGV){
    my @parts=split /   # split on word separators
       (                # capture
        \s*             # leading spaces
        (               # group
          <\/?\w[^>]*?> # html tag
          |
          &.+?;         # html special character
          |
          \s            # space
          |
          [[:punct:]]   # punctuation
        )+              # arbitrarily repeated
        \s*             # trailing space
       )
       /xx;             # extended re syntax
    # As there are two capture groups, @parts contains word, sep, sep, word, sep, sep...
    for(grep{$_%3==0} 0..@parts-4){                      # for the actual words
        next unless (lc $parts[$_] eq lc $parts[$_+3]);  # check doubled words
        $parts[$_]="[$parts[$_]]";                       # and higlight them
        $parts[$_+3]="[$parts[$_+3]]";
    }

    my @lines =
	grep {/\[/}
	split "\n",
	join "", @parts[
	    grep{$_%3!=2}0..@parts-1
	],
	"\n";
    say "$_\n->";
    say $_ for @lines;
    say "---";
}
