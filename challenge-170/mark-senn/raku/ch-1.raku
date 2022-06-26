use v6.d;

my $n = 10;

# Let p be 1 followed by prime numbers for n total numbers.
my @p = (1..*).grep({$_ == 1 || .is-prime}).head($n);

# Do the element multiplications.
@p[$_] = @p[$_-1] * @p[$_] for (2..9);
@p.say;
