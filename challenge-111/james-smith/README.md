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
We then use `grep` to further filter these results
for existances of the array.

The resultant array will have length `0` or `1`.

```perl
sub find_val_grep_grep {
  my($v,$m)=@_;
  return 0 + grep { grep { $_ == $v } @{$_} } @{$m};
}
```

Now to avoid as many of the `grep`s as possible we can do two things. First check the
number is in the range of the matrix - this skips the outer `grep` for some values and
secondly - check the value is in the range for each line you are looping over.... This
leads us to:

```perl
sub find_val_grep_grep_ext {
  my($v,$m)=@_;
  return $v<$m->[0][0] || $v > $m->[-1][-1]
       ? 0
       : 0 + grep { $v>=$_->[0] && $v<=$_->[-1] && grep { $_ == $v } @{$_} } @{$m};
}
```
## Efficiency

We use `cmpthese` to compare the performance...

Our methods are:
  * **Search**:   `find_val_search`
  * **GrepMap**:  `find_val_grep_map`
  * **GrepGrep**: `find_val_grep_grep`
  * **GrepExt**: `find_val_grep_grep_ext`
  * **Flatten**:  just flattens the array - basic benchmark to compare efficiency to that function....

Timings using `Benchmark::cmpthese`

|           |   Rate    | Search | GrepMap | GrepGrep | *Flatten* | GrepExt |
| --------- | --------: | -----: | ------: | -------: | --------: | ------: |
| Search    |  4,857/s  |    --  |   -3%   |    -34%  |  *-42%*   |  -68%   |
| GrepMap   |  4,995/s  |    3%  |    --   |    -32%  |  *-40%*   |  -67%   |
| GrepGrep  |  7,391/s  |   52%  |   48%   |      --  |  *-11%*   |  -52%   |
| *Flatten* | *8,326/s* |  *71%* |  *67%*  |    *13%* |   *--*    | *-46%*  |
| GrepExt   | 15,337/s  |  216%  |  207%   |    108%  |   *84%*   |   --    |


Notes:

  *  *Flatten* is for comparison only - it actually does nothing other than flatten
     the array - this highlights how efficient each algorithm is (and can be)
 
  * So we see that the grep_grep solution is nearly 60% more efficient than the search
    algorithm (this is true for all search method algorithms which flatten
    the array first), add the filtering to the outer grep - this becomes faster than
    flatten - and around 3 times the speed of search.

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

### Do not flatten - generalised solution

 * Above we used the information that we are supplied with a 5x5 matrix
   if the matrix is an arbitrary size we can change the two loops to
   use a binary search algorithm.
   
 * Notes:

    * We use `($l+$r)>>1` to find the mid point - this is more efficient
      than using `int(($l+$r)/2)`; Bit-shift operators are useful if you
      are multiplying or dividing by 2.

    * The loops differ slightly because one is looking for an entry which
      is within a range - the other for a specific value. The differencs
      you will note are (1) the first loop do `$r=$n` where in the
      second we do `$r=$n-1` - as the first is a range based search the
      second an exact match; (2) The second loop checks for equality before
      the binary search check - and returns 1 if true. The end eheck also
      becomes $l<=$r as $r becomes less than $l when we have missed the
      entry.

```perl
sub find_val_general_dnf {
  my($v,$m)=@_;
  return 0 if$v<$m->[0][0]||$v>$m->[-1][-1];
  my($n,$l,$r)=(0,0,@{$m}-1);
  $v>$m->[$n=($l+$r)>>1][-1]?($l=$n+1):($r=$n)while$r!=$l;
  ($l,$r)=(0,@{$m=$m->[$l]}-1);
  ($v==$m->[$n=($l+$r)>>1])?(return 1):$v>$m->[$n]?($l=$n+1):($r=$n-1)while$l<=$r;
  return 0;
}
```
Timings using `Benchmark::cmpthese`

|           |   Rate    | Search | GrepMap | GrepGrep | *Flatten* | DNFGen | GrepExt | DNF    | DNFOpt |
| --------- | --------: | -----: | ------: | -------: | --------: | -----: | ------: | -----: | -----: |
| Search    |  4,316/s  |    --  |   -20%  |    -41%  |   *-47%*  |  -64%  |  -71%   |  -79%  |  -81%  |
| GrepMap   |  5,391/s  |   25%  |     --  |    -26%  |   *-34%*  |  -55%  |  -64%   |  -73%  |  -76%  |
| GrepGrep  |  7,310/s  |   69%  |    36%  |      --  |   *-10%*  |  -39%  |  -52%   |  -64%  |  -68%  |
| *Flatten* | *8,123/s* |  *88%* |   *51%* |   *11%*  |     *--*  | *-33%* | *-46%*  | *-60%* | *-65%* |
| DNFGen    | 12,063/s  |  179%  |   124%  |     65%  |    *48%*  |    --  |  -20%   |  -40%  |  -47%  |
| GrepExt   | 15,106/s  |  250%  |   180%  |    107%  |    *86%*  |   25%  |    --   |  -25%  |  -34%  |
| DNF       | 20,161/s  |  367%  |   274%  |    176%  |   *148%*  |   67%  |   33%   |    --  |  -12%  |
| DNFOpt    | 22,883/s  |  430%  |   324%  |    213%  |   *182%*  |   90%  |   51%   |   14%  |   --   |

We can see that this "optimal method" is about 5 times more efficient than the "search"
function we originally tried - even the generic double binary search is abour 2.5 times as
efficient than the binary search over the flattened matrix.

## Test script

For completeness - this is the test and benchmarking script

```perl
#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese);

my $N = @ARGV ? $ARGV[0] : 100_000;

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

is( find_val_grep_grep(    35, $matrix ), 0 );
is( find_val_grep_grep(    39, $matrix ), 1 );
#...
#...
#...
is( find_val_find_val_dnf_optimal(    35, $matrix ), 0 );
is( find_val_find_val_dnf_optimal(    39, $matrix ), 1 );

## Now run our full test set - from -10 to 60. This covers
## all cases within the list and a few either side...

is( find_val_search(      $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;
is( find_val_grep_grep(   $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;
#...
#...
#...
is( find_val_dnf_optimal( $_, $matrix ), $TEST_SET{$_} ) foreach @KEYS;

done_testing();

cmpthese( $N, {
  'Search'    => sub { find_val_search(      $_, $matrix ) foreach @KEYS; },
  'GrepGrep'  => sub { find_val_grep_grep(   $_, $matrix ) foreach @KEYS; },
  #...
  #...
  #...
  'DNFOpt'    => sub { find_val_dnf_optimal( $_, $matrix ) foreach @KEYS; },
} );
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
appears to be roughtly the same and speed sometimes faster.

```perl
sub flatten_array {
  shift @_;
  my @list = map { @{$_} } @_;
  return 1;
}
```

## Addendum 3 - using `List::Util` methods

Just out of interest to compare the core `map` and `grep` against the various `List::Util` functions `first`/`any`, I've added 3 more functions:

```perl
sub find_val_list_util {
  my($v,$m) = @_;
  my $t =  first { $_->[-1] >= $v } @{$m};
  return ($t && any { $v == $_ } @{$t}) ? 1 : 0;
}

sub find_val_any_any {
  my($v,$m) = @_;
  return (any { $v>=$_->[0] && $v <=$_->[-1] && (any { $_ == $v } @{$_}) } @{$m}) ? 1 : 0;
}

sub find_val_any_any_naive {
  my($v,$m) = @_;
  return (any { any { $_ == $v } @{$_} } @{$m}) ? 1 : 0;
}
```

The last one is similar to the `grep - grep` method above but uses `any` - now in theory this
should be faster as `any` stops at the first occcurance - but as `grep` is core and `any` is
not there will be a performance penalty - especially for such a small set of values.

To speed things upw ithe add a check to see if the value is inside the row greater/equal to the
first value and less than/equal to the last value. This makes a big difference.


## Addendum 4 - caching the "flattening"

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

| Method      | Rate         | Hash      | AANaive   | Search    | GrepMap   | AnyAny    | ListUtil  | GrepGrep  | *Flatten*  | *Flatten@* | **preGrep** | DNFGen   | GrepExt  | DNF      | DNFOpt   | **preHash** |
| ----------- | -----------: | --------: | --------: | --------: | --------: | --------: | --------: | --------: | ---------: | ---------: | ----------: | -------: | -------: | -------: | -------: | ---------:  |
| Hash        |    2,019/s   |      --   |    -26%   |    -59%   |    -63%   |    -67%   |    -69%   |    -73%   |   *-76%*   |   *-76%*   |   **-82%**  |   -83%   |   -87%   |   -90%   |   -91%   |   **-98%**  | 
| AANaive     |    2,714/s   |     34%   |      --   |    -44%   |    -50%   |    -56%   |    -58%   |    -64%   |   *-68%*   |   *-68%*   |   **-75%**  |   -78%   |   -82%   |   -87%   |   -88%   |   **-97%**  | 
| Search      |    4,873/s   |    141%   |     80%   |      --   |    -10%   |    -20%   |    -24%   |    -35%   |   *-42%*   |   *-42%*   |   **-56%**  |   -60%   |   -68%   |   -76%   |   -79%   |   **-94%**  | 
| GrepMap     |    5,435/s   |    169%   |    100%   |     12%   |      --   |    -11%   |    -15%   |    -27%   |   *-35%*   |   *-36%*   |   **-51%**  |   -55%   |   -64%   |   -73%   |   -76%   |   **-94%**  | 
| AnyAny      |    6,127/s   |    204%   |    126%   |     26%   |     13%   |      --   |     -5%   |    -18%   |   *-27%*   |   *-27%*   |   **-44%**  |   -50%   |   -60%   |   -70%   |   -73%   |   **-93%**  | 
| ListUtil    |    6,427/s   |    218%   |    137%   |     32%   |     18%   |      5%   |      --   |    -14%   |   *-24%*   |   *-24%*   |   **-42%**  |   -47%   |   -58%   |   -68%   |   -72%   |   **-92%**  | 
| GrepGrep    |    7,452/s   |    269%   |    175%   |     53%   |     37%   |     22%   |     16%   |      --   |   *-11%*   |   *-12%*   |   **-32%**  |   -39%   |   -51%   |   -63%   |   -68%   |   **-91%**  | 
| *Flatten*   |    8,418/s*  |   *317%*  |   *210%*  |    *73%*  |    *55%*  |    *37%*  |    *31%*  |    *13%*  |     *--*   |    *-0%*   |  ***-24%*** |  *-31%*  |  *-45%*  |  *-58%*  |  *-63%*  |  ***-90%*** | 
| *Flatten@*  |    8,446/s*  |   *318%*  |   *211%*  |    *73%*  |    *55%*  |    *38%*  |    *31%*  |    *13%*  |     *0%*   |     *--*   |  ***-23%*** |  *-31%*  |  *-45%*  |  *-58%*  |  *-63%*  |  ***-90%*** | 
| **preGrep** | **11,013/s** |  **446%** |  **306%** |  **126%** |  **103%** |   **80%** |   **71%** |   **48%** |  ***31%*** |  ***30%*** |     **--**  | **-10%** | **-28%** | **-46%** | **-52%** |   **-87%**  | 
| DNFGen      |   12,195/s   |    504%   |    349%   |    150%   |    124%   |     99%   |     90%   |     64%   |    *45%*   |    *44%*   |    **11%**  |     --   |   -20%   |   -40%   |   -47%   |   **-86%**  | 
| GrepExt     |   15,244/s   |    655%   |    462%   |    213%   |    180%   |    149%   |    137%   |    105%   |    *81%*   |    *80%*   |    **38%**  |    25%   |     --   |   -25%   |   -34%   |   **-82%**  | 
| DNF         |   20,243/s   |    903%   |    646%   |    315%   |    272%   |    230%   |    215%   |    172%   |   *140%*   |   *140%*   |    **84%**  |    66%   |    33%   |     --   |   -12%   |   **-76%**  | 
| DNFOpt      |   22,936/s   |   1036%   |    745%   |    371%   |    322%   |    274%   |    257%   |    208%   |   *172%*   |   *172%*   |   **108%**  |    88%   |    50%   |    13%   |     --   |   **-73%**  | 
| **preHash** | **84,746/s** | **4098%** | **3022%** | **1639%** | **1459%** | **1283%** | **1219%** | **1037%** | ***907%*** | ***903%*** |   **669%**  | **595%** | **456%** | **319%** | **269%** |     **--**  |

## Summary...

So as we can see our **DNFOpt** (`find_val_dnf_optimal`) method is the optimal method running at approx 1,700,000 calculations per second, followed by the unoptimized **DNF** (`find_val_dnf`) method at approximately 1,500,000 caclulations per second - these are both optimized to know the matrix is 5x5.

Interestingly the fastest method (without explicitly coding for 5x5) is the optimized version of the `grep`x`grep` of the **GrepExt** (`find_val_grep_grep_ext`) method at approximately 1,100,000 calculations per second. This slighlty nudges out the generic form of the nested binary search **DNFGen** (`find_val_general_dnf`) method at 900,000 calculations per second.

Other things to note..:
  * `grep`x`grep` method **GrepGrep** (`find_val_grep_grep`) is faster than all the versions using `List::Util` using `any` and `first` by approximately 15%, actually comparing like for like with **AANaive** (`find_val_any_any_naive`) is 2.75 times faster... I guess this is because `grep` is built in... There may be a sweet point where this changes as the matrix gets large though.
  * The worst methods are: **Hash** (`find_val_hash`), **AANaive** (`find_val_any_any_naive`) and **Search** (`find_val_search`) at approximately 150,000, 200,000 and 350,000 calculations per second.
  * The range between best and worst is an order of magnitude.
  * I haven't included in this summary the two **preGrep** and **preHash** methods - which pre-flatten the matrix - and note that the **preHash** method is the fastest by far - nearly 4 times faster than are *best* method **DNFOpt**, even though the **Hash** method was worse (the ration of the two hash methods is approximately 40:1). This shows that if it is possible to cache some part of the calculation it can greatly improve performance if called lots of time.
 
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
