Solutions by Walt Mankowski.

# Task #1: Prime Partition

For this task we're given 2 positive integers _m_ and _n_, and we need to find _n_ unique prime numbers that add up to _m_.

To solve this I made use of the `primes_to()` function I wrote for Challenge 169. I also used `Algorithm::Combinatorics` to find combinations of primes taking _n_ at time, and `sum()` from `List::Utils` to find the sum. Using those 3 functions this challenge was easy to solve:

```perl
$, = " ";
my ($m, $n) = @ARGV;
my $primes = primes_to($m);
my $iter = combinations($primes, $n);
while (my $p = $iter->next) {
    say $p->@* if sum($p->@*) == $m;
}
```

I also wrote a version in Python. First I needed to port `primes_to()` to Python:

```python
# find the primes up to n using the sieve of Eratosthenes and return
# them as a list
def primes_to(n):
    is_prime = [True] * (n+1)
    is_prime[0] = is_prime[1] = False
    for i in range(2, int(sqrt(n))+1):
        if is_prime[i]:
            for j in range(i+i, n+1, i):
                is_prime[j] = False

    return [i for i,val in enumerate(is_prime) if val]
```

Then the actual code to solve the challenge ended up looking very similar to the Perl version:

```python
import sys
from itertools import combinations
from primes import primes_to

m, n = [int(x) for x in sys.argv[1:]]
primes = primes_to(m)

for comb in combinations(primes, n):
    if sum(comb) == m:
        print(comb)
```

# Task 2: Five-number Summary

For this task we're given a list of numbers and need to compute their (Five-number Summary)[https://en.wikipedia.org/wiki/Five-number_summary], which consists of

1. The minimum value
2. The lower quartile
3. The median
4. The upper quartile
5. The maximum value

To solve this I first sorted the list. The minimum and maximum values are just the first and last element of the sorted list. Then I wrote a function to compute the median of a sorted list.

```perl
sub median_sorted(@a) {
    my $len2 = int(@a / 2);
    return @a % 2 == 1 ? $a[$len2] : ($a[$len2-1] + $a[$len2]) / 2;
}
```
Once we have that, then the lower quartile is the median of the values before the median in the sorted list, and the upper quartile is the median of the values after the median.

```perl
sub fivenum(@a) {
    my @sorted = sort {$a <=> $b} @a;
    my $min = $sorted[0];
    my $max = $sorted[-1];
    my $median = median_sorted(@sorted);

    my $len2 = int(@sorted / 2);
    my $lower = median_sorted(@sorted[0..$len2-1]);
    my $upper;
    if (@sorted % 2 == 1) { # odd number of elements
        $upper = median_sorted(@sorted[$len2+1..$#sorted]);
    } else {
        $upper = median_sorted(@sorted[$len2..$#sorted]);
    }
    return ($min, $lower, $median, $upper, $max);
}
```

`fivenum()` was a little tricky to port to Python. First, `sorted`, `min`, and `max` are all reserved words to Python, so I had to come up with different names for them. I decided to just prefix all the variable names with an underscore. I also had to be careful because the upper range of slices is inclusive in Perl but exclusive in Python. Here's my version:

```python
def fivenum(a):
    _sorted = sorted(a)
    _min = _sorted[0]
    _max = _sorted[-1]
    _median = median_sorted(_sorted)

    len2 = len(a) // 2
    _lower = median_sorted(_sorted[0:len2])
    if len(a) % 2 == 1: # odd number of elements
        _upper = median_sorted(_sorted[len2+1:])
    else:
        _upper = median_sorted(_sorted[len2:])

    return _min, _lower, _median, _upper, _max
```
