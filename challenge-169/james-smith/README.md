[< Previous 168](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-168/james-smith) |
[Next 170 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-170/james-smith)

# The Weekly Challenge 169

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-169/james-smith

# Challenge 1 - Brilliant numbers 

***Write a script to generate first 20 Brilliant Numbers.  Brilliant numbers are numbers with two prime factors of the same length.  The number should have exactly two prime factors, i.e. it’s the product of two primes of the same length.***


## Solution

Again our favoured prime package `Math::Prime::Util` has the method we need `factor` which returns a list of prime factors, and its fast - especially for the magnitude of numbers we are looking at.

We loop through all numbers, checking to see if (a) the number has exactly 2 prime factors and they are the same length.

For flexibility we define the max count `$MAX` as the command-line argument if one is supplied (or 100 if not).

```perl
for( my( $MAX, $c, $n, @f ) = ($ARGV[0] // 1e2, 0); $c<$MAX; ) {
  printf "%8d: %10d = %5d x %d\n", ++$c, $n, @f if 2 == ( @f = factor ++$n ) && length $f[0] == length $f[1]
}
```

This logic is wrapped up in the single `if`. As we check the number of factors, we store these in an array, so that we can check the 2nd condition.

The output in each row is the brilliant number and the two primes which are it's factors.

**Note:** Both in this and the next challenge we utilise a classic "c-style" `for`-loop. This construct allows us to combine the variable initialized (and declaration), the end condition, and the increment of the number into a single statement. We code rewrite this a postfix `for(each)` in this case, but would need an declaration/initialisation statement for `$n` and `@f` anyway. Also in challenge 2 it isn't possible to use a postfix for `for` as this doesn't allow us to use the `next` trick to short cut the `grep` inside the `gcd` call.

**Note:** to make the code easier to read we use a *Yoda* condition, where we reverse the value and the code evaluation - so instead if say `$a == 2` we say `2 == $a`.

**Moan:** Why is there no `sayf` function similar to `printf` - using `say sprintf` is just "messy" each time...

The first 50 brilliant numbers are:

```
       1:          4 =     2 x 2
       2:          6 =     2 x 3
       3:          9 =     3 x 3
       4:         10 =     2 x 5
       5:         14 =     2 x 7
       6:         15 =     3 x 5
       7:         21 =     3 x 7
       8:         25 =     5 x 5
       9:         35 =     5 x 7
      10:         49 =     7 x 7
      11:        121 =    11 x 11
      12:        143 =    11 x 13
      13:        169 =    13 x 13
      14:        187 =    11 x 17
      15:        209 =    11 x 19
      16:        221 =    13 x 17
      17:        247 =    13 x 19
      18:        253 =    11 x 23
      19:        289 =    17 x 17
      20:        299 =    13 x 23
      21:        319 =    11 x 29
      22:        323 =    17 x 19
      23:        341 =    11 x 31
      24:        361 =    19 x 19
      25:        377 =    13 x 29
      26:        391 =    17 x 23
      27:        403 =    13 x 31
      28:        407 =    11 x 37
      29:        437 =    19 x 23
      30:        451 =    11 x 41
      31:        473 =    11 x 43
      32:        481 =    13 x 37
      33:        493 =    17 x 29
      34:        517 =    11 x 47
      35:        527 =    17 x 31
      36:        529 =    23 x 23
      37:        533 =    13 x 41
      38:        551 =    19 x 29
      39:        559 =    13 x 43
      40:        583 =    11 x 53
      41:        589 =    19 x 31
      42:        611 =    13 x 47
      43:        629 =    17 x 37
      44:        649 =    11 x 59
      45:        667 =    23 x 29
      46:        671 =    11 x 61
      47:        689 =    13 x 53
      48:        697 =    17 x 41
      49:        703 =    19 x 37
      50:        713 =    23 x 31
```
### Removing pretty print

If we remove the pretty print this reduces to:

```perl
for( my( $c, $n, @f ) = 100; $c; ) {
  $c--, say $n if 2 == ( @f = factor ++$n ) && length $f[0] == length $f[1]
}
```

**Notes:** As well as moving the pretty print (and the $MAX for simplicity) we do three things:
 * We start $c at the number of entries we want, and decrement the counter each time - the end condition is then simple `$c == 0` or as we write a "continue" condition that is just `$c`.
 * As above we remove the increment from the `for()` to the entry - in this case ++$n. As we don't initialize `$n`, we have to "pre-increment" so that `$n` is defined when factor is called.
 * Finally to display the brilliant number AND decrement `$c`, we separate the two commands with a `,` as `$c--, say $n`.

# Challenge 2 - Achilles Number

***Write a script to generate first 20 Achilles Numbers. An Achilles number is a number that is powerful but imperfect (not a perfect power). Named after Achilles, a hero of the Trojan war, who was also powerful but imperfect.***

*A positive integer `n` is a powerful number if, for every prime factor `p` of `n`, `p^2` is also a divisor.*

*A number is a perfect power if it has any integer ropts ( square, cube, ... ) i.e. can be written in the form `n^m`.*

*An imperfect number is one which can't be - now this means that if we make a prime factorization of the form `p1^k1 . p2^k2 . p3^k3 ....` then the greatest common divisor is 1. As if greater than 1 then we could write this as `( p1^k1/gcd . p2^k2/gcd . p3^k3/gcd . ... )^gcd` and so would be perfect.

## Solution

Again `Math::Prime::Util` has the two methods we need `factor_exp` and `gcd`. The former a modification to `factor` returns a list of tuples, each containing the prime and its exponent so rather than returning say `2, 2, 2, 3, 3` it returns `[2, 3], [3, 2]`. The latter a function we haven't used before takes a list of numbers and computes there greatest common divisor. This simplfies the problem... for each value we generate a hash of their prime factors, the key being the prime and the value the power (using `factor`)

We then check to see if any of the factors does not have its square as a factor. We do this in the grep - by using `next` we jump out of the `map` back to the next entry in the `for` loop.

We then compute the `gcd` of these powers - if it is 1 then we display the result - our output is index, value and the prime factorisation, most of the loop is for the pretty print.

```perl
for( my( $MAX, $c, $n, @f ) = ($ARGV[0] // 1e2, 0); $c<$MAX; ) {
  printf "%6d: %15d = %s\n", ++$c, $n, join ' . ', map  { join '^', @$_ } @f
    if 1 == gcd map { $_->[1] < 2 ? next : $_->[1] } @f = factor_exp ++$n
}
```

The following are the first 50 achilles numbers.

| Index        | Value                | Factors                                                      |
| -----------: | -------------------: | ------------------------------------------------------------ |
|            1 |                   72 | 2<sup>3</sup>.3<sup>2</sup>                                  |
|            2 |                  108 | 2<sup>2</sup>.3<sup>3</sup>                                  |
|            3 |                  200 | 2<sup>3</sup>.5<sup>2</sup>                                  |
|            4 |                  288 | 2<sup>5</sup>.3<sup>2</sup>                                  |
|            5 |                  392 | 2<sup>3</sup>.7<sup>2</sup>                                  |
|            6 |                  432 | 2<sup>4</sup>.3<sup>3</sup>                                  |
|            7 |                  500 | 2<sup>2</sup>.5<sup>3</sup>                                  |
|            8 |                  648 | 2<sup>3</sup>.3<sup>4</sup>                                  |
|            9 |                  675 | 3<sup>3</sup>.5<sup>2</sup>                                  |
|           10 |                  800 | 2<sup>5</sup>.5<sup>2</sup>                                  |
|           11 |                  864 | 2<sup>5</sup>.3<sup>3</sup>                                  |
|           12 |                  968 | 2<sup>3</sup>.11<sup>2</sup>                                 |
|           13 |                  972 | 2<sup>2</sup>.3<sup>5</sup>                                  |
|           14 |                1,125 | 3<sup>2</sup>.5<sup>3</sup>                                  |
|           15 |                1,152 | 2<sup>7</sup>.3<sup>2</sup>                                  |
|           16 |                1,323 | 3<sup>3</sup>.7<sup>2</sup>                                  |
|           17 |                1,352 | 2<sup>3</sup>.13<sup>2</sup>                                 |
|           18 |                1,372 | 2<sup>2</sup>.7<sup>3</sup>                                  |
|           19 |                1,568 | 2<sup>5</sup>.7<sup>2</sup>                                  |
|           20 |                1,800 | 2<sup>3</sup>.3<sup>2</sup>.5<sup>2</sup>                    |
|           21 |                1,944 | 2<sup>3</sup>.3<sup>5</sup>                                  |
|           22 |                2,000 | 2<sup>4</sup>.5<sup>3</sup>                                  |
|           23 |                2,312 | 2<sup>3</sup>.17<sup>2</sup>                                 |
|           24 |                2,592 | 2<sup>5</sup>.3<sup>4</sup>                                  |
|           25 |                2,700 | 2<sup>2</sup>.3<sup>3</sup>.5<sup>2</sup>                    |
|           26 |                2,888 | 2<sup>3</sup>.19<sup>2</sup>                                 |
|           27 |                3,087 | 3<sup>2</sup>.7<sup>3</sup>                                  |
|           28 |                3,200 | 2<sup>7</sup>.5<sup>2</sup>                                  |
|           29 |                3,267 | 3<sup>3</sup>.11<sup>2</sup>                                 |
|           30 |                3,456 | 2<sup>7</sup>.3<sup>3</sup>                                  |
|           31 |                3,528 | 2<sup>3</sup>.3<sup>2</sup>.7<sup>2</sup>                    |
|           32 |                3,872 | 2<sup>5</sup>.11<sup>2</sup>                                 |
|           33 |                3,888 | 2<sup>4</sup>.3<sup>5</sup>                                  |
|           34 |                4,000 | 2<sup>5</sup>.5<sup>3</sup>                                  |
|           35 |                4,232 | 2<sup>3</sup>.23<sup>2</sup>                                 |
|           36 |                4,500 | 2<sup>2</sup>.3<sup>2</sup>.5<sup>3</sup>                    |
|           37 |                4,563 | 3<sup>3</sup>.13<sup>2</sup>                                 |
|           38 |                4,608 | 2<sup>9</sup>.3<sup>2</sup>                                  |
|           39 |                5,000 | 2<sup>3</sup>.5<sup>4</sup>                                  |
|           40 |                5,292 | 2<sup>2</sup>.3<sup>3</sup>.7<sup>2</sup>                    |
|           41 |                5,324 | 2<sup>2</sup>.11<sup>3</sup>                                 |
|           42 |                5,400 | 2<sup>3</sup>.3<sup>3</sup>.5<sup>2</sup>                    |
|           43 |                5,408 | 2<sup>5</sup>.13<sup>2</sup>                                 |
|           44 |                5,488 | 2<sup>4</sup>.7<sup>3</sup>                                  |
|           45 |                6,075 | 3<sup>5</sup>.5<sup>2</sup>                                  |
|           46 |                6,125 | 5<sup>3</sup>.7<sup>2</sup>                                  |
|           47 |                6,272 | 2<sup>7</sup>.7<sup>2</sup>                                  |
|           48 |                6,728 | 2<sup>3</sup>.29<sup>2</sup>                                 |
|           49 |                6,912 | 2<sup>8</sup>.3<sup>3</sup>                                  |
|           50 |                7,200 | 2<sup>5</sup>.3<sup>2</sup>.5<sup>2</sup>                    |


Some examples for larger values of `n` are:

| Index        | Value                | Factors                                                      |
| -----------: | -------------------: | ------------------------------------------------------------ |
|          100 |               21,600 | 2<sup>5</sup>.3<sup>3</sup>.5<sup>2</sup>                    |
|          200 |               66,248 | 2<sup>3</sup>.7<sup>2</sup>.13<sup>2</sup>                   |
|          300 |              136,107 | 3<sup>3</sup>.71<sup>2</sup>                                 |
|          400 |              225,000 | 2<sup>3</sup>.3<sup>2</sup>.5<sup>5</sup>                    |
|          500 |              333,396 | 2<sup>2</sup>.3<sup>5</sup>.7<sup>3</sup>                    |
|          600 |              464,648 | 2<sup>3</sup>.241<sup>2</sup>                                |
|          700 |              617,400 | 2<sup>3</sup>.3<sup>2</sup>.5<sup>2</sup>.7<sup>3</sup>      |
|          800 |              784,000 | 2<sup>7</sup>.5<sup>3</sup>.7<sup>2</sup>                    |
|          900 |              969,624 | 2<sup>3</sup>.3<sup>3</sup>.67<sup>2</sup>                   |
|        1,000 |            1,179,648 | 2<sup>17</sup>.3<sup>2</sup>                                 |
|        2,000 |            4,255,443 | 3<sup>3</sup>.397<sup>2</sup>                                |
|        3,000 |            9,082,800 | 2<sup>4</sup>.3<sup>3</sup>.5<sup>2</sup>.29<sup>2</sup>     |
|        4,000 |           15,635,232 | 2<sup>5</sup>.3<sup>2</sup>.233<sup>2</sup>                  |
|        5,000 |           23,876,179 | 19<sup>3</sup>.59<sup>2</sup>                                |
|        6,000 |           33,818,428 | 2<sup>2</sup>.7<sup>3</sup>.157<sup>2</sup>                  |
|        7,000 |           45,489,708 | 2<sup>2</sup>.3<sup>3</sup>.11<sup>2</sup>.59<sup>2</sup>    |
|        8,000 |           58,752,800 | 2<sup>5</sup>.5<sup>2</sup>.271<sup>2</sup>                  |
|        9,000 |           73,641,248 | 2<sup>5</sup>.37<sup>2</sup>.41<sup>2</sup>                  |
|       10,000 |           90,209,312 | 2<sup>5</sup>.23<sup>2</sup>.73<sup>2</sup>                  |
|       20,000 |          344,478,752 | 2<sup>5</sup>.17<sup>2</sup>.193<sup>2</sup>                 |
|       30,000 |          758,595,456 | 2<sup>7</sup>.3<sup>5</sup>.29<sup>3</sup>                   |
|       40,000 |        1,330,259,301 | 3<sup>3</sup>.7<sup>3</sup>.379<sup>2</sup>                  |
|       50,000 |        2,057,748,300 | 2<sup>2</sup>.3<sup>7</sup>.5<sup>2</sup>.97<sup>2</sup>     |
|       60,000 |        2,941,077,600 | 2<sup>5</sup>.3<sup>7</sup>.5<sup>2</sup>.41<sup>2</sup>     |
|       70,000 |        3,978,593,667 | 3<sup>3</sup>.61<sup>2</sup>.199<sup>2</sup>                 |
|       80,000 |        5,171,352,984 | 2<sup>3</sup>.3<sup>5</sup>.7<sup>2</sup>.233<sup>2</sup>    |
|       90,000 |        6,518,604,456 | 2<sup>3</sup>.3<sup>2</sup>.7<sup>2</sup>.13<sup>3</sup>.29<sup>2</sup> |
|      100,000 |        8,017,975,944 | 2<sup>3</sup>.3<sup>3</sup>.11<sup>3</sup>.167<sup>2</sup>   |
|      125,000 |       12,437,566,904 | 2<sup>3</sup>.7<sup>3</sup>.2129<sup>2</sup>                 |
|      150,000 |       17,810,638,848 | 2<sup>11</sup>.3<sup>2</sup>.983<sup>2</sup>                 |
|      175,000 |       24,140,196,992 | 2<sup>7</sup>.31<sup>2</sup>.443<sup>2</sup>                 |
|      200,000 |       31,413,171,744 | 2<sup>5</sup>.3<sup>2</sup>.17<sup>3</sup>.149<sup>2</sup>   |
|      225,000 |       39,636,156,125 | 5<sup>3</sup>.17807<sup>2</sup>                              |
|      250,000 |       48,804,377,888 | 2<sup>5</sup>.7<sup>4</sup>.797<sup>2</sup>                  |
|      275,000 |       58,919,206,088 | 2<sup>3</sup>.85819<sup>2</sup>                              |
|      300,000 |       69,976,609,587 | 3<sup>3</sup>.50909<sup>2</sup>                              |
|      325,000 |       81,981,196,443 | 3<sup>3</sup>.55103<sup>2</sup>                              |
|      350,000 |       94,917,245,000 | 2<sup>3</sup>.5<sup>4</sup>.4357<sup>2</sup>                 |
|      375,000 |      108,802,180,800 | 2<sup>6</sup>.3<sup>5</sup>.5<sup>2</sup>.23<sup>4</sup>     |

And these are the first numbers with `n` digits...

| Index        | Value                | Factors                                                      |
| -----------: | -------------------: | ------------------------------------------------------------ |
|            1 |                   72 | 2<sup>3</sup>.3<sup>2</sup>                                  |
|            2 |                  108 | 2<sup>2</sup>.3<sup>3</sup>                                  |
|           14 |                1,125 | 3<sup>2</sup>.5<sup>3</sup>                                  |
|           61 |               10,125 | 3<sup>4</sup>.5<sup>3</sup>                                  |
|          253 |              100,352 | 2<sup>11</sup>.7<sup>2</sup>                                 |
|          917 |            1,000,188 | 2<sup>2</sup>.3<sup>6</sup>.7<sup>3</sup>                    |
|        3,159 |           10,011,125 | 5<sup>3</sup>.283<sup>2</sup>                                |
|       10,554 |          100,018,800 | 2<sup>4</sup>.3<sup>6</sup>.5<sup>2</sup>.7<sup>3</sup>      |
|       34,562 |        1,000,042,200 | 2<sup>3</sup>.3<sup>6</sup>.5<sup>2</sup>.19<sup>3</sup>     |
|      111,892 |       10,000,373,888 | 2<sup>7</sup>.8839<sup>2</sup>                               |
|      359,341 |      100,001,075,328 | 2<sup>7</sup>.3<sup>2</sup>.7<sup>2</sup>.11<sup>6</sup>     |

### Github formatting script....

To convert from the human readable text file generated by the script to github markup I wrote this script:

```perl
head();
while( <> ) {
  head(), next unless /\S/;
  my ($c,$n,$p) = m{(\d+):\s+(\d+)\s+=\s+(.*)$};
  printf "| %12s | %20s | %-60s |\n", th($c), th($n),
    join q(.), map { sprintf '%d<sup>%d</sup>', split /\^/ } split / \. /, $p
}

sub head { print "\n| Index        | Value                | Factors                                                      |
| -----------: | -------------------: | ------------------------------------------------------------ |\n" }
sub th { scalar reverse ( (reverse $_[0]) =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1,/gr ) }
```
### Removing pretty print

If we remove the pretty print this reduces to:

```perl
for( my( $c, $n ) = 100; $c; ) {
  $c--, say $n if 1 == gcd map{ $_->[1] < 2 ? next : $_->[1] } factor_exp ++$n
}
```

# Note - product vs factor

There is a different method which is to generate a list of numbers for both problems from a list of primes.

For both challenges I looked at this "product" version of the code (generate a list of primes) and multiplying - rather the factor method. This proved to be slower than the loop through all values of `$n` and filter by factoring. Whether this continues for larger values of `$n` I don't know by I know that producing the first 1 million of each number it was slower, and at that point the product methods then started to hit memory problems.

One of the memory issues is the `sort` a list issue - having to keep multiple large lists in memory. There are work arounds (like using a modified merge sort) but again these have their coding overheads.

If I had to roll my own "factor" code it would almost certainly have been a better option - but the `Math::Prime::Util` methods are plenty fast enough.
