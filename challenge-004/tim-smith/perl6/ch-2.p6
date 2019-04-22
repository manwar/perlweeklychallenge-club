# First input line is a list of letters
my \letters = bag get.uc.comb: /\w/;
# Subsequent lines are words to be tested
for lines() {
    .say if letters ⊇ .uc.comb;
}
