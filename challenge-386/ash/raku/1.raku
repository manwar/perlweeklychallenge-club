# Task 1 of the Weekly Challenge 386
# https://theweeklychallenge.org/blog/perl-weekly-challenge-386/#TASK1

# Output:

# 42
# 15642094
# 493
# 2228519


my @cases =
    ("101010", 2),
    ("EEADEE", 16),
    ("755", 8),
    ("1BRJB", 36);
#   ("7MyqL", 64) # won't work in Raku as the radix range is 2..36

for @cases -> ($num, $base) {
    say $num.parse-base($base);

}

# say :64<1BRJB>; # Error
