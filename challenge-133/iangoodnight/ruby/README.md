# [Perl Weekly Challenge - 133] _Ruby Edition_

This is my first crack at a Ruby submission for the PWC.  I'm still pretty new
to the language, and porting my Perl to Ruby is a fun way to explore the syntax.

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

This is pretty much a direct translation of my Perl solution, so it may be that
I am missing some opportunities here. 

```ruby

def int_sqr_root(input)
  if !input.integer? || !input.positive?
    puts 'Input must be a positive integer'
    return
  end
  # Crawl through squares starting with 0
  i = 0
  (i += 1) while i * i <= input
  # Return the highest passing number
  i -= 1
end

```

#### `ch-1.rb`

Running `./ch-1.rb` initiates a mini REPL.  The REPL prompts for input and
returns the integer square root.  Sample output is shown below:

```
$> ./ch-1.rb

==============================
Integer Square Root Calculator
==============================

Enter a positive integer (or, type "exit" to quit)> 10
Integer square root: 3
Try again? (y/n)> y
Enter a positive integer (or, type "exit" to quit)> 27
Integer square root: 5
Try again? (y/n)> 85
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

```ruby

# First, a utility method to find and return our prime factors
def prime_factors(number)
  factors = []
  while number >= 2 # Starting with 2, divide and check modulo
    if (number % divisor ||= 2).zero? # If modulo is zero, push to `factors`
      factors.push(divisor)
      number /= divisor
    else
      divisor += 1 # Else, increment divisor and try again
    end
  end
  factors
end

# Helper method to reduce number to sum of it digits
def sum_digits(number)
  number.to_s.split(//).map(&:to_i).inject(0, :+)
end

# Method to reduce our primes to the sum of their digits
def sum_primes(primes)
  primes.reduce(0) { |sum, prime| sum + sum_digits(prime) }
end

# Find `Smith Numbers` with our methods, `prime_factors`, `sum_digits`,
# `sum_primes`
def find_smith_numbers(limit: 10)
  smith_numbers = []
  test = 4
  while smith_numbers.length < limit.to_i
    primes = prime_factors(test)
    prime_sum = sum_primes(primes)
    digit_sum = sum_digits(test)
    smith_numbers.push(test) if prime_sum == digit_sum && primes.length > 1
    test += 1
  end
  smith_numbers
end

```

#### `ch-2.rb`

Running `./ch-2.rb` outputs the first 10 `Smith Numbers`.  Optionally, a number
argument can be provided to output an arbitrary number of `Smith Numbers` (i.e,
`./ch-2 27` print out the first 27 `Smith Numbers`).  Sample output is shown
below:

```
$> ./ch-2.rb 10
The first 10 Smith Number(s) are 4, 22, 27, 58, 85, 94, 121, 166, 202, and 265.
```

[Perl Weekly Challenge - 133]: https://theweeklychallenge.org/blog/perl-weekly-challenge-133/
[here]: https://en.wikipedia.org/wiki/Integer_square_root
