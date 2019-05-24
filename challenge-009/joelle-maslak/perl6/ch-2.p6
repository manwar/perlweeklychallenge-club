#!/usr/bin/env perl6
use v6;

#
# Copyright © 2019 Joelle Maslak
# All Rights Reserved - See License
#

#
# Source file contains lines in the following format:
#
#   <score><tab><description>
#
# So, for instance:
#   32  Foo
#   40  Bar
#   40  Baz
#   66  Quux
#   67  Quuux
#   67  Quuuux
#
# There should be no tabs other than the single tab seperating score
# from description.
#
# Scores are assumed to be integers that can be printed with %5d.

sub MAIN(
    Str:D :$src-file? = "ch-2.txt";
) {
    my @lines = $src-file.IO.lines».split("\t").map( { Pair.new($_[0], $_[1]) } );
    @lines = @lines.sort( { ($^a.key <=> $^b.key) or ($^b.value cmp $^a.value) } ).reverse;
    
    my $bag = bag @lines.map( { $^a.key } );

    say "  STD   MOD DENSE SCORE DESCRIPTION";

    my $standard   = 0;
    my $modified   = 0;
    my $dense      = 0;
    my $last-score;
    for @lines -> $pair {
        my $score = $pair.key;
        my $desc  = $pair.value;

        if (! $last-score.defined) or $last-score ≠ $score {
            $standard += $last-score.defined ?? $bag{$last-score} !! 1;
            $modified += $bag{$score};
            $dense++;
            $last-score = $score;
        }

        print $standard.fmt("%5d") ~ " ";
        print $modified.fmt("%5d") ~ " ";
        print $dense\  .fmt("%5d") ~ " ";
        print $score\  .fmt("%5d") ~ " ";
        say   $desc;
    }
}

