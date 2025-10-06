#!/usr/bin/env raku

my @examples = (
    ["a0b1c2",  "0a1b2c" ],
    ["abc12",   "a1b2c"  ],
    ["0a2b1c3", "0a1b2c3"],
    ["1a23",    ""       ],
    ["ab123",   "1a2b3"  ],
);

for @examples -> @example {
    my ($input, $expected) = @example;
    my $result = balance-string($input);
    say "Pass: {$result eq $expected}";
}

sub balance-string(Str $s) {
    # Extract all digits and sort them
    my @d = $s.comb.grep({ /<digit>/ }).sort;
    # Extract all letters and sort them
    my @l = $s.comb.grep({ /<alpha>/ }).sort;

    # Return empty string if impossible
    return "" if abs(@d.elems - @l.elems) > 1;

    # If more digits than letters:
    if @d.elems > @l.elems {
        # Join all elements into a string
        return join "",
            # For each index: digit + letter (or empty if no letter)
            map { @d[$_] ~ (@l[$_] // "") },
            # Iterate through all digit indices
            0..^@d.elems;
    }
    # Else if more letters than digits:
    elsif @l.elems > @d.elems {
        # Join all elements into a string
        return join "",
            # For each index: letter + digit (or empty if no digit)
            map { @l[$_] ~ (@d[$_] // "") },
            # Iterate through all letter indices
            0..^@l.elems;
    }
    # Else (equal counts):
    else {
        # If first digit < first letter lexicographically:
        if @d[0] lt @l[0] {
            # Join all elements into a string
            return join "",
                # For each index: digit + letter
                map { @d[$_] ~ @l[$_] },
                # Iterate through all indices (both arrays same size)
                0..^@d.elems;
        }
        # Else:
        else {
            # Join all elements into a string
            return join "",
                # For each index: letter + digit
                map { @l[$_] ~ @d[$_] },
                # Iterate through all indices (both arrays same size)
                0..^@d.elems;
        }
    }
}

