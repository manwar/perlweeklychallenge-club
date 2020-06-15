#!raku

# You are given a string $S. Write a script print all possible partitions that gives Palindrome.
# Return -1 if none found.
# Please make sure, partition should not overlap.
# For example, for given string “abaab”,
# the partition “aba” and “baab” would not be valid, since they overlap.


sub MAIN( Str $S where { $S.chars > 0 } = "abaab" ){
    "Searching non overlapping palindrome partitions on $S".say;
    my @palindromes;

    my $last = -1;
    for 0 ..^ $S.chars -> $start {
        # avoid overlapping
        next if $start <= $last;

        for $start + 1 ..^ $S.chars -> $end {
            my $string = $S.split( '', :skip-empty )[ $start .. $end ];
            if $string ~~ $string.reverse {
                @palindromes.push: $string;
                # avoid overlapping
                $last = $end;
                last;
            }

        }
    }

    @palindromes ?? @palindromes.join( ',' ).say !! "-1";
}
