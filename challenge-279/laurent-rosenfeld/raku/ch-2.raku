sub split-string ($in) {
    return $in.comb(/:i <[aeiou}]>/).elems %% 2;
}

for "Perl", "book", "bOok", "good morning" -> $test {
    printf "%-15s => ", $test;
    say split-string $test;
}
