Solutions by Walt Mankowski.

# Task #1: Abundant Odd Numbers

For this task we need to find the first 20 odd **Abundant Numbers**. An [Abundant number](https://en.wikipedia.org/wiki/Abundant_number) is a number which is less than the sum of its proper divisors.

I don't have much to say about this because it was quite simple to solve this by brute force. My only insight is to note that odd numbers can only have odd divisors, so we only have to check half the possible values.

```perl
sub odd_divisors($n) {
    my @od = (1);
    my $max = $n / 2;
    for (my $i = 3; $i <= $max; $i += 2) {
        push @od, $i if $n % $i == 0;
    }
    return @od;
}
```

I also did a version in Python. In Python we can write `odd_divisors()` basically as a one-liner since `range()` lets us avoid a for loop:

```python
def odd_divisors(n):
    od = [i for i in range(1,n//2+1,2) if n % i == 0]
    return od
```

# Task 2: First-class Function

For this task we needed to create a function `compose(f,g)` that takes in two parameters `f` and `g` as subroutine references, and returns the subroutine `f(g(x))`.

I just wrote this as a very simple function in Perl:

```perl
sub compose($f, $g) {
    return sub { $f->($g->(@_)) };
}
```

Then I tested it by composing 2 functions, one which sums its arguments and another which doubles each of its arguments:

```perl
sub sum {
    my $sum = 0;
    $sum += $_ for @_;
    return $sum;
}

sub double {
    return map { $_ * 2 } @_;
}
```

Here's an example of using it. The output is `20`.

```perl
my $c = compose(\&sum, \&double);
say $c->(1,2,3,4);
```

I never got a version of this working in Python.
