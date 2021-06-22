# Perl Weekly Challenge #118

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-118/james-smith/perl

# Task 1 - Binary Palindrome
***You are given a positive integer `$N`. Write a script to find out if the binary representation of the given integer is Palindrome. Print `1` if it is otherwise `0`.***
## The solution

This is a simple code - we convert the number to a binary represenation
using `sprintf` (actually faster than `unpack`), reverse and `compare`.

```perl
sub is_binary_palindrome_string {
  my $t = sprintf '%b', shift;
  return ($t eq reverse $t) || 0;
}
```

I looked at alternative array based solutions - but these are all
appreciably slower than using perl "core" string functions - which
what you would expect. Core functionality will be written in highly
optimzed "C" and so usually can't be beaten. We have seen this before
when comparing the speed of `grep` to list utils `first` on small
to medium lists when the comparison function is simple.

# Task 2 - Adventure of Knight

***There are 6 squares with treasures. Write a script to find the
path such that Knight can capture all treasures. The Knight can
start from the top-left square.***

## The technique

This week unfortunately we are not going to avoid a recursive solution.
The problem leads us in this direction, as at each step we have to test
up to 8 "next steps" - the directions of the knight moves.

BUT - to simplify our code solution - we want to avoid a solution which
requires loops within our recursive function - other than the one which
looks at the "next" step.

We note that the chessboard has 64 squares and that Perl has 64-bit
integers. We note therefore that we can represent the location of an
array of items on the board as a single number.

We number the squares starting bottom left with `0` & ending top right
with `63`.

```
       a  b  c  d  e  f  g  h

 8    56 57 58 59 60 61 62 63
 7    48 49 50 51 52 53 54 55
 6    40 41 42 43 44 45 46 47
 5    32 33 34 35 36 37 38 39
 4    24 25 26 27 28 29 30 31
 3    16 17 18 19 20 21 22 23
 2     8  9 10 11 12 13 14 15
 1     0  1  2  3  4  5  6  7
```

Each board has a single integer representing it by adding up `2^n`
for every square which contains an object.

We can then represent the location of the "treasures" as a 64-bit
number where we set the appropriate bit for each square a treasure
is in. So we can represent the solution as:

```
   b1 (2^ 1)                    1
   a2 (2^ 8)                  256
   b2 (2^ 9)                  512
   b3 (2^17)              131 072
   c4 (2^26)           67 108 864
   e6 (2^44)   17 592 186 044 416
   ---------- -------------------
   TOTAL       17 592 253 285 121
   ---------- -------------------
```

We can similarly represent the squares the knight has visited as
a single number.

Two checks we need are:

 * When a knight moves have they already visited the new square. If
   they have then we do a bitwise compare (`&`) of `2^n` of the new
   square with the representation of the squares they have visited.
   If this is non-zero - we have already visited the square.

 * To check to see if we have visited ALL the treasures we can `&`
   the square we have visited with the location of the squares of
   the treasure and if all the bits of the treasure squares have
   been visited we know we have a solution. `tour & solution == solution`.

**No loops required!**

To find an optimal solution - we just need to find the shortest path -
so one final check we can do is to "fail" the search if any new path is
equal to or longer than the current shortest path.

Finally this representation stores where a knight has been but NOT the
order of the squares he has visited. We have to additionally store this
information. At each stage we needed to compute the number of the
square we are in (0..63). We can just store this in an array. But to
avoid the array overhead instead we can just store it in a byte string,
using `chr $loc`.

## The solution

### The "main code"

Set up list of possible knight moves.
```perl
my @dir = ([-2,1],[2,1],[-2,-1],[2,-1],[-1,2],[1,2],[-1,-2],[1,-2]);
```

Get a list of treasure locations (in the form of letter.number).
```perl
my @treasures = qw(a2 b1 b2 b3 c4 e6);
```

Initialize variables (best route, best route length), and compute the
numeric represenation of the solution. You see we use "`|`" rather
than "`&`" to add up the digits.

We subtract `105 = 8 + 97` - as we have to substract `ord 'a'` from the
horizontally co-ordinate and `1 (*8)` from the vertical co-ordinate
to map to a `0` based location number.

```perl
my( $sol, $best_len, $best_rt ) = ( 0, 65 );
$sol |= 1 <<  8 * (substr $_,1) - 105 + ord $_ foreach @treasures;
```

Walk the grid to find the best solution. Starting in the top left
corner which is `(0,7)`.
```perl
walk( 0, 7, 0, q() );
```

Write out best solution
```perl
say '';
say "Treasures: @treasures";
say '#Steps:    ',-1 + length $best_rt;
say 'Route:     ',show_rt( $best_rt );
say '';
```

### The walk function

This is the heart of the algorithm.

To make the code shorter we don't check the square we are moving to
before we call the function, but instead we check at the start of the
call.

We have the following variables:

  * `$seen` is the binary representation of the board showing where
    the knight has been.
  * `$rt` the byte string of the route of of the knight.
  * `$x`/`$y` the co-ordinates of the current square.
  * `$t`/`$v` the location of the square as a number between `0` and `63` and
    it's location as a bit in the 64-bit represenation. `2^$t`.

We check:

  * Is the new square on the board (x/y co-ordinates between 0 and 7).
  * We check we haven't seen the square before `$seen & $v`

We then update both `$seen` and `$rt`

Then we check the solution - `$seen & $sol == $sol` - if it is we
update the "best solution" and try the next path.

Before the recursive step we check whether our solution will be optimal
by comparing it's length to the best length we have already seen.

```perl
sub walk {
  my( $x, $y, $seen, $rt ) = @_;
  return if $x < 0 || $y < 0 || $x > 7 || $y > 7
         || $seen & ( my $v = 1 << ( my $t = 8*$y + $x ) );
  $seen |= $v;
  $rt   .= chr $t;
  return ($best_rt,$best_len) = ($rt,-1+length $rt)
    if ($seen & $sol) == $sol;
  return if $best_len <= length $rt;
  walk( $x + $_->[0], $y + $_->[1], $seen, $rt ) foreach @dir;
}
```

### The dump function

This returns the path - in the original letter.number format with
stars to indicate when we find treasures. We do this by Using
nested `map`s.

 * We first convert the byte string representation into an array of
   square numbers.
 * We then convert this to a list of location strings.
 * We finally check to see if each square is a treasure and prepend
   with either a `*` or a space.

```perl
sub show_rt {
  my %t = map { $_ => 1 } @treasures;
  return join q( ),
         map        { $_.( exists $t{$_} ? q(*) : q( ) ) }
         map        { chr( 97 + ($_&7) ).( 1 + ($_>>3) ) }
         map        { ord $_                             }
         split m{}, shift;
}
```

## Aside - let's eek out the speed.

There is one place where the code could gain a bit of speed. The
range checks are performed AFTER the function call not before. We
can move them but a generic check code gets messy and isn't as
fast. If we unravel the one loop we have left we can simplify
things slighlty - as we can make the range checks simpler.

Note we have kept the order of the offsets the same as in the `walk`
function above - this will have an affect on the speed (the search
is faster if you find shorter matches early on).

As you can see we have avoided array look ups and extra function calls,
so although the code is longer it is more efficient.

Testing gives around a one-third speed up from around 24 seconds
to 18 seconds per run on my usual VM.

```perl
sub walk_opt {
  my( $x, $y, $seen, $rt ) = @_;
  return if $seen & ( my $v = 1 << (my$t=$x+$y*8) );
  $seen |= $v;
  $rt   .= chr $t;
  return ($best_rt,$best_len) = ($rt,-1+length $rt) if ($seen & $sol) == $sol;
  return if $best_len <= length $rt;
  walk_opt( $x-2, $y+1, $seen, $rt ) if $x>1 && $y<7;
  walk_opt( $x+2, $y+1, $seen, $rt ) if $x<6 && $y<7;
  walk_opt( $x-2, $y-1, $seen, $rt ) if $y   && $x>1;
  walk_opt( $x+2, $y-1, $seen, $rt ) if $y   && $x<6;
  walk_opt( $x-1, $y+2, $seen, $rt ) if $x   && $y<6;
  walk_opt( $x+1, $y+2, $seen, $rt ) if $x<7 && $y<6;
  walk_opt( $x-1, $y-2, $seen, $rt ) if $x   && $y>1;
  walk_opt( $x+1, $y-2, $seen, $rt ) if $x<7 && $y>1;
}
```
