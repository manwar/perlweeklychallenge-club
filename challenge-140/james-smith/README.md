# Perl Weekly Challenge #140

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-140/james-smith/perl

# Challenge 1 - Add binary

***Write a script to simulate the addition of the given binary numbers. The script should simulate something like `$a + $b`. (operator overloading)***

## The solution

To allow for operator overloading we need to create a class. `DecBin` will be that class. We have to override to functions:

* `+` - addition
* `==` - comparison

We also override `""` - stringify so we can print the numbers if we want.

Our object is simple a scalar reference. So in `new` we just bless the reference to the number than is passed, and show and comparison just return the scalar pointed to by the reference or compares two of these.

The add function is the more complex function. Working backwards digit by digit

* we add the *carry bit* and the last digit of the remaining string;
* we then use the last digit of this to update the total, but multiplying this by the position multiplier;
* we then move the multiplier one digit to the left by multiplying by 10;
* we then divide the *carry bit* by 2, to see if we need to carry to the next number;
* remove the last digit of the two numbers

We repeat this until we no longer have a carry AND we have processed all digits of the two numbers.

* Note - the *carry bit* will always be 0,1,2,3 after the first addition, as the digits of the two numbers can only be 1 or 0 and the *carry bit* will only ever be 0 and 1 as well.

```perl
package DecBin;

use overload ('+'=>'bin_add','=='=>'comp','""'=>'show');

sub new  { bless \$_[1], $_[0] }
sub show { ${$_[0]} }
sub comp { ${$_[0]} == ${$_[1]} }

sub bin_add {
  my($t,$c,$m,$a,$b) = (0,0,1,${$_[0]},${$_[1]});
  $c+=$a%10+$b%10,$t+=$m*($c&1),$m*=10,$c>>=1,$a=int$a/10,$b=int$b/10 while $a||$b||$c;
  DecBin->new($t);
}
```
The long line may be unreadable - so I also include a multi-line version

```perl
sub bin_add {
  my($t,$c,$m,$a,$b) = (0,0,1,${$_[0]},${$_[1]});
  while ($a||$b||$c) {
    $c +=  $a%10 + $b%10;
    $t +=  $m * ($c&1);
    $m *=  10;
    $c >>= 1;
    $a =   int $a/10;
    $b =   int $b/10;
  }
  DecBin->new($t);
}
```

To show that the overloading works - we use the following test script:

```perl
my @TESTS = (
  [ [  11,  1 ] , 100 ],
  [ [ 101,  1 ] , 110 ],
  [ [ 100, 11 ] , 111 ],
);
foreach(@TESTS) {
  my $x = DecBin->new($_->[0][0]);
  my $y = DecBin->new($_->[0][1]);
  my $z = DecBin->new($_->[1]);
  say join "\t", $x, $y, $x+$y, $z, $x+$y==$z ? 'OK' : 'FAIL';
}
```

with output:

```
11      1       100     100     OK
101     1       110     110     OK
100     11      111     111     OK
```

# Challenge 2 - Multiplication Table

***You are given 3 positive integers, `$i`, `$j` and `$k`. Write a script to print the `$k`th element in the sorted multiplication table of `$i` and `$j`.***

## The solution

Obviously there are two parts to this - a first pass which finds all the numbers and a second pass which counts to find the `$k`th element.

```perl
sub get_num {
  my($i,$j,$k,$t,%h) = @_;
  $t=$_, map { $h{$t*$_}++ } 1..$j for 1..$i;
  $k-=$h{$_}, ($k<1) && (return $_) for sort { $a<=>$b } keys %h;
}
```

Here we do some *naughty* code, using `,` to perform multiple commands in one line; using `map` to perform a for loop (altering values & ignoring the result) and using `&&` to simulate an `if` statement.

In this function each of these is written as a single line. We can expand each of these functions out to see how the algorithm works:

```perl
sub get_num {
  my($i,$j,$k,$t,%h) = @_;
  for $t (1..$i) {
    $h{$t*$_}++ for 1..$j;
  }
  for (sort {$a<=>$b} keys %h) {
    $k -= $h{$_};
    return $_ if $k<1;
  }
}
```

The first `for loop` simply stores the numbers as keys to a hash, whose values are the "frequency" of the number occuring.

The second one finds the answer. We first thing we do is sort the numbers into order as the keys of the hash are un-ordered.

Rather than working up to `$k` we can work down from it to 0. So we subtract the frequency of the current number and if the value is less than `1` then we know this is the number we are looking for and return it's value.

Note we always return in the `for` loop - so don't need a return at the end.

