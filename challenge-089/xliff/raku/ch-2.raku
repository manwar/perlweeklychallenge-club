#!/usr/bin/env raku

# Task 2

say 'This step will take a bit...';

my @solutions = (1...9).permutations.grep({
  [&&](
    # Rows
    .[0] + .[1] + .[2] == 15,
    .[3] + .[4] + .[5] == 15,
    .[6] + .[7] + .[8] == 15,

    # Columns
    .[0] + .[3] + .[6] == 15,
    .[1] + .[4] + .[7] == 15,
    .[2] + .[5] + .[8] == 15,

    # Diagonals
    .[0] + .[4] + .[8] == 15,
    .[6] + .[4] + .[2] == 15
  )
});

for @solutions {
  say "[ { .[0] } { .[1] } { .[2] } ]" for .rotor(3);
  say "\n";
}

say "Solution completed in { time - INIT time} seconds";
