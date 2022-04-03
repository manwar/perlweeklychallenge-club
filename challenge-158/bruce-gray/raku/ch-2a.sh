raku -e 'say (^19 X** 3).rotor(2 => -1).map({.[1] - .[0]}).grep(&is-prime).join: ", "'
