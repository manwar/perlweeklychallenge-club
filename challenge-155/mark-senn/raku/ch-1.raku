use v6.d;

# Print the first 8 unique and sorted Fortunate Numbers.
my $n = 8;

# Guess that first 50 primes and primorials will give
# the first 8 unique and sorted Fortunate Numbers.
my $nn = 50;

# Get the first nn primes.
my @prime = (2..*).grep(&is-prime).head($nn);

# Compute the first nn primorials.
my @primorial;
@primorial[0]= @prime[0];
for (1..^$nn)
{
    @primorial[$_] = @primorial[$_-1] * @prime[$_];
}

# Save the first $nn m's.
my @m = ();
# Loop through the first nn primorials.
for (0..^$nn) -> $i
{
    # For each primorial check if it plus m is prime, for m = 2 to whatever.
    for (2..*) -> $m
    {
    	(@primorial[$i] + $m).is-prime and @m.push($m), last;
    }
}

# Print the first 8 unique and sorted Fortunate Numbers.
@m.unique.sort.head(8).join(', ').say;
