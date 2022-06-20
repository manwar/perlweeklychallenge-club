Solutions by Walt Mankowski.

## primes.pm
Both of this week's challenge involve prime numbers. This module contains 2 utility functions, `primes_to` and `prime_factors`. `primes_to($n)` computes the primes up to `$n` using the [Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes). `prime_factors($n, $primes)` finds the prime factors of `$n` using the primes returned by `primes_to()`.

The Sieve algorithm uses an array of flags, and after it's finished any entry with a true value is a prime. To convert that to a list I used the new [`indexed` keyword](https://perldoc.perl.org/builtin#indexed) in Perl 5.36:
```perl
my @primes;
for my ($i, $v) (indexed @is_prime) {
    push @primes, $i if $v;
}
```
This little `for` loop is using 2 different experimental features. Also `indexed` is Perl's new `builtin` namespace. In order to get this to run without warnings I needed to add some boilerplate code to the top of the module:
```perl
use v5.36;
use builtin 'indexed';
no warnings 'experimental::for_list';
no warnings 'experimental::builtin';
```

To find the prime factorization of `$n` we loop through the primes in order. If a prime `$p` divides `$n` evenly, we repeatedly add `$p` to the list of prime factors and divide `$n` by `$p` until it doesn't.
```perl
# return the prime factors of $n as a sorted list
sub prime_factors($n, $primes) {
    my @factors;
    for my $p ($primes->@*) {
        return @factors if $p > $n;
        while ($n % $p == 0) {
            push @factors, $p;
            $n /= $p;
        }
    }
}
```

# Task #1: Brilliant Numbers

For this task we need to find the first 20 **Brilliant Numbers**. A Brilliant number is a number with exactly 2 prime factors of the same length.

This is easy to compute with the functions in `primes.pm`. Since we know from the problem description that the 20th Brilliant number is 299, I start by finding all the primes less than 300. I also set Perl's special variable `$,` to `' '` so when print the values at the end they'll be spaced out nicely.
```perl
$, = ' ';
my $MAX = 300;
my $primes = primes_to($MAX);
```

Then the main loop just follows the problem description. I start the loop at 4 since that's the first composite number.
```perl
my @brilliant;
for (my $n = 4; @brilliant < 20 && $n <= $MAX; $n++) {
    my @factors = prime_factors($n, $primes);
    if (@factors == 2 && length($factors[0]) == length($factors[1])) {
        push @brilliant, $n;
    }
}

say @brilliant;
```

# Task 2: Achilles Numbers

For this task we need to find the first 20 **Achilles Numbers**. An [Achillies number](https://en.wikipedia.org/wiki/Achilles_number) is a number that is **powerful** but not a perfect power. A number is powerful if every prime factor appears at least squared in the factorization.

To test if a number is powerful, I just count how many times each prime factor appears:
```perl
# a number is powerful if there are at least 2 of each prime factor
sub is_powerful(@factors) {
    my %cnt;
    for my $i (@factors) {
        $cnt{$i}++;
    }
    for my $v (values %cnt) {
        return 0 if $v == 1;
    }
    return 1;
}
```

Testing if a number is a perfect power is trickier. Fortunately we know from the problem that we don't need any perfect powers greater than 1800, and powers get big fast so there aren't that many of them. This function generates all of them:
```perl
# there aren't that many perfect powers less than 1800, so since we know
# the answer we'll cheat a little and generate them all ahead of time
sub powers_upto($n) {
    my %powers;
    for my $i (2..sqrt($n)) {
        my $val = $i * $i;
        while ($val <= $n) {
            $powers{$val} = 1;
            $val *= $i;
        }
    }
    return \%powers;
}
```

As with Challenge 1 this week, once we have the functions set up, the actual loop to compute the values is simple.
```perl
my @achilles;
for (my $n = 2; @achilles < 20 && $n <= $MAX; $n++) {
    my @factors = prime_factors($n, $primes);
    if (is_powerful(@factors) && !$perfect_power->{$n}) {
        push @achilles, $n;
    }
}

say @achilles;
```
