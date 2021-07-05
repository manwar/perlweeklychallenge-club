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

This is a simple code - we convert the number to a binary represenation using `sprintf` (actually faster than `unpack` and doesn't need 0s trimmed), reverse and `compare`.

```perl
sub is_binary_palindrome_string {
  return ( ( $a = sprintf '%b', $_[0] ) eq reverse $a ) || 0;
}
```

I looked at alternative array based solutions - but these are all appreciably slower than using perl "core" string functions - which
what you would expect. Core functionality will be written in highly optimzed "C" and so usually can't be beaten. We have seen this before
when comparing the speed of `grep` to list utils `first` on small to medium lists when the comparison function is simple.

# Task 2 - Adventure of Knight

***There are 6 squares with treasures. Write a script to find the path such that Knight can capture all treasures. The Knight can
start from the top-left square.***

## The technique

*To start with I didn't want to google an "ideal" solution for this problem - but start from first
principles and see if we can get a "brute force" solution to come back in a reasonable time!*

This week unfortunately we are not going to avoid a recursive solution. The problem leads us in this
direction, as at each step we have to test up to 8 "next steps" - the directions of the knight moves.

The brute force algorithm is:

 * check to see if we've visited the square before; stop
 * update route;
 * check to see if we've found the solution;
 * try all moves from the current location;

If we are looking for the shortest route - we can also add a clause which says stop if the route we've got is
equal to or longer in length than the current best route.

### Avoiding loops

To simplify our code solution, and increase performance we want to remove the need for any extraneous
loops, and also the use of arrays as there are many overheads to using arrays.

We want to avoid a solution which requires loops within our recursive
function - other than the one which looks at the "next" step.

We note that the chessboard has 64 squares and that Perl has 64-bit
integers. We note therefore that we can represent the location of an
array of items on the board as a single number.

We number the squares starting bottom left with `0` & ending top right
with `63`.

```
      a  b  c  d  e  f  g  h

 8   56 57 58 59 60 61 62 63   8
 7   48 49 50 51 52 53 54 55   7
 6   40 41 42 43 44 45 46 47   6
 5   32 33 34 35 36 37 38 39   5
 4   24 25 26 27 28 29 30 31   4
 3   16 17 18 19 20 21 22 23   3
 2    8  9 10 11 12 13 14 15   2
 1    0  1  2  3  4  5  6  7   1

      a  b  c  d  e  f  g  h
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

## Our first solution

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
than "`+`" to add up the digits.

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

### The output...

```
a8  c7  e6* c5  b3* c1  a2* c3  b1* d2  c4* b2*
```

```
        a   b   c   d   e   f   g   h
    8  0*   *   *   *   *   *   *   *  8
    7   *   *  1*   *   *   *   *   *  7
    6   *   *   *   *  2x   *   *   *  6
    5   *   *  3*   *   *   *   *   *  5
    4   *   * 10x   *   *   *   *   *  4
    3   *  4x  7*   *   *   *   *   *  3
    2  6x 11x   *  9*   *   *   *   *  2
    1   *  8x  5*   *   *   *   *   *  1
        a   b   c   d   e   f   g   h

```

## Improvement 1 - reduce function calls

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

## Improvement 2 - remove some `if`s

So we've remove unecessary loops in our first attempt, in our second we have reduced the number of function calls. So we need to see where we can gain more time...

The only thing left is to reduce the `if` statements in the "heart" of the loop.

Rather than checking to see if a move from one square in a given direction ("transition") is valid each time - we pre-compute the list of moves, and store it in a "transition" matrix. This reduces overall execution time.

So we use the logic above to generate an array where the "key" is the square number and the "value" is an array of square numbers that you can reach.

This gives us the following code:

```perl
sub get_trans {
  my $q=[];
  foreach my $y (0..7) {
    foreach my $x (0..7) {
      my $l = $x + $y * 8;
      push @{ $q->[$l] }, $l + 6  if $y<7 && $x > 1;
      push @{ $q->[$l] }, $l + 10 if $y<7 && $x < 6;
      push @{ $q->[$l] }, $l - 6  if $y>0 && $x < 6;
      push @{ $q->[$l] }, $l - 10 if $y>0 && $x > 1;
      push @{ $q->[$l] }, $l + 15 if $y<6 && $x > 0;
      push @{ $q->[$l] }, $l + 17 if $y<6 && $x < 7;
      push @{ $q->[$l] }, $l - 15 if $y>1 && $x < 7;
      push @{ $q->[$l] }, $l - 17 if $y>1 && $x > 0;
    }
  }
  return $q;
}
```

The numbers 6, 10, 15 and 17 come from looking at the grid above....

```
  ... +15 ... +17 ...
   +6 ... ... ... +10
  ... ... *** ... ...
  -10 ... ... ...  -6
  ... -17 ... -15 ...
```

The array starts like:
```
[
  [10,17]
  [11,16,18]
  [8,12,17,19]
  [9,13,18,20]
  [10,14,19,21]
  [11,15,20,22]
  [12,21,23]
  [13,22]
  ....
]
```

We then have an optimized version of the walk code, and subroutine then becomes the *simpler*:

```perl
sub walk_trans {
  my( $t, $seen, $rt ) = @_;          ## Current square, visited squares, current route.

  return if $seen & 1 << $t;          ## Return if we've already been to this square.

  $seen |= 1 << $t;                   ## Mark that we have been in this square.

  $rt   .= chr $t;                    ## Add this square to our route.

  return ($best_rt,$best_len)         ## If we've found all the treasure update the best 
       = ($rt,-1+length $rt)          ## route (and it's length) and return
      if ($seen & $sol) == $sol;

  return if $best_len <= length $rt;  ## If longer than the best route return

  walk_trans( $_, $seen, $rt )        ## Try all knight move squares from the current
      foreach @{$trans->[$t]};        ## square.
}
```

The eight lines of `if`s go back to a single foreach loop, but this time we do not need the `if`s.

As well as removing the ifs we have a "side-effect" where we no longer need to label squares by their `x`&`y` co-ordinates but just by their index `0`..`63` which also gains us some additional speed {we no longer have to compute `$t` from `$x` & `$y`, and we need to pass one less parameter}

The time is now down to approximately 10 seconds.

## Notes

### The full transition matrix
```perl
[
  [10, 17],
  [11, 16, 18],
  [8, 12, 17, 19],
  [9, 13, 18, 20],
  [10, 14, 19, 21],
  [11, 15, 20, 22],
  [12, 21, 23],
  [13, 22],

  [2, 18, 25],
  [3, 19, 24, 26],
  [0, 4, 16, 20, 25, 27],
  [1, 5, 17, 21, 26, 28],
  [2, 6, 18, 22, 27, 29],
  [3, 7, 19, 23, 28, 30],
  [4, 20, 29, 31],
  [5, 21, 30],
  
  [1, 10, 26, 33],
  [0, 2, 11, 27, 32, 34],
  [1, 3, 8, 12, 24, 28, 33, 35],
  [2, 4, 9, 13, 25, 29, 34, 36],
  [3, 5, 10, 14, 26, 30, 35, 37],
  [4, 6, 11, 15, 27, 31, 36, 38],
  [5, 7, 12, 28, 37, 39],
  [6, 13, 29, 38],
  
  [9, 18, 34, 41],
  [8, 10, 19, 35, 40, 42],
  [9, 11, 16, 20, 32, 36, 41, 43],
  [10, 12, 17, 21, 33, 37, 42, 44],
  [11, 13, 18, 22, 34, 38, 43, 45],
  [12, 14, 19, 23, 35, 39, 44, 46],
  [13, 15, 20, 36, 45, 47],
  [14, 21, 37, 46],
  
  [17, 26, 42, 49],
  [16, 18, 27, 43, 48, 50],
  [17, 19, 24, 28, 40, 44, 49, 51],
  [18, 20, 25, 29, 41, 45, 50, 52],
  [19, 21, 26, 30, 42, 46, 51, 53],
  [20, 22, 27, 31, 43, 47, 52, 54],
  [21, 23, 28, 44, 53, 55],
  [22, 29, 45, 54],
  
  [25, 34, 50, 57],
  [24, 26, 35, 51, 56, 58],
  [25, 27, 32, 36, 48, 52, 57, 59],
  [26, 28, 33, 37, 49, 53, 58, 60],
  [27, 29, 34, 38, 50, 54, 59, 61],
  [28, 30, 35, 39, 51, 55, 60, 62],
  [29, 31, 36, 52, 61, 63],
  [30, 37, 53, 62],
  
  [33, 42, 58],
  [32, 34, 43, 59],
  [33, 35, 40, 44, 56, 60],
  [34, 36, 41, 45, 57, 61],
  [35, 37, 42, 46, 58, 62],
  [36, 38, 43, 47, 59, 63],
  [37, 39, 44, 60],
  [38, 45, 61],
  
  [41, 50],
  [40, 42, 51],
  [41, 43, 48, 52],
  [42, 44, 49, 53],
  [43, 45, 50, 54],
  [44, 46, 51, 55],
  [45, 47, 52],
  [46, 53],
]
```

## Task 2 - version 2 - using pre-computed distances.

Reading CY's description using pre-computed distances I wanted to
investigate how that worked.

### Technique

For any 2 squares we can compute the shortest distance in "steps"
between them.

Then we try all permutations of the order of the treasures (squares)
to compute the optimal route. In theory we can pre-cache this
information so that we don't have to calculate it every time we
execute the script (as we could have with the transition matrix above).

So we now have the following steps:

 * Compute the transition matrix
 * Compute the distance matrix - and store an example shortest route
   between each pair of squares.
 * Permute the points to compute a shortest route.

### Stage 1

See above for computing the transition matrix

### Stage 2

Computing the distance matrix.

For each square (using our `0`..`63` notation) we generate
an array of distances and routes. To do this we start by
setting `$dist[$start][$start]` to `0` and
`$route[$start][$start]` to `''`.
We then repeatedly scan the board looking for increasing values
of distance `0`, `1`, `2` etc, and finding squares we could jump
to (that we already haven't) and set distance and routes for them.
In this case I think the code is easier to understand than the
description.

By using our pre-computed transition matrix we not only remote
the need for two levels of nested loops BUT also the need to 
perform the checks each time for stepping off the side of the board.

```perl
my $dist_maps  = []; ## Map of distances betw
my $route_maps = [];

foreach my $start (0..63) {
  my @dists  = map { $_ == $start ? 0 : -1 } 0..63;
  my @routes = map { '' } 0..63;
  my $c = 1;
  my $d = 0;
  while($c<64) {
    foreach my $x (0..63) {
      next if $dists[$x] != $d;
      foreach ( @{$trans->[$x]}) {
        next if $T[$_]>=0;
        $c++;
        $dists[$_]  = $d+1;
        $routes[$_] = $routes[$x].chr$_;
      }
    }
    $d++;
  }
  push @{$dist_maps},  \@dists;
  push @{$route_maps}, \@routes;
}
```

### Stage 3

Our optimal route routine is just a simple recursive function.
Although here we will build in *memoisation* from the start.

The key we use is a combination of the current square location
AND the remaining treasure squares (sorted) - `"$start @{[ sort @r ]}"`.
The function returns the two values distance and route.

```perl
sub optimal_route {
  $calls++;
  my($start,@r) = @_;
  return $CACHE{$start} ||= [0,''] unless @r;
  my $key = "$start @{[ sort @r ]}";
  return $CACHE{$key} if exists $CACHE{$key};
  my $len = 64;
  my $rt  = '';
  foreach(0..$#r) {
    my $t = shift @r;
    my $x = optimal_route($t,@r);
    my $l = $dist_maps->[$start][$t] + $x->[0];
    if( $l < $len ) {
      $len = $l;
      $rt  = $route_maps->[$start][$t] . $x->[1];
    }
    push @r,$t;
  }
  return $CACHE{$key} = [$len,$rt];
}
```

### Performance

Using CY's 12 treasure example:

```
h3 d7 g7 h4 b4 c2 g2 b6 d4 d1 c5 e4
```

gives the following output:

```
Minimal length: 17
Minimal route:  a8  b6* d7* c5* e4* f2  h3* f2  d1* e3  g2* h4* f5  g7* f5  d4* c2* b4*

Permutations:   479,001,600
Function calls:     135,181
Cache entries:       24,577

Timings:
Pre^2-compute:  0.000117
Pre-compute:    0.005684
Find path:      0.452598
Overall time:   0.458399
```

Running it without the call cache gives us:

```
Minimal length: 17
Minimal route:  a8  b6* d7* c5* e4* f2  h3* f2  d1* e3  g2* h4* f5  g7* f5  d4* c2* b4*

Permutations:     479,001,600
Function calls: 1,302,061,345

Timings:
Pre^2-compute:      0.000119
Pre-compute:        0.005677
Find path:      2,407.745782
Overall time:   2,407.751578
```

This shows how efficient the caching is - reducing the function calls
by a factor of 10,000 - and the number of times the function was
evaluated by a factor of around 40,000.

With an overall speed up of 5,000 times.