# MOAR LAZY LISTS!

# Primed list (double entendre 😉) 
my \P := (^Inf).grep: *.is-prime;

# Generate Euclid numbers,
(^Inf).map(-> $i { ([*] P[0..$i]) + 1})\
      .grep(!*.is-prime)[0]\ # filtering by the first non-prime,
      .put; # and output.
