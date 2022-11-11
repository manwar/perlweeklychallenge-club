[< Previous 188](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-188/james-smith) |
[Next 190 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-190/james-smith)

# The Weekly Challenge 189

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-189/james-smith

# Task 1 - Capital Dectection

***You are given a string with alphabetic characters only: `A..Z` and `a..z`. Write a script to find out if the usage of Capital is appropriate if it satisfies at least one of the following rules:***

## Solution

This is relatively simple - there are two cases:

 * a string made entirely of captial letters
 * a string characters two onwards are lower case.

OR we can invert it and say that it does not match if we have either

 * a lower case followed by an upper case letter
 * two upper case letters followed by a lower case letter.

It is surprising though how we can apply these rules.

 * a single regular expression
 * two regular expressions

and even then the two parts can be re-ordered...

I will include just two of those here..

```perl
## Positive - two regexs
sub capital_split { $_[0] =~ m{^[a-zA-Z][a-z]*$} || $_[0] =~ m{^[A-Z]+$} ? 1 : 0 }
## Negatice - one regex
sub capital_neg1  { $_[0] =~ m{(?:[a-z][A-Z]|[A-Z]{2}[a-z])}             ? 0 : 1 }
```

Using real world text - 90%+ lowercase / capitalised lowercase - gives the positive method as the fastest AND splitting the regular expression into two separate parts with the lowercase expression first gives best performance.

# Task 2 - Decoded list

***You are given an encoded string consisting of a sequence of numeric characters: 0..9, $s.  Write a script to find the all valid different decodings in sorted order.  Encoding is simply done by mapping A,B,C,D,... to 1,2,3,4,... etc.

## Solution

This one as a much more interesting challenge. A first pass gives us a recursive solution.

 * If the first characters is between 1 and 9 we decode to A to I and then work out the encodings for the remainder of the string...
 * If the first character is 1 OR the first character is 2 and the second between 0 and 6 then we encode to J to Z and then find all the codings for the rest of the string... 

This gives:

```perl
sub decoded_rec {
  return $_[0] eq '' ? '' : $_[0] eq '0' ? () : chr(64 + $_[0]) if 2 > length $_[0];
  my($f,$s,$r) = split m{}, $_[0], 3;
  $r ||= '';
  ( $f      && $s                ? ( map { chr(           $f + 64 ) . $_ } decoded_rec($s.$r) ) : (),
    $f == 1 || $f == 2 && $s < 7 ? ( map { chr( $f * 10 + $s + 64 ) . $_ } decoded_rec($r   ) ) : () );
}
```

We get the first & second characters by splitting the string into characters. We use the three parameter version of split which limits the number of pieces the string is split into.

## Every recursive solution can be converted into an iterative solution....

People say you can take any recursive solution and convert to an iterative solution. This is perfectly true - but often to do it we have to jump through hoops.

Our first challenge is to enumerate the solutions.

The initial thought is that at each stage we have two decisions - choose one letter or choose two letters. So we can think of this a purely binary.

From `0 .. 2^(n-1)-1` we use a bit mask to chose whether to chose one or two digits. Until we get to the end of the string.

```perl
sub decoded_nonrec {
  my @res;
  O: for my $s ( 0 .. 1 << length $_[0]-1 ) {
    my($n,$res,$x) = ($_[0],'');
    while($n) {
      #warn "** $n";
        $s & 1  ? ( ($x = substr $n,0,1,'') eq '0' ? (next O) : ($res .= chr $x + 64) )
      : $n < 10 ? (next O)
      :           ( ($x = substr $n,0,2,'') < 10 || $x > 26 ? (next O) : ($res .= chr $x + 64) );
      $s>>=1, $n eq '' && ( $s ? next O : last );
    }
    unshift @res, $res;
  }
  sort @res
}
```

Now this is much worse than the recursive solution? Why? Well for a lot of the routes we get to the end of the string before we have looped through all the *bits* of the index - because we shift off two digits on many occassions. So? how can we improve?

Well first we note that the number of solutions for n digits is the sum of the number of solutions for n-1 & n-2 digits. This sequence is just the Fibonacci sequence.

Firstly this indicates why we are much slower than the first solution.. The number of valid loops is `f(n-1)/2^n-1` which for 10 digits is approximately 10% of those tried...

So we then look to see if we can use the fibonnaci sequence to help decode the strings...

For a given index from `0 .. fib(n)-1` we look to see if the number is below `fib(n-1)` if it is we chose 1 digit o/w we choose 2. In the later case we reduce the index by `fib(n-1)` we repeate this for `n-2` etc....

We have some cases where we can speed performance up, e.g. if we find a `0` we know for the next `fib(k)` they will always fail so we can jump ahead. The same goes for two digits if we get a value of more than 26.

This gives us the following code... Note we iterate backwards and `unshift` rather than forwards and `push`...

```perl
sub decoded_nonrec_fib {
  my($s,$l,@res,$t,$k,$n,$res,$x) = ( $fib[length $_[0]], length $_[0] );
  O: for (;$s>0;) {
    ($t,$k,$n,$res) = ($s,$l,$_[0],'');
    while( $n ) {
      $t <= $fib[--$k]
    ? (
        ($x = substr $n,0,1,'') ? ($res.=chr $x+64) : ($s-=$fib[$k+1],next O)
      )
    : $n < 10 ? ($s-=$fib[$k+1],next O)
    : ( ($x = 0+substr $n,0,2,'') < 10 || $x > 26 ? ($s-=$fib[$k-1],next O) : ($t-=$fib[$k],$res .= chr $x + 64,$k--) );
    }
    $s--;
    unshift @res, $res;
  }
  @res
}
```

## Performance

Using the recursive routine as the benchmark. The `2^n` iterative solution is much less efficient - for the test set I'm using with 10 digit numbers it is about 10% efficient (as given by the ration of fibonacci number to 2^n) - the fibonacci approach gives us an efficieny of out 95%...

So I believe recursion wins out - I would say that if the number became very large - the fibonacci approach may eventually win out - because with all iterative (indexed) solutions you can stream the valid words and not have the recursion overhead.

***Note:** Just tested this theory on my small (1G RAM) test box:*

 * For 30 x "1" - recursion takes around 14 seconds vs 21 seconds for the fibonacci approach
 * For 33 x "1" - the finonacci approach takes 66 seconds [ on par with the approx 1.6x time increase per number ] vs around 320 seconds for the recursive approach.
