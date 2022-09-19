[< Previous 169](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-169/james-smith) |
[Next 171 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-171/james-smith)

# The Weekly Challenge 170

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-170/james-smith

# Challenge 1 - Primorial Numbers

***Write a script to generate first 10 Primorial Numbers - like factorials but multiply by succesive primes.***

## Solution

Another prime problem, in this one we revert to using next_prime to get successive primes. We use a couple more of the methods from `Math::Prime::Util`, `nth_prime` and `forprimes`.

`forprimes {block} $n` executes `{block}` with primes up to and including `$n`. This isn't quite what we want as we want to have `$n` primes - we can get the *n*th prime with suprisingly `nth_prime`. Combining the two gives us `forprimes {block} nth_prime $n`.

We use `bignum` to allow arbitrary integers, so can compute the primorial numbers for large `$n`. In this case to pretty print we use the `commify` method from the perl cookbook {here renamed `th`}. To right align these numbers we need the maximum length of the numbers - which is given by `log($x[-1])/log(10)` to get the digits and multiple by 4/3 to add the commas and add 2 for good measure...

```perl
my @x = (1); forprimes { push @x, $x[-1] * $_ } nth_prime (($ARGV[0]//10)-1);

say sprintf '%'.int(2+4/3*log($x[-1])/log 10).'s', th($_) for @x;

sub th { scalar reverse( (reverse $_[0]) =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1,/gr ) }
```

### Short version....

A short version of this - we remove the flexibility of using the parameters (`N=10`) and instead of working out he 9th prime in code replacing it with 23, gives, the 30 byte code..

```perl
say$a=1;forprimes{say$a*=$_}nth_prime($ARGV[0]//10)-1  # 53 bytes
say$a=1;forprimes{say$a*=$_}nth_prime 9                # 39 bytes
say$a=1;forprimes{say$a*=$_}23                         # 30 bytes
```

### Aside - Last week's challenge - Achilles numbers.

There is a connection with last weeks challenge here. The lowest Achilles number with `n` distinct prime factors is `2 * P(n)^2`

So we have:

| n  | P(n)     | 2 * P(n)^2      | achilles idx | Factorisation |
| -: | -------: | --------------: | -----------: | ------------- |
|  2 |       6  |              72 |            1 | 2<sup>3</sup>.3<sup>2</sup> |
|  3 |      30  |           1,800 |           20 | 2<sup>3</sup>.3<sup>2</sup>.5<sup>2</sup> |
|  4 |     210  |          88,200 |          237 | 2<sup>3</sup>.3<sup>2</sup>.5<sup>2</sup>.7<sup>2</sup> |
|  5 |   2,310  |      10,672,200 |        3,268 | 2<sup>3</sup>.3<sup>2</sup>.5<sup>2</sup>.7<sup>2</sup>.11<sup>2</sup> |
|  6 |  30,030  |   1,803,601,800 |       46,747 | 2<sup>3</sup>.3<sup>2</sup>.5<sup>2</sup>.7<sup>2</sup>.11<sup>2</sup>.13<sup>2</sup> |
|  7 | 510,510  | 521,240,920,200 |      826,862 | 2<sup>3</sup>.3<sup>2</sup>.5<sup>2</sup>.7<sup>2</sup>.11<sup>2</sup>.13<sup>2</sup>.17<sup>2</sup> |

# Challenge 2 - Kronecker Product

***Write a script to implement Kronecker Product on the given 2 matrices. e.g.***

## Example

Hard to describe - but here is an example.... see https://en.wikipedia.org/wiki/Kronecker_product
```
A = [ 1 2 ]  B = [ 5 6 ]
    [ 3 4 ]      [ 7 8 ]

A x B = [ 1 x [ 5 6 ]  2 x [ 5 6 ] ]  = [ 1x5 1x6 2x5 2x6 ]  = [  5  6 10 12 ]
        [     [ 7 8 ]      [ 7 8 ] ]    [ 1x7 1x8 2x7 2x8 ]    [  7  8 14 16 ]
        [ 3 x [ 5 6 ]  4 x [ 5 6 ] ]    [ 3x5 3x6 4x5 4x6 ]    [ 15 18 20 24 ]
        [     [ 7 8 ]      [ 7 8 ] ]    [ 3x7 3x8 4x7 4x8 ]    [ 21 24 28 32 ]
```

## Solution

Arrays are just lists of lists, and so we can use constructs like `map` and `for` to process these.
In this case we don't need to use `for`s as we can use `map` in all cases.

This is one of those cases where writing the code is easier than explaining what it does.

We have 4 `map`s... The outer two loop over the rows of `A` and `B` respectively, the inner two loop over
the entries in those rows (from matricies `A` and `B` respectively. Because the "loop variable" is `$_`
for each `map` the first thing we do in all but the inner loop is assign it to another variable.

```perl
sub k_product {
  [ map { my $r = $_; map { my $t = $_; [ map { my $s=$_; map { $s*$_ } @{$t} } @{$r} ] } @{$_[1]} } @{$_[0]} ]
}

```

Now we can use some of our "optimization" techniques to make this slightly smaller. Firstly we use
special variables, `$a`, `$b` and `$'` to replace the variables `$r`, `$s`, `$t` above. We also assign `$_`
to `$'` using the regex trick `//` which does this under the hood. We also remove the optional brackets
around `{$a}` & `{$b}` where dererencing.

This gives a slightly more compact version (73 characters!)

```perl
sub k{[map{$b=$_;map{$a=$_;[map{//;map{$'*$_}@$a}@$b]}@{$_[1]}}@{$_[0]}]}
```

### Pretty print dumper...

To display the data we have a lightweight pretty print function which displays the matricies:

```perl
sub d{say"[ @{[map{sprintf'%6d',$_}@$_]} ]"for@{$_[0]};say''}
```

Example output for the matrices A & B above, along with the output of `k_product` and the shorter `k`.

```
[      1      2 ]
[      3      4 ]

[      5      6 ]
[      7      8 ]

[      5      6     10     12 ]
[      7      8     14     16 ]
[     15     18     20     24 ]
[     21     24     28     32 ]

[      5      6     10     12 ]
[      7      8     14     16 ]
[     15     18     20     24 ]
[     21     24     28     32 ]
```

The `d` method uses the nice feature in perl of interpolating the result of an artibrary function
within a string. You can use `"@array"` to insert all values of the array into a string (separated with a space.
(e.g. `print @a` and `print "@a"` do subtly different things - the first the elements of `@a` are not separated.
In the second they are separated by ` `s.

But I digress - you can actually use the output of any function to produce array. A simple function can be interpolated
as `"@{[ my_fun() ]}"`. Commonly you can use a `map`.

```perl
"Output:  @{[ map { qq('$_') } @array ]}"
```

This can be quite useful.


### Aside

This was code I wrote about 20 years ago to produce a nicely formatted HTML table (note the HTML 3 standard `valign="middle"`)
Yes - it is basically one string.... Full code plus examples is in: <a href="perl/original-spreadsheet-code.pl">perl/original-spreadsheet-code.pl</a>.


```perl
sub produce_table{
  my( $C,$T ) = (0,{});
## no critic (ImplicitNewlines)
  return map {
    qq(<table cellpadding="2" cellspacing="0" align="@{[
      exists $_[2]{align} ?
        $_[2]{align} :
        'center'
    ]}" width="@{[
      exists $_[2]{width} ?
      $_[2]{width} :
      '$MAX_VALUE0%'
    ]}">@{[
      map( {
        $T->{$_->{key}||$C}=0 if exists $_->{total};
        $C++;
        ()
      }@{$_[0]} ), ($_[2]{'header'}||'' eq 'no' ?
        () :
        qq(<tr valign="middle">@{[
          map{
            $T->{$_->{key}||$C}=0 if exists $_->{total};
            $C++;
            qq(<th>$_->{title}</th>)
          }@{$_[0]}
        ]}</tr>))
    ]}@{[
      map{
        my $a=$_;
        $C=0;
        qq(<tr valign="@{[
          exists $_[2]{valign} ?
          $_[2]{valign} :
          'top'
        ]}" @{[
          exists $_[2]{rows} ?
            qq( class="@{[
              [ push( @{$_[2]{rows}},shift @{$_[2]{rows}}) , $_[2]{rows}[-1] ]->[1]
            ]}") :
            ''
        ]}>@{[
          map{
            my $b = ref($a) eq 'ARRAY' ?
              $a->[$C] :
              ref($a) eq 'HASH' ?
                $a->{$_->{key}} :
                $a->${\$_->{key}};
            exists $_->{total} and $T->{$_->{key}||$C}+=$b;
            $C++;
            qq(<td@{[
              $_->{align} ?
                qq( align="$_->{align}") :
                ''
            ]}@{[
              $_->{width} ?
                qq( width="$_->{width}") :
                ''
            ]}>@{[
              $b eq'' ?
                '&nbsp;' :
                $_->{format} ?
                  $_->{format}->($b,$a) :
                  $b
            ]}</td>)
          }@{$_[0]}
        ]}</tr>)
      }@{$_[1]}
    ]}@{[
      ($C=-1)&&%$T ?
        qq(<tr valign="@{[
          exists $_[2]{valign} ?
          $_[2]{valign} :
          'top'
        ]}">@{[
          map {
            $C++;
            qq(<td @{[
              $_->{align} ?
                qq( align="$_->{align}") :
                ''
            ]}>@{[
              !exists $_->{total} ?
                '&nbsp;' :
                ref $_->{total} eq 'CODE' ?
                  $_->{total}->($T->{$_->{key}||$C},$T) :
                  $_->{total} || $T->{$_->{key}||$C}
            ]}</td>)
          } @{$_[0]}
        ]}</tr>) :
        ''
    ]}</table>)
  } 1;
## use critic;
}
```
