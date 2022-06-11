#!/usr/bin/raku

# A deers' deep bellow at nosy chimps: "Moo!" it do cry, "Be ill o dirty fuzz foots!"

# Guy airs hip hop art film. It flops in city. His boss bins it. 

sub MAIN() {
    my @words = "dictionary.txt".IO.lines;
    my @abcde;

    for @words -> $word {
        if $word eq $word.comb.sort.join {
            @abcde.push($word);
        }
    }

    for @abcde.sort({ $^b.chars <=> $^a.chars }) -> $word {
        say $word;
    }
}