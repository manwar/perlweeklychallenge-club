# Perl Weekly Challenge #124

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-124/james-smith/perl

# Task 1 - Happy Women's Day

***Write a script to print the Venus Symbol, international gender symbol for women. Please feel free to use any character.***

## The solution

We will first look at the symbol defined in the question...

```
    ^^^^^
   ^     ^
  ^       ^
 ^         ^
 ^         ^
 ^         ^
 ^         ^
 ^         ^
  ^       ^
   ^     ^
    ^^^^^
      ^
      ^
      ^
    ^^^^^
      ^
      ^
```

We note there are 3 types of rows:

 * Type I: a line of 5 symbols (centered)
 * Type II: a single symbol in the middle of the row
 * Type III: two symbols either side of the middle at a given distance.

We encode these in an array -1 -> line of 5 symbols; 0 -> a single symbol at the centre; values > 0 - two points at the given distance away from the centre. The code becomes this:

```perl
my @pts = qw(-1 3 4 5 5 5 5 5 4 3 -1 0 0 0 -1 0 0);
say $_ < 0 ? '    ^^^^^'
  : !$_    ? '      ^'
  : ' ' x (6-$_) . '^' . ' 'x($_*2-1) .'^'
  foreach @pts;
```

### Now for a more generic solution!

This symbol is just a circle and cross below. We can use trig to work out the points of the circle. To ensure we don't leave gaps we sweep the arcs away from the cardinal points (N,S,E,W) up to the ordinal points (NE,NW,SE,SW) - 8 different 45deg arcs. This way we just need to compute one point for each line and then compute the other co-ordinate using pythagorus' theorem.

Why do we do this? If we just did 4 arcs of 90 degrees we would find that once we passed 45 degrees we would miss out points...

Our process has 4 steps.

 1. Create a blank canvas
 2. Draw the circle (note when we compute the y value we take half off the radius - this gives a better circle as we are tracing a line through the centre of the "squares"...
 3. Draw the cross
 4. Display the canvas...

```perl
## Create the canvas..
my @a = map { ' ' x ($radius*2+1) } 0..$radius*2+$cross;

## Now we draw the circle...
foreach my $x (0 .. ceil($radius*0.71)) {
  my $y = int sqrt( ($radius-.5)**2 - $x**2 );
  substr $a[ $radius - $x ],$radius-$y,1,'^';
  substr $a[ $radius + $x ],$radius-$y,1,'^';
  substr $a[ $radius - $x ],$radius+$y,1,'^';
  substr $a[ $radius + $x ],$radius+$y,1,'^';
  substr $a[ $radius - $y ],$radius-$x,1,'^';
  substr $a[ $radius + $y ],$radius-$x,1,'^';
  substr $a[ $radius - $y ],$radius+$x,1,'^';
  substr $a[ $radius + $y ],$radius+$x,1,'^';
}

## And the two parts of the cross...
substr $a[2*$radius+$_],$radius,1,'^' foreach 0..$cross;
substr $a[2*$radius+$cross/2],$radius-$cross/2,$cross+1,'^'x($cross+1);

### Finally we render the canvas...
say $_ foreach @a;
```

Example output...
```
                ^^^^^^^^^
             ^^^         ^^^
           ^^               ^^
         ^^                   ^^
        ^                       ^
       ^                         ^
      ^                           ^
     ^                             ^
    ^                               ^
    ^                               ^
   ^                                 ^
   ^                                 ^
  ^                                   ^
  ^                                   ^
  ^                                   ^
 ^                                     ^
 ^                                     ^
 ^                                     ^
 ^                                     ^
 ^                                     ^
 ^                                     ^
 ^                                     ^
 ^                                     ^
 ^                                     ^
  ^                                   ^
  ^                                   ^
  ^                                   ^
   ^                                 ^
   ^                                 ^
    ^                               ^
    ^                               ^
     ^                             ^
      ^                           ^
       ^                         ^
        ^                       ^
         ^^                   ^^
           ^^               ^^
             ^^^         ^^^
                ^^^^^^^^^
                    ^
                    ^
                    ^
                    ^
                    ^
                    ^
              ^^^^^^^^^^^^^
                    ^
                    ^
                    ^
                    ^
                    ^
                    ^
```

# Task 2 - Tug of War

***You are given a set of `$n` integers `(n1, n2, n3, ...)`. Write a script to divide the set in two subsets of `n/2` sizes each so that the difference of the sum of two subsets is the least. If `$n` is even then each subset must be of size `$n/2` each. In case `$n` is odd then one subset must be `($n-1)/2` and other must be `($n+1)/2`.***

## Solution

We will use an iterative solution. We start by allocating person 1 to team 1, we then iterate down allocating each person to either team 1 or team 2. If either team gets too big we bomb out (this makes this solution more efficient than the non-iterative solution). As we go we keep a tally of the difference between the two teams weights.

As we do a pre-allocation stage - we need to split the routine into two functions, the first function preps the data for interation and then handles the data at the end. The second does the interative step.

At each step we need to know:
 1) What is the max-size of the group;
 2) Who is in team 1;
 3) Who is in team 2;
 4) What the difference in weight is;
 5) What is the smallest difference we have found;
 6) The weights of people left to be allocated.

So to start - we allocate person 1 to group 1, and set the difference to his weight. `$best` is an object to collect the information about the best allocation (the members of the two teams and the smallest difference)...

```perl
sub match_teams {
  my( $diff, @n ) = @_;
  separate( 1 + int(@n/2), [$diff], [], $diff, my $best = [], @n );
  return "Team 1: [@{$best->[0]}]; Team 2: [@{$best->[1]}]; difference $best->[2]";
}

sub separate {
  my($maxsize,$team1,$team2,$diff,$be,@nums) = @_;
  unless(@nums) {
    if( !defined $be->[0] || $be->[2]>abs $diff ) {
      $be->[0] = $team1;
      $be->[1] = $team2;
      $be->[2] = abs $diff;
    }
    return;
  }
  my $next = shift @nums;
  separate( $maxsize, [@{$team1},$next], $team2, $diff+$next, $be, @nums ) if @{$team1} < $maxsize;
  separate( $maxsize, $team1, [@{$team2},$next], $diff-$next, $be, @nums ) if @{$team2} < $maxsize;
}
```
### Notes:
 * Notice the yoda inequality `$be->[2]>abs $diff` - it makes it clearer that you are only computing the absolute value of `$diff` not that of `$diff < $be->[2]`.
 * `$team1` / `$team2` are refs - so when we update them we make copies `[@{$team2},$next]` rather than pushing to them.
 * We keep the running total as it avoids the need to do the sum each time.

### Timings

| players | rate/time |
| ------- | --------: |
| 10      |   2,273/s |
| 12      |     598/s |
| 14      |     157/s |
| 16      |      41/s |
| 18      |      10/s |
| 20      |    2.68/s |
| 22      |    0.57/s |
| 24      |   ~    6s |
| 26      |   ~   23s |
| 28      |   ~   94s |
| 30      |   ~  365s |

```
