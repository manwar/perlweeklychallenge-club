# [Perl Weekly Challenge - 133]

**Trigger warning:** There's lots of math in this week's challenges.  Recovering
math addicts may want to avoid these solutions.  Personally, I've always been
more  the "hooked on phonics" type, so it was fun brushing up on some of these 
mathematical concepts as I worked through my solutions.

## Task 1 > Integer Square Root

You are given a positive integer `$N`.

Write a script to calculate the integer square root of the given number.

Please avoid using built-in function.  Find out more about it [here].

**Examples**

```
Input: $N = 10
Output: 3

Input: $N = 27
Output: 5

Input: $N = 85
Output: 9

Input: $N = 101
Output: 10
```

### Solution

I wasn't familiar with the idea of integer square roots, but after checking out
the linked Wikipedia reference ([here]), I found that the term is equivalent to
the largest integer square root that is less than or equal to our given input
(a square root floor, so to speak.  There are likely more elegant, mathematical
approaches to this problem, but my approach was to just start at 0 and check
incrementing squares until I exceeded the input.

```perl

sub return_int_sqr_root {
  my $input = shift;
  chomp $input;

  # Validate input
  $input =~ s{
    ^\s+ # Leading whitespace
    |
    \s+$ # Trailing whitespace
  }{}gmx;
  if ( !$input =~ /^\d+$/m ) {
    return;
  }

  # Crawl through squares starting with 0
  my $i = 0;
  while ( $i * $i <= $input ) {
    $i++;
  }

  # Return the highest passing number
  return --$i;
}

```

#### `ch-1.pl`

Generally, I try to write a little test runner and some test cases, but in this
case, it felt like overkill, so instead running `./ch-1.pl` initiates a mini
REPL.  The REPL prompts for input and returns the integer square root.  Sample
output is shown below:

```
$> ./ch-1.pl

==============================
Integer Square Root Calculator
==============================

Enter a positive integer (or, type "exit" to quit)> 10
Integer square root: 3
Try again? (y/n)> y
Enter a positive integer (or, type "exit" to quit)> 27
Integer square root: 5
Try again? (y/n)> y
Enter a positive integer (or, type "exit" to quit)> 85
Integer square root: 9
Try again? (y/n)> y
Enter a positive integer (or, type "exit" to quit)> 101
Integer square root: 10
Try again? (y/n)> n
Goodbye.

```

## Task 2 > Smith Number

Write a script to generate the first 10 `Smith Numbers` in base 10.

According to Wikipedia:

> In number theory, a Smith number is a composite number for which, in a given
> number base, the sum of its digits is equal to the sum of the digits in its
> prime factorization in the given number base.

### Solution

At first, the language of this challenge had me feeling a little out of my
depths.  But, breaking down the problem, I realized that it wasn't as
complicated as I had initially believed.  It was clear that I needed a
subroutine to reduce a given number to its prime factors, a subroutine to
reduce a number to the sum of its digits, and that between those two functions,
I could find these "Smith Numbers."  Admittedly, my first solutions were all
incorrect as I glazed right over that phrase "composite number," which, I've
since learned, is a fancy way of saying "ain't prime."

```perl

# First, we need a utility function to find and return our prime factors
sub prime_factors {
  my $number = shift;

  $number =~ s{ # Trim whitespace, probably unnecessary, but it won't hurt
    \A          # Start of the line
    \s+         # Leading whitespace
    |           # Alternating with
    \s+         # Trailing whitespace
    \z          # End of line
  }{}gx;

  # Validate our input is an integer
  if ( !$number =~ m/\A\d+\z/ ) {

    # Bail
    return 0;
  }
  my @factors;
  my $divisor = 2;    # Starting with 2, we'll divide and check for modulo

  while ( $number >= 2 ) {
    if ( $number % $divisor == 0 ) {

      # If modulo is zero, push $divisor to @factors
      push @factors, $divisor;
      $number /= $divisor;
    }
    else {
      # Else, increment $divisor and try again
      $divisor += 1;
    }
  }
  return \@factors;
}

# Helper to reduce number to sum of its digits
sub sum_digits {
  my $number = shift;

  # Trim
  $number =~ s{ \A \s+ | \s+ \z }{}gx;

  # Split digits
  my @digits = split //, $number;

  # Reduce
  my $sum = 0;
  foreach my $digit (@digits) {
    $sum += $digit;
  }
  return $sum;
}

# Find `Smith Numbers` with the help of our two subroutines, `prime_factors`
# and `sum_digits`
sub find_smith_numbers {

  # We need to find the first ten, but we might as well write it to find more
  my $limit = shift // '10';
  my @smith_numbers;

  # Smith Numbers are not prime numbers, so we might as well start at 4
  my $test = '4';

  # Search until we hit our limit
  while ( scalar @smith_numbers < $limit ) {
    my @primes     = @{ prime_factors($test) };
    my $factor_sum = 0;

    # Reduce @primes to sum of its digits
    foreach my $prime (@primes) {
      $factor_sum += sum_digits($prime);
    }

    my $digit_sum = sum_digits($test);

    # Check for matching sums and for prime number (if scalar @primes == 1,
    # $test is a prime number)
    if ( $factor_sum == $digit_sum && scalar @primes != 1 ) {
      push @smith_numbers, $test;
    }

    $test += 1;
  }
  return \@smith_numbers;
}

```

### `ch-2.pl`

Again, this didn't feel like a situation for writing a bunch of tests, as I
wasn't sure the solution even worked until I compared the output against a list
of `Smith Numbers` I found online, so running `./ch-2.pl` will output the first
10 `Smith Numbers` without much in the way of pomp or circumstance.  Optionally,
you can run `./ch-2.pl` with a number argument to display more or less `Smith
Numbers` (i.e., `./ch-2.pl 100` to return the first 100 `Smith Numbers`).
Sample output is shown below:

```
$> ./ch-2.pl 10
The first 10 Smith Numbers are 4, 22, 27, 58, 85, 94, 121, 166, 202, and 265.
```

## Closing

I had a lot of fun with these challenges and picked up a little bit of math that
I might have otherwise avoided like the plague.  Thanks again, PWC.

[Perl Weekly Challenge - 133]: https://theweeklychallenge.org/blog/perl-weekly-challenge-133/
[here]: https://en.wikipedia.org/wiki/Integer_square_root
