# Perl Weekly Challenge #111

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

# Challenge 1 - Search Matrix

**You are given 5x5 matrix filled with integers such that each row is sorted from left to
right and the first integer of each row is greater than the last integer of the previous
row.**

**Write a script to find a given integer in the matrix using an efficient search algorithm.**

## Solution to challenge 1

Today's is an interesting challenge ... to check to see if a value is in the matrix....

Initially this looks like we need to define some efficient sorting algorithm that flattens
the array and then searches it {e.g. binary search}.

We implement this... but we compare it against some alternative simple methods. We don't
get the result we expect...

## Binary search

We first flatten the array. Then we loop until the array is empty or it has a solitary value

  If we get a match with the "middle" value we return 1;
  Otherwise we remove the half of the list using `splice` which
  the number isn't in.
  
We return 0 if the array has length 0. If the length is 1 we return
1 or 0 depending on whether the array is search value or not.

```perl
sub find_val_search {
  my( $val, $m, @list ) = ( $_[0], 0, map { @{$_} } @{$_[1]} );

    $list[ $m = @list >> 1 ] == $val ? ( return 1              )
  : $list[ $m              ] >  $val ? ( splice @list, $m      )
  :                                    ( splice @list, 0, $m+1 )
    while @list>1;
  return @list && $list[0] == $val ? 1 : 0;
}
```

## The other (better) methods:

### grep on the flattened array

```perl
sub find_val_grep_map {
  my($v,$m)=@_;
  return 0 + grep { $_ == $v } map { @{$_} } @{$m};
}
```

### reducing array with grep and then combining with map

Uses `grep` on each sub array to return either an
empty array or an array containing the match.
We then use `map` to combine the arrays.

The resultant array will have length `0` or `1`.

```perl
sub find_val_map_grep {
  my($v,$m)=@_;
  return 0 + map { grep { $_ == $v } @{$_} } @{$m};
}
```
## Efficiency

We use `cmpthese` to compare the performance...

Our methods are:
  * `find_val_search`
  * `find_val_grep_map`
  * `find_val_map_grep`

Timings using `Benchmark::cmpthese`

|           |   Rate   | Search | Grep-Map | Map-Grep | *Flatten* |
| --------- | -------: | -----: | -------: | -------: | --------: |
| Search    |  4,859/s |     -- |     -10% |     -33% |    *-42%* |
| Grep-Map  |  5,394/s |    11% |       -- |     -25% |    *-36%* |
| Map-Grep  |  7,210/s |    48% |      34% |       -- |    *-14%* |
| *Flatten* |  8,418/s |  *73%* |    *56%* |    *17%* |       --* |

Notes:

  * *Flatten* is for comparison only - it actually does nothing other than flatten
    the array - this highlights how efficient each algorithm is (and can be)
  
  * So we see that the map_grep solution is 50% more efficient than the search
    algorithm (this is true for all search method algorithms which flatten
    the array first);

## Not flattening array

As we have a limit on performance with the flattening operation. To
improve efficiency we will need to consider a different approach: **Which
therefore must not flatten!**

### Do not flatten - find the row containing the number

 * Rather than using `map`/`grep` on the outer array, we instead use
   a "hard coded" binary search.

 * First we return 0 if the number is outside the range of numbers in
   the list.

 * Then we look to see if the number is below the first value of the
   4th row. This means it is in rows 1, 2 or 3. So we test for that.
   Otherwise it is in rows 4 or 5, so we can test that as well.
 
 * This function expression returns which row the number *could be in*

```perl
   $v < $m->[3][0]
 ? ( $v < $m->[1][0] ? 0 : $v < $m->[2][0] ? 1 : 2 )
 : ( $v < $m->[4][0] ? 3 : 4                       )
```

This leads the whole function to be:

```perl
sub find_val_dnf {
  my($v,$m) = @_;
  return $v < $m->[0][0] || $v > $m->[4][4]
       ? 0
       : 0 + grep { $v == $_ } @{$m->[ $v < $m->[3][0]
           ? ( $v < $m->[1][0] ? 0 : $v < $m->[2][0] ? 1 : 2 )
           : ( $v < $m->[4][0] ? 3 : 4                       )
         ]};
}
```

### Do not flatten - optimal solution

 * As well as not using `map` or `grep` on the outside array we
   do so on the inner array.

 * Once we have chosen the correct row then we split it into
   two halves and check for a match in each half depending on
   whether it matches the middle value or is above/below.

```perl
sub find_val_dnf_optimal {
  my($v,$m,$t) = @_;

  return $v < $m->[0][0] || $v > $m->[4][4]
       ? 0
       : ( $t = $m->[ $v < $m->[3][0]
           ? ( $v < $m->[1][0] ? 0 : $v < $m->[2][0] ? 1 : 2 )
           : ( $v < $m->[4][0] ? 3 : 4                       )
         ] ) &&
         ( return $v == $t->[2] ? 1 :
                  $v < $t->[2] ?
                  ( $v == $t->[0] || $v == $t->[1] ? 1 : 0) :
                  ( $v == $t->[4] || $v == $t->[3] ? 1 : 0) );
}
```

Timings using `Benchmark::cmpthese`

|           |   Rate   | Search | Grep-Map | Map-Grep | *Flatten* | DNF    | DNF Opt |
| --------- | -------: | -----: | -------: | -------: | --------: | -----: | ------: |
| Search    |  4,859/s |     -- |     -10% |     -33% |    *-42%* |   -76% |    -79% |
| Grep-Map  |  5,394/s |    11% |       -- |     -25% |    *-36%* |   -73% |    -77% |
| Map-Grep  |  7,210/s |    48% |      34% |       -- |    *-14%* |   -64% |    -69% |
| *Flatten* |  8,418/s |  *73%* |    *56%* |    *17%* |      *--* | *-59%* |  *-63%* |
| DNF       | 20,284/s |   317% |     276% |     181% |    *141%* |    --  |    -12% |
| DNF_opt   | 22,989/s |   373% |     326% |     219% |    *173%* |    13% |      -- |

We can see that this "optimal method" is somewhere betwen 4.5 and 5 times more efficient
than the "search" function.

## Test script

For completeness - this is the test and benchmarking script

```perl
#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese);

my $matrix = [
  [  1,  2,  3,  5,  7 ],
  [  9, 11, 15, 19, 20 ],
  [ 23, 24, 25, 29, 31 ],
  [ 32, 33, 39, 40, 42 ],
  [ 45, 47, 48, 49, 50 ],
];

## Create a test set - numbers from -10 to 60...
my %TEST_SET = map { $_ => 0 } (my @KEYS = -10..60);
 
## Set all to 0, and then iterate through the elements of the matrix
## and set the numbers in the list to 1....

$TEST_SET{$_} = 1 foreach map { @{$_} } @{$matrix};

## Run the original PWC test examples...
is( find_val_search(      35, $matrix ), 0 );
is( find_val_search(      39, $matrix ), 1 );
is( find_val_map_grep(    35, $matrix ), 0 );
is( find_val_map_grep(    39, $matrix ), 1 );
is( find_val_grep_map(    35, $matrix ), 0 );
is( find_val_grep_map(    39, $matrix ), 1 );
is( find_val_dnf(         35, $matrix ), 0 );
is( find_val_dnf(         39, $matrix ), 1 );
is( find_val_dnf_optimal( 35, $matrix ), 0 );
is( find_val_dnf_optimal( 39, $matrix ), 1 );

## Now run our full test set - from -10 to 60. This covers
## all cases within the list and a few either side...

is( find_val_dnf_optimal( $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_dnf(         $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_search(      $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_map_grep(    $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_grep_map(    $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;

done_testing();

cmpthese(100_000, {
  q(DNF_opt)  => sub { find_val_dnf_optimal( $_, $matrix ) foreach @KEYS; },
  q(DNF)      => sub { find_val_dnf(         $_, $matrix ) foreach @KEYS; },
  'Flatten'   => sub { flatten(              $_, $matrix ) foreach @KEYS; },
  'Search'    => sub { find_val_search(      $_, $matrix ) foreach @KEYS; },
  'Grep-Map'  => sub { find_val_grep_map(    $_, $matrix ) foreach @KEYS; },
  'Map-Grep'  => sub { find_val_map_grep(    $_, $matrix ) foreach @KEYS; },
});
```

## Addendum 1 - using hash keys

As some people have used hash slices to solve this problem - I thought I
would look into this to -- Colin thought this would help in the perl
review! I've added the following function:

```perl
sub find_val_hash {
  my %list;
  @list{ map { @{$_} } @{$_[1]} } = (); ## Quickest 
  return exists $list{$_[0]} ? 1: 0;
}
```

which converts the nested arrayref into an array for the keys of `%list`
and then returns 1 if the value of a key in the hash. Like other methods
this throws away the fact that the array is originally sorted...

Looking at performance - this is approximately 53% slower than the search
algorithm, and therefore less than a tenth of the speed of the optimal
solution.

## Addendum 2 - passing an array rather than an arrayref

I quickly checked to see if by passing the matrix as an array rather than
an arrayref was any faster - one less derefernce - but it is not - it
appears to be the same speed +/- 2%. In most cases it appears to be
the same speed or slightly slower.

## Final timing run with additional two methods in...

| Method      |     Rate  | Hash    | Search | Grep-Map | Map-Grep | *Flatten-@* | *Flatten* | DNF    | Optimal |
| ----------- | --------: | ------: | -----: | -------: | -------: | ----------: | --------: | -----: | ------: |
| Hash        |  2,035/s  |     --  |  -59%  |    -62%  |    -72%  |      *-74%* |    *-76%* |  -90%  |   -91%  |
| Search      |  4,916/s  |   142%  |    --  |     -8%  |    -32%  |      *-37%* |    *-41%* |  -76%  |   -79%  | 
| Grep-Map    |  5,328/s  |   162%  |    8%  |      --  |    -27%  |      *-32%* |    *-36%* |  -73%  |   -77%  |
| Map-Grep    |  7,252/s  |   256%  |   47%  |     36%  |      --  |       *-8%* |    *-13%* |  -64%  |   -69%  |
| *Flatten-@* | *7,855/s* |  *286%* |  *60%* |    *47%* |     *8%* |        *--* |     *-6%* | *-61%* |  *-66%* |
| *Flatten*   | *8,361/s* |  *311%* |  *70%* |    *57%* |    *15%* |        *6%* |      *--* | *-58%* |  *-64%* |
| DNF         | 20,080/s  |   887%  |  308%  |    277%  |    177%  |      *156%* |    *140%* |    --  |   -13%  |
| Optimal     | 23,095/s  | 1,035%  |  370%  |    333%  |    218%  |      *194%* |    *176%* |   15%  |    --   |

## Addendum 3 - caching "flattening"

Optimizations like these are great if you are in the middle of a tight loop and calling the function a number
of times - if this is the same matrix each time - we may get some performance boosts by pre-flattening the matrix.

I've included two more functions "Grep-@" & "Hash-%" which replicate "Grep-Map" and "Hash" to show how this can
speed things up.. The compute on the fly hash is the slowest method - but pre-cacheing the hash is 30 times faster,
the pre-flattened array speeds up the grep - but only by a factor of 2 and so is still only half the speed of
the *do not flatten* versions.

**Note:** The second parameter in each of these is the respective flattened arrayref or hashref.

```perl
sub find_val_grep_pre {
  my($v,$m)=@_;
  return 0 + grep { $_ == $v } @{$m};
}

sub find_val_hash_pre {
  return exists $_[1]{$_[0]} ? 1: 0;
}
```

| Method      |     Rate  | Hash    | Search  | GrepMap | MapGrep | *Flat* | *Flat@* | **Grep@** | DNF    | Opt | **Hash%** |
| ----------- | --------: | ------: | ------: | -------: | -------: | --------: | ----------: | ---------: | -----: | ------: | ----------: |
| Hash        |  1,932/s  |     --  |   -60%  |    -64%  |    -73%  |    *-77%* |      *-77%* |  **-82%**  |-90%  |   -92%  |  **-97%** |
| Search      |  4,824/s  |   150%  |     --  |    -10%  |    -33%  |    *-42%* |      *-43%* |  **-55%**  |-76%  |   -79%  |  **-92%** |
| Grep-Map    |  5,388/s  |   179%  |    12%  |      --  |    -25%  |    *-36%* |      *-36%* |  **-50%**  |-73%  |   -77%  |  **-91%** |
| Map-Grep    |  7,189/s  |   272%  |    49%  |     33%  |      --  |    *-14%* |      *-15%* |  **-33%**  |-64%  |   -69%  | **-88%** |
| Flatten     | *8,389/s* |  *334%* |   *74%* |    *56%* |    *17%* |      *--* |       *-1%* |  ***-22%***  | *-58%*  |   *-63%*  |  ***-86%*** |
| Flatten-@   | *8,432/s* |  *337%* |   *75%* |    *56%* |    *17%* |      *1%* |        *--* |  ***-22%***  | *-58%*  |   *-63%*  |  ***-86%*** |
| **Grep-@**  | **10,764/s** | **457%** | **123%** | **100%**  | **50%** | ***28%*** | ***28%*** |    **--** | -46%  |   **-53%**  |  **-82%** |
| DNF         | 20,080/s  |   940%  |   316%  |    273%  |    179%  |    *139%* |      *138%* |   **87%**  |  --  | **-12%**  |  **-67%** |
| Optimal     | 22,936/s  | 1,087%  |   375%  |    326%  |    219%  |    *173%* |      *172%* |  **113%**  | 14%  |   --  |   **-62%** |
| **Hash-%**  | **60,976/s**  | **3,057%**  | **1,164%**  |  **1,032%**  |    **748%** |    ***627%*** |      ***623%*** |  **466%**  | **204%**  |   **166%**  |    **--** |

# Challenge 2 - Ordered Letters

**Given a word, you can sort its letters alphabetically (case insensitive).
For example, “beekeeper” becomes “beeeeekpr” and “dictionary” becomes
“acdiinorty”.**

**Write a script to find the longest English words that don’t change when
their letters are sorted.**

## Dictionaries available

In this example we will consider the dictionaries available in Ubuntu,
as I am in UK - I will use the British English dictionaries:

 * `/usr/share/dict/british-english-small`
 * `/usr/share/dict/british-english-large`
 * `/usr/share/dict/british-english-huge`
 * `/usr/share/dict/british-english-insane`

## Assumptions into what really is a word

These dictionaries contain a number of "Words" which we wouldn't
necessarily consider to be words. To simplify this we will only
chose words which are all lowercase.

So we will filter these words out...

A summary of the four dictionaries above give the following counts:

| Name:  | # words | # trimmed |
| ------ | ------: | --------: |
| small  |  50,790 |    39,781 |
| large  | 166,828 |   113,695 |
| huge   | 344,861 |   245,593 |
| insane | 654,299 |   427,891 |

## Solution to challenge 2

We will collect all of the words that meet this requirement.
We will collect them in an array `@max`. The first value will
be the length of the words in the list and the rest 

There are 4 parts to the loop...

 * The filters as above...

   `!/[^a-z]/`

* A filter that skips words shorter than the max length
   
   `$max[0] <= length $_`

 * The calculation to see if the word matches

   `lc $_ eq join q(), sort split //, lc $_`

 * The code to either replace the array `@max` with the
   newer longer word *or* to push the new word to the end
   of the list.
   
   `$max[0] == length $_ ? ( push @max, $_ ) : ( @max = (length $_, $_) )`

The full function is....

```perl
sub longest {
  open my $fh, q(<), $_[0];
  my @max = (0);
     (chomp)         ## Remove newline character
  && !/[^a-z]/       ## Remove non-lower case characters
  && ( $max[0] <= length $_ )
                     ## Remove words that are too short
  && ( $_ eq join q(), sort split //, $_ )
                     ## Check the word is unchanged when the
                     ## letters are sorted
  && ( $max[0] == length $_
       ? ( push @max, $_ )
       : ( @max = (length $_, $_) )
     )
    ## If the word is the same length as the maximal word
    ## push it onto @max - so we store all the longest words
    ## with maximum length.
    ## If the word is longer than the max length (1st entry
    ## in @max - reset max to include the new max length and
    ## the word.
    while <$fh>;
  return "$_[0] > @max";
  ## Return the name of the file used, the size of the words
  ## and a complete list of the words of that length.
}
```

If you like the code more compact - here it is without the comments...

```perl
sub longest_no_comments {
  open my $fh, q(<), $_[0];
  my @m = (0);
     (chomp)&&!/[^a-z]/&&($m[0]<=length$_)
  &&($_ eq join q(),sort split//,$_)
  &&($m[0]==length$_?(push@m,$_):(@m=(length$_,$_)))
     while <$fh>;
  return "$_[0] > @m";
}
```

## The results...

Here are the results for each of the four databases:

 * `british-english-small`: max length 6 - 21 words
   * abhors
   * accent
   * accept
   * access
   * accost
   * almost
   * begins
   * bellow
   * billow
   * cellos
   * chills
   * chilly
   * chimps
   * chintz
   * choosy
   * choppy
   * effort
   * floors
   * floppy
   * glossy
   * knotty
* `british-english-large`: max length 7 - 1 word
   * billowy
* `british-english-huge`: max length 7 - 4 words
   * beefily
   * billowy
   * chikors
   * dikkops
* `british-english-insane`: max length 8 - 1 word
   * aegilops

## Some definitions...

All the 6 letter words and billowy and beefily are quite common words, but there are three that people may not have heard of these are all species names.

 * **chikors** - An alternative spelling of chukars - A species of partridge native to central Asia (*Alectoris chukar*).
 * **dikkops** - A bird of the family Burhinidae. The stone curlew, thick-knee. (From afrikaans) *dik*-*kop* or thick head
 * **aegilops** - A genus of Eurasian and North American plants in the grass family, Poaceae. They are known generally as goat grasses. Some species are known as invasive weeds in parts of North America.
