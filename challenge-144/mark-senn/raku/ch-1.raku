# Generate all semiprime numbers <= 100.
my $n = 100;

# Make a list of primes. Using primes <= $n/2 is more than enough.
my @prime = (2 .. $n/2).grep(*.is-prime);

# Multiply each prime by every other prime in the list.
# save the products that are <= 100,
# sort this list numerically,
# save the unique numbers on the list,
# and print the list.
(@prime X* @prime).grep(* <= 100).sort(+*).unique.say;
