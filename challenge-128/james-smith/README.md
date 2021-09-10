# Perl Weekly Challenge #128

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-128/james-smith/perl

# Task 1 -  Maximum Sub-Matrix

***You are given m x n binary matrix having 0 or 1 in each cell. Write a script to find out maximum sub-matrix having only 0***

## Ambiguity

There may be multiple solutions (e.g. in Example 1 depending on how you write the algorithm) so rather than returning the matrix - my tests will be on the area of the matrix

## The solution

Initialy this looks like an `O(n^4)` problem - you would need to scan the area to the right and below `O(n^2)` for a given cell `O(n^2)`. But with a bit of preprocessing - we can remove at least one of these loops - so the challenge becomes `O(n^3)`.

### Preprocessing the matrix.

To remove the inner loop - we can pre-compute this - the number of 0s in a continuouse line starting at the point and going right. For the first matrix we get

```
   [ 1 0 0 0 1 0 ]      [ 0 3 2 1 0 1 ]
   [ 1 1 0 0 0 1 ]   -> [ 0 0 3 2 1 0 ]
   [ 1 0 0 0 0 0 ]      [ 0 5 4 3 2 1 ]
```

The code that does that is this....

```perl
  ## Last column 1s become 0s, 0s become 1s
  my @runs = map { [1 - $_->[-1]] } @rows;

  ## Remaining columns we are working backwards along the rows
  ## Column is 0 if the matrix contains a 1 - o/w it is 1 more
  ## than the cell to the right (which is the first cell in the row)
  ## we use unshift to extend each row left...
  foreach my $i (reverse 0..$w-1) {
    unshift @{$runs[$_]}, $rows[$_][$i] ? 0 : $runs[$_][0]+1 foreach 0..$h;
  }
```

We then have the `O(n^3)` to find the maximum area.

For each cell we work out the maximum area of any rectangle.

For the first row it is just `$run[$y][$x]`. For subsequent rows it is the minimum of all `$run[$y][$x]` we have seen times height

```perl
      my $max_w = 1e9;
      foreach my $j ( $y .. $h ) {
        last unless $runs[$j][$x]; ## We have a 1 in the rectangle quit
        $max_w    = $runs[$j][$x]                  if $runs[$j][$x] < $max_w;
        my $area  = $max_w * ( $j - $y + 1 );
        $max_area = [ $area, $max_w, $j - $y + 1 ] if $area > $max_area->[0];
      }
```

The variable `$max_area` contains three values `$max_area`, `$max_w`, `$max_h` - the latter two if you wish to draw the empty matrix.....

Put it all together we have...
```perl
sub find_empty {
  my @runs      = map { [ 1 - $_->[-1] ] } my @rows = @{$_[0]};
  my ( $h, $w ) = ( @rows - 1, @{$rows[0]} - 1 );

  foreach my $i ( reverse 0 .. $w - 1 ) {
    unshift @{$runs[$_]}, $rows[$_][$i] ? 0 : $runs[$_][0] + 1 foreach 0 .. $h;
  }

  my $max_area = [ 0, 0 , 0 ];
  foreach my $x ( 0 .. $w ) {
    foreach my $y ( 0 .. $h ) {
      next unless $runs[$y][$x];
      my $max_w = 1e9;
      foreach my $j ( $y .. $h ) {
        last unless $runs[$j][$x];
        $max_w    = $runs[$j][$x]                  if $runs[$j][$x] < $max_w;
        my $area  = $max_w * ( $j - $y + 1 );
        $max_area = [ $area, $max_w, $j - $y + 1 ] if $area > $max_area->[0];
      }
    }
  }

  return $max_area;
}
```


# Task 2 - Minimum Platforms

***You are given two arrays of arrival and departure times of trains at a railway station. Write a script to find out the minimum number of platforms needed so that no train needs to wait.***

## Background

As mentioned this is effectively my day job again. To display information about genomic features and whether or not they overlapped a particular region (to know whether to display them or not) or to bump them for display (to make sure features didn't merge/overlap) which is exactly this problem. This one is in someways easier as we have the trains already sorted into date order. If we didn't sorting them would make life a lot easier! - not so easy on a genome browser where there may be 10s of thousands of features in a region.

This is actually more my brother's line of work - he works for what was BR computing - and one of his jobs is just this. For a while BR had 66 minutes in an hour to allow them to get trains in and out of one of the large busy stations.

## Solution

As we are assuming that starts are in time order we don't have to do a 2-sided test for overlaps.

So foreach train we loop through all platforms - seeing if there is a platform with a slot in it (i.e. the last train has already left the platform). If there isn't we make a new platform and add the train to it, and repeat. All we do is store the last departure time for each platform, and because 24-hr date strings alphabetic/time order are the same - we only need to use the string comparison operator (in this case `gt`) to compare times.

Here we use a little used concept in perl the label "`OUTER`" - this allows our inner loop to break out of it's own `foreach` loop and also jump to the next interation of it's parent loop.

```perl
sub bump_platform {
  my @arr = @{shift @_};
  my @dep = @{shift @_};
  my @platforms = ();
  OUTER: foreach my $st (@arr) {
    foreach(0..$#platforms) {
      ($platforms[$_] = shift @dep) && (next OUTER)
        if $st gt $platforms[$_];
    }
    push @platforms,shift @dep;
  }
  return scalar @platforms;
}
```

**Notes:**

We can also keep information about which trains are on by re-writing what is stored in `@plat` rather than storing the last departure time - we can store the arrival/departure time of trains on each platform...
 
```perl
sub bump_platform_keep_trains {
  my @arr = @{shift @_};
  my @dep = @{shift @_};
  my($train_no, @platforms) = (0);

  OUTER: foreach my $st (@arr) {
    foreach(@platforms) {
      (push @{$_}, [ $st, (shift @dep), ++$train_no ]) &&
        (next OUTER) if $st gt $_->[-1][1];
    }
    push @platforms, [ [ $st, (shift @dep), ++$train_no ] ];
  }
  say '  ', join '  ', map { "Train $_->[2]: $_->[0]-$_->[1]" } @{$_}
    foreach @platforms;
  return scalar @platforms;
}
```
