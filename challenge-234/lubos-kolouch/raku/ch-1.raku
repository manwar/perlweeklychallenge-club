sub common-characters(@words) {
    # Convert the first word into a set of characters
    my $common-set = @words[0].comb.Set;

    # Intersect with other words
    for @words[1..*] -> $word {
        $common-set ∩= $word.comb.Set;
    }

    return $common-set.keys;
}

# Testing the Raku solution
say common-characters(<java javascript julia>);  # Output: j a
say common-characters(<bella label roller>);    # Output: e l
say common-characters(<cool lock cook>);        # Output: c o

