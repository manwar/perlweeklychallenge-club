[< Previous 215](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-215/james-smith) |
[Next 217 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-217/james-smith)

# The Weekly Challenge 6^3

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-216/james-smith

# TASK #1: Registration Number

***You are given a list of words and a random registration number. Write a script to find all the words in the given list that has every letter in the given registration number.***

## Solution

```perl
sub reg_number {
  my (%l,%x) = map { /[a-z]/ ? ($_=>1) : () }
               split //,
               lc
               shift;
  grep {
    %x=%l;
    delete $x{$_} for split//;
    !%x
  } @_
}
```

Firstly we get a list of the lower-cased letters in the number plate. Then for each word in turn we:
 * copy this hash into a temporary hash;
 * remove any letters from hash which rea in the word;
 * Check to see if the hash is now empty - if it is we include the word.

# TASK #2: Word Stickers

***You are given a list of word stickers and a target word. Write a script to find out how many word stickers is needed to make up the given target word.***

## Solution

Interestingly this task uses the trick - copy hash and delete elements - within it's core.

We note we:
 * are looking for fewest stickers so:
    * this suggests a depth first solution;
    * once we have found a solution it is by definition the best one;
    * queue solutions work well in these cases;
 * use a count based solution
    * we count every letter in the target word;
 * check that all of these are available on the sticker:
    * if not we return a "0" value
 * initialise the queue with an element:
    * where we have not used any stickers;
    * the last sticker we have "chosen" is the first one;
    * the counts are the inital counts we calculated above
 * for every element of the queue:
    * we loop through the stickers;
    * for each sticker we loop through the letters;
    * and if we need that letter we make a note we have removed a letter and reduce the count of that letter by one (if the count goes to zero we remove it);
    * if the counts array is empty we return the size
    * if we have removed a letter we push the new values back on to the queue;
    * **Note** when looping through the stickers we start with the last one we used and loop to the end. This avoids duplicates and greatly reduces the search space.
    * we loop till the queue is empty - actually we don't because we will exit the loop with the count array check above before we exhaust the queue.

Here is the code that the describes....

```perl
sub word_stickers {
  my( %f, %s, $n, $l, $x );
  $f{$_}++ for split //, shift;
  my @q = [ 1, 0, my %t = %f ];
  map { delete $t{$_} } split // for @_;
  return 0 if keys %t;
  while( ( $n, $l, %f ) = @{ shift @q } ) {
    push @q, map {
      $x = 0, %t = %f;
      exists $t{$_} && ( $x=1, --$t{$_} || delete $t{$_} )
        for split//, $_[$_];
      !%t ? return $n : $x ? [ $n+1, $_, %t ] : ()
    } $l..$#_;
  }
}
```

And to know what bit does what - here it is with comments:

```perl
sub word_stickers {
  my( %f, %s, $n, $l, $x );
  $f{$_}++ for split //, shift; # count for letters
  my %t = %f; # Check all letters on stickers
  # Initialise queue - no stickers, initial freq.
  my @q = [ 1, 0, my %t = %f ]; # Check can solve?
  map { delete $t{$_} } split // for @_;
  return 0 if keys %t; # if not return 0
  my @q = [ 1, 0, %f ]; # [ $no+1, $last, %freqs ]
  while( ($n,$l,%f) = @{ shift @q } ) {
    push @q, map {
      # Make copy of frequencies, set flag ($x)
      # true once we use a letter on sticker,
      # remove letters we have used up
      $x = 0, %t = %f;
      exists $t{$_} && ( $x=1, --$t{$_} || delete $t{$_} )
        for split//, $_[$_];
      # If none left return $n OR push entry onto
      # queue, increasing count and setting new last
      !%t ? return $n : $x ? [ $n+1, $_, %t ] : ()
      # Loop from last used to remove duplicates
    } $l..$#_;
  }
}
```
