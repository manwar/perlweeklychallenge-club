[< Previous 170](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-170/james-smith) |
[Next 172 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-172/james-smith)

# The Weekly Challenge 171

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-171/james-smith

# The last shall be first, and the first last.

This week we will do two things which are contra to the norm - we will use `pop` to get parameters of a subroutine **AND** we write up task 2 before task 1 - you will understand when we get to challenge 1..

# Challenge 2 - First-class Function
***Create `sub compose($f, $g)` which takes in two parameters `$f` and `$g` as subroutine refs and returns subroutine ref i.e. `compose($f, $g)->($x) = $f->($g->($x))`***

The simple solution is:

```perl
sub compose {
  my( $f, $g ) = @_;
  sub { $f->( $g->(@_) ) }
}
```

We take the two methods `$f`, `$g` and composit this into a single function with sub. we then return this code reference.

Now it would be good if we could do this for multiple functions functions rather than having to do the long winded:

```perl
  my $f = compose( sub {}, compose( sub {}, compose( sub {}, sub {} ) ) );
```

We can re-write `compose` to be a recursive function which composits the last two functions in the supplied list (and adds that composite to the end of the list), and repeats until the list has just a single function in it.

This leads to our first instance of *back to front* - we are so used to always using `shift` to remove parameters within a function, we rarely use `pop`. But in this case `pop` is the right method:

```perl
sub compose {
  my( $g, $f ) = pop;
  @_ && ( $f = pop ) ? compose( @_, sub { $f->($g->(@_)) } ) : $g
}
```

We grab the inner (first to be executed) function (and if it is the only function on the stack we return it) We the grab the next function and composit it with the first one, and push the resultant function back on the end of the list - and call `compose` again! Simples! As I said this is a case first shall be last, and last shall be first, as the first function that we will execute is the last one in the supplied list. Hence why `pop` is appropriate.

# Challenge 1 - Abundant Number

***Write a script to generate first 20 Abundant Odd Numbers. A number `n` for which the sum of divisors `σ(n) > 2n`, or, equivalently, the sum of proper divisors (or aliquot sum) `s(n) > n`.***

## Solution

There are three stages to this:
  * find all the factors;
  * sum them up and
  * compare them...

There are methods available to get all factors of a number (Math::Prime::Util has one) but this week we are going to roll our own.

Firstly looping between `1` and `n` is a long loop especially is `n` is large. But we know that all factors (well nearly all) come in pairs if `f` is a factor of `n` then `f/n` is also a factor. This allows us to short cut the factor finding by only going as far as `sqrt(n)` to find the factors and include `f` and `n/f`. This is where we get to the little gotcha if `f` is the `sqrt(n)` we have to avoid including it twice! See the second line of the equation...

Now note we usually sum from `0` - but we do something slightly different here (1) we start from `1` not zero as we don't include `1` in our search for facotrs. Additionally we subtract `n` as that leads a simpler to read comparision of `$s>0`.

In this example we merge the factor/sum stages together into a single loop.

```perl
sub is_abundant {
  my $s = 1 - (my $t = pop);
  $s += $t%$_ ? 0 : $_ + ( $t-$_*$_ && $t/$_ ) for 2 .. sqrt $t;
  $s>0
}
```
We just then use this to loop through odd numbers until we get 20 abundant numbers.

```
my $k = 1;    is_abundant($k+=2) ? say $k : redo for 1..20;
```

We use the `redo` trick to return 20 results - `redo` calls the method in the loop again, but doens't move to the next iteration of the loop.

### Why we wrote about 2 before 1...

I need a function to test task 2 out - so thought this would be a good problem.

We have the three stages -> factor -> sum -> test which we can male into 3 subs which we can compose together. Note we still do the `-n` trick to avoid passing `n` through from method to method.

```perl
my $factor = sub { my $t = pop; -$t, 1, map { $t%$_ ? () : $t-$_*$_ ? ($_,$t/$_) : $_ } 2..sqrt $t };
my $sum    = sub { my $s = 0; $s+=$_ for @_; $s };
my $check  = sub { pop > 0 };

my $is_abundant = compose $check, $sum, $factor;

my $t = 1; $is_abundant->($t+=2) ? say $t : redo for 1..20;
```

**Note:** we use `pop` here again - as `shift` and `pop` are identical when you have just one parameter - and `pop` is two bytes shorter!
