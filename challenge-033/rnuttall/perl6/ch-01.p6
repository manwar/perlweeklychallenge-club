#!/usr/bin/env perl6
# Task #1
#    Count Letters (A..Z)
#    Create a script that accepts one or more files specified on the command-line and count the number of times letters appeared in the files.

sub MAIN(*@files) {
    #Task 1 - a Test of Bag and Bag addition
    my Bag $counts = bag { 'a' .. 'z' => 0 };

    say @files;
    # Create a bag for each file and add counts using Bag addition ⊎ or (+)
    for @files -> $file {
        $counts ⊎= $file.IO.slurp.lc.comb.Bag;
    }
    for 'a' .. 'z' -> $letter {
        say "$letter: $counts{$letter}";
    }
}
