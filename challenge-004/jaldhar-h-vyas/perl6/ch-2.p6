#!/usr/bin/perl6

# I'm assuming the list of allowed letters is given on the command line and the
# list of words is in a file in the current directory called word.list.
# This wasn't clear in the spec.

multi sub MAIN(
    Str $letters #= A case-insensitive string of letters to be matched.
                 #= Can include repeats.
) {
    my $contents = "word.list".IO.slurp;
    my @words = $contents.lines;

    for @words -> $word {
        my $upword = $word.uc;  # converting word and letter list to upper case
        my $used = $letters.uc; # for case-insensitive comparisons.
        my Bool $bogus = False;

        for $upword.comb -> $letter {
            if ($used !~~ s/$letter//) {
                $bogus = True;
                last;
            }
        }

        if (!$bogus) {
            say $word;
        }
    }
}
