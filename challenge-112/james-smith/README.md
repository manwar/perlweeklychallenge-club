# Perl Weekly Challenge #112

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

# Challenge 1 - Canonical Path

**You are given a string path, starting with a slash ‘/'. Write a script to
convert the given absolute path to the simplified canonical path.**

In a Unix-style file system:

 * A period '.' refers to the current directory
 * A double period '..' refers to the directory up a level
 * Multiple consecutive slashes ('//') are treated as a single slash '/'

The canonical path format:

 * The path starts with a single slash '/'.
 * Any two directories are separated by a single slash '/'.
 * The path does not end with a trailing '/'.
 * The path only contains the directories on the path from the root directory to the target file or directory

## Note....

Please note there is an ambiguity in the question - when then path contains no
files - as it cannot start with a '/' and not end with a '/' - so we have
to make a choice do we return '/' or do we return ''.

In our case we decide to return it as the empty string.
This has the advantage that there is a level of consistency if you do...

$parent_dir.canonical_path('/a');

or

$parent_dir.canonical_path('/');

then it will always end without a "/";

To change the value the functions return you can replace the return
statement with either `return q(/). join q(/), @list` or
`return $str || q(/)`, depending on whether or not the function
stores the path elements in an array or a string.

## Solution to challenge 1

Again another interesting challenge ... we can see if we can improve
performance.

Initially it looks quite complex - there are two solutions classes:

 * splitting the string and creating/modifying an array of the
   individual parts

 * splitting the string and creating/modifying a string

## "Expanded perl code"

### Array - two loops...

 * We first split the directory into path parts and remove any that
   are empty or "`.`".

 * We loop through the array until we find a '`..`' if we do we
   remove it and the previous entry.

 * We then repeat this until we don't find a '`..`'

 * To jump out of the loop we use `next "label"` to not just skip out
   of the inner loop, but to also to restart the parent loop at the
   same time.

 * Finally remove an initial "`..`" which wouldn't get removed by this
   algorithm.

 * and join the array together with '`/`' - we add the `''` so that we
   get the leading '`/`'.

```perl
sub canonical_path_double {
  my $directory_path = shift;
  my @directory_names   = grep { $_ ne '' &&
                                 $_ ne '.' }
                          split m{/},
                          $directory_path;

  OUTER: while(1) {
    foreach (1..$#directory_names) {
      next unless $directory_names[$_] eq '..';
      splice @directory_names,$_-1,2;
      next OUTER;
    }
    last;
  }
  shift @directory_names if @directory_names && $directory_names[0] eq '..';
  return join '/','',@directory_names;
}
```

### Array - 1-loop

We don't need to use a double loop - we can just treat
the resultant array as a queue either pulling "`..`" or
pushing (not "` `" or "`.`") onto the queue.

```perl
sub canonical_path_array {
  my $directory_path = shift;
  my @parts          = split m{/}, $directory_path;
  my @directory_names;
  foreach my $part ( @parts ) {
    next if $part eq '';
    next if $part eq '.';
    if($part eq '..' ) {
      pop @directory_names;
    } else {
      push @directory_names, $part;
    }
  }
  return join '/','',@directory_names;
}
```

### String - 1-loop

Rather than store the parts in a list - we use a string to store
this canonical path - and we either add directories to the end of
it or remove them if we come across a "`..`", in a similar way to
the `push`/`pop` that we used above.

  * We achieve the former - by just concatenating a "`/`" and the
    name to the end of the string.

  * The latter we strip this string off with a regex substitution:
    `s{/[^/]+\Z}{}`. This works in all cases wherever the "`..`"
    is in the list.

  * Note as we are looping through the array we can ignore the
    grep and just skip out of the loop if the name is either ""
    or "`.`".

```perl
sub canonical_path_string {
  my $path = shift;
  my @directories    = split m{/}, $path;
  my $canonical_path = '';
  foreach my $directory_name ( @directories ) {
    next if $directory_name eq '';
    next if $directory_name eq '.';
    if( $directory_name eq q(..) ) {
      $canonical_path =~ s{/[^/]+\Z}{};
    } else {
      $canonical_path .= q(/) . $directory_name;
    }
  }
  return $canonical_path;
}  
```
### String fast - 1-loop

Regexs are not the fastest way to perform simple matches strings
(and intern to modify them). We can speed up the trimming of the
canonical path by replacing the regex solution by using `rindex`
and the four-parameter version of `substr`.

  * `rindex $str, $needle` finds the index of `$needle` in `$str`.
    Here we use it to find the last `/` in string.

  * `substr $str, $offset, $length, $substitute` finds the chunk of
    the string `$str` from `$offset` of given length `$length`. If a
    fourth parameter is set then this region of the string is replaced
    by `$substitute`.

  * We can use this to truncate the string by doing:
  
    `substr $path, rindex( $path, '/' ), ~0, '';`

    In the two-parameter version of `substr` if we omit length then
    this returns to the end of the string. In the four-parameter
    version - we can't omit this - so have to use an alternative
    value - it has to be bigger than the longest string possible.
    We use the "bitwise-negation" operator "`~`" to generate the
    largest value possible. This is: 18,446,744,073,709,551,615 or
    just shy of 16 Exabytes - I believe this should be big enough!

    (Note you can use -ve numbers but there is no way of doing `-0`
    to trim to the end of the line)

The script then becomes:

```perl
sub canonical_path_string_fast {
  my $path = shift;
  my @directories    = split m{/}, $path;
  my $canonical_path = '';
  foreach my $directory_name ( @directories ) {
    next if $directory_name eq '';
    next if $directory_name eq '.';
    if( $directory_name eq q(..) ) {
      substr $canonical_path,
             rindex( $canonical_path, '/' ),
             ~0, '';
    } else {
      $canonical_path .= q(/) . $directory_name;
    }
  }
  return $canonical_path;
}  
```

## "Compact perl code" AKA 1-liners..

Now we can look at how we can compact this code. Here though we
need to consider the trade off between size and performance - the
smallest code is not necessarily the fastest - as some of the
tricks to make the code compact also make it slower.

### The array code...

We have two versions of the code - which are slightly different
The `canonical_path_compact_opt` function is probably closer to
the 1-loop array function above. We use nested-ternaries to replace
the `if else` blocks.

As well as using ternaries to make the code shorter - we use a few
other of our "shortening" tricks:

 * We use **yoda** comparisons ( `"value" eq $variable` ) rather tha
   the more normal `$variable eq "value"` as it means we can save a
   byte { `$var eq''` vs `''eq$var` } as we don't need the extra space.

 * We re-order the if/else so that the we unravel it into an:
   `if() { } elsif() {} else {}` format which is better for
   nested ternaries - even if it may seenm to be less readable.

 * To futher shorten the code in `canonical_path_compact` we
   replace the filtering clause with a regular expression which is
   7-bytes shorter.

```perl

sub canonical_path_compact_opt {
  my @d=();
  ''ne$_&&'.'ne$_&&('..'eq$_?pop@d:push@d,$_)for split/\//,shift;
  join'/','',@d;
}

my @g;
sub canonical_path_compact_glob {
  @g=();
  ''ne$_&&'.'ne$_&&('..'eq$_?pop@g:push@g,$_)for split/\//,shift;
  join'/','',@g;
}

sub canonical_path_compact {
  my @d=();
  /^\.?$/||('..'eq$_?pop@d:push@d,$_)for split/\//,shift;
  return join'/','',@d;
}
```

### The string code

Here we re-implement the two string algorithms in compact 1-liners.

 * `canonical_path_fast` and `canonical_path_fastest` correspond
   directly to the two methods above.

 * `canonical_path_short` replaces the equality checks for "" and
   "`.`" with the regex as we saw in the array code.

 * `canonical_path_shortest` removes the need for one of the
   ternary operators by performing string multiplication when
   adding the directory to the list. If the regex returns true,
   then `"/$_"x!/.../` is `"/$_"x 0` or "". If the regex returns
   false then `"/$_"x!/.../` is `"/$_"x 1` or "`/$_`".
   
```perl 
sub canonical_path_shortest {
$a='';
'..'ne$_?$a.="/$_"x!/^\.?$/:$a=~s#/[^/]+$## for split'/',shift;
$a
}
```
```perl
sub canonical_path_short {
$a='';
/^\.?$/?0:'..'ne$_?$a.="/$_":$a=~s#/[^/]+$## for split'/',shift;
$a
}
```
```perl
sub canonical_path_fast {
$a='';
'.'ne$_&&''ne$_&&('..'ne$_?$a.="/$_":$a=~s#/[^/]+$##)for split'/',shift;
$a
}
```
```perl
sub canonical_path_fastest {
$a='';
'.'ne$_&&''ne$_&&('..'ne$_?$a.='/'.$_:substr$a,rindex($a,'/'),~0,'')for split'/',shift;
$a
}
```
```perl
my $s;
sub canonical_path_global {
$s='';
'.'ne$_&&''ne$_&&('..'ne$_?$s.='/'.$_:substr$s,rindex($s,'/'),~0,'')for split'/',shift;
$s
}
```

## Performance of different methods

We will look at some different versions of the code:

  * whether we use an array or string to accumulate the resultant path
  * Whether we use "readable" code or Perl hacks and tricks

To see what aspects of our code makes it faster or slower

### Summary of methods..
 * "Long form" Perl...
   * `canonical_path_double`      - Using a double loop
   * `canonical_path_array`       - Using backtracking instead of inner loop
   * `canonical_path_string`      - Use a string as the accumulator and mapping
   * `canonical_path_string_fast` - As above - but using substr/rindex
 * "One-liner" perl {arrays}
   * `canonical_path_compact`      - short version of array code
   * `canonical_path_compact_opt`  - optimized version of above - 1-less regex
   * `canonical_path_compact_glob` - as above but with global variable
 * "One-liner" perl {strings}
   * `canonical_path_shortest` - most compact method
   * `canonical_path_short`    - compact method
   * `canonical_path_fast`     - replace one of the regex with equality checks
   * `canonical_path_fastest`  - replace other regex with substr/rindex
   * `canonical_path_global`   - as fastest but with global variable...

### Performance of each method:

|              |    Rate  | @-sh | $-st | $-sh | @&2l | $&fa | $-fa | @&ft | $&ft | @-ft | @-gl | $-ft | $-gl |
| ------------ | -------- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| @-short      | 20,877/s |   -- |  -6% |  -8% | -15% | -25% | -32% | -38% | -43% | -45% | -45% | -50% | -51% |
| $-shortest   | 22,124/s |   6% |   -- |  -2% | -10% | -21% | -28% | -34% | -40% | -41% | -42% | -47% | -48% |
| $-short      | 22,573/s |   8% |   2% |   -- |  -8% | -19% | -27% | -33% | -39% | -40% | -41% | -46% | -47% |
| @-&-2-loop   | 24,631/s |  18% |  11% |   9% |   -- | -12% | -20% | -26% | -33% | -35% | -35% | -41% | -42% |
| $-&-fast     | 27,933/s |  34% |  26% |  24% |  13% |   -- |  -9% | -16% | -24% | -26% | -27% | -34% | -35% |
| $-fast       | 30,769/s |  47% |  39% |  36% |  25% |  10% |   -- |  -8% | -17% | -18% | -19% | -27% | -28% |
| @-&-fastest  | 33,445/s |  60% |  51% |  48% |  36% |  20% |   9% |   -- |  -9% | -11% | -12% | -20% | -22% |
| $-&-fastest  | 36,900/s |  77% |  67% |  63% |  50% |  32% |  20% |  10% |   -- |  -2% |  -3% | -12% | -14% |
| @-fastest    | 37,736/s |  81% |  71% |  67% |  53% |  35% |  23% |  13% |   2% |   -- |  -1% | -10% | -12% |
| @-global     | 38,168/s |  83% |  73% |  69% |  55% |  37% |  24% |  14% |   3% |   1% |   -- |  -9% | -11% |
| $-fastest    | 42,017/s | 101% |  90% |  86% |  71% |  50% |  37% |  26% |  14% |  11% |  10% |   -- |  -2% |
| $-global     | 42,735/s | 105% |  93% |  89% |  74% |  53% |  39% |  28% |  16% |  13% |  12% |   2% |   -- |


### Summary
What we see is:
 * that the optimized string code is faster than the array code,
   by around 12-15%
 * using compact "1-liner" code can be approximately 10%
   faster.
 * but using less regex's and replacing them with
   eq/ne for comparisons and `substr`/`rindex` for
   replacement/trimming improves the speed the most.
    * approx 25-30% for removing the comparison regex for checking
      `' '` or `'.'` and replacing with two `eq`/`ne`
    * approx 30-40% for removing the substitute of the string
      from the last `'/'` to the end of the string, with `rindex`
      and the the four parameter version of `substr`.
    * combining the two seems to double the performance!
  * switching from local to global variables gets a minor
    gain (about 1-2%) again due to memory management.

## Conclusion

So short code is interesting - but is not by a long shot the
most efficient especially in respect of converting regexes into
`substr`/`index`/`rindex`, allocation of variables, even if we
keep it to a 1-liner.

*e.g.* with the short code - we see the optimal short string code is
twice as efficient as the shortest version - and only about 33% longer.

One of the interesting things is that there is some discussion that
avoiding concatenating strings by pushing them into an array and
joining them is supposedly faster than just concatenating.... This
seems to prove otherwise.. So don't assume everything you read - but
check it yourself!

# Challenge 2 - Climb Stairs

You are given `$n` steps to climb - Write a script to find out the
distinct ways to climb to the top. You are allowed to climb either
1 or 2 steps at a time.

## Assumption

Although not clear - I just assumed that the response was a single
numeric value.

## Solution

We first note that the formula for number of steps climbed can be
seen to be.

  `count_n = count_(n-1) + count_(n-2)`

As the last step is either a 1-step (when there are therefore `count_(n-1)`
options to get to that step) or 2-step (when there are therefore `count_(n-2)`
options to get to that step)...

This is a recognisable formula - it is just a fibonnaci sequence.

## Brute force solution

We could use a recursive method to get the fibonnaci values out - but
that would have function call overheads - rather we can use just two
variables to store the sequence, we define `$a` & `$b` to both be `1`
and then each iteration through we set `$a` to `$b` and `$b` to the sum
of `$a` & `$b`. We just then return the last value of `$b`.

```perl
sub climb {
  my($a,$b) = (1,1);
  ($a,$b) = ($b,$a+$b) foreach 2..$_[0];
  return $b;
}
```

This uses one of the nice features of perl in the fact that you can
assign to more than one variable with the same statement, you often
see this when you flip two values over.

Classically you would write:

```perl
my $t = $a;
$a = $b;
$b = $t;
```
but you in perl can write this as:
```perl
($a,$b)=($b,$a);
```
without the need of the additionaly (temporary) variable.

## Building a cache using state or global variables - or pre-computing

If the call is being made repeatedly we can cache results - either
using a "`state`" variable within the function or a "`global`" variable.

```perl
sub climb_cache {
  state @cache = (1,1);
  $cache[$_]=$cache[$_-1]+$cache[$_-2] foreach @cache .. $_[0];
  return $cache[$_[0]];
}

my @glob_cache = (1,1);
sub climb_cache_glob {
  $glob_cache[$_]=$glob_cache[$_-1]+$glob_cache[$_-2] foreach @glob_cache .. $_[0];
  return $glob_cache[$_[0]];
}
```

Finally we look at the cache check overhead by pre-computing the values into 
a cache and then run:

```perl
sub climb_lookup {
  return $ans[$_[0]];
} 
```

## Mathematical formula solution

There is Binet's formula for the `n`th fibonacci number which is:

```
     phi^n - 1/(-phi)^n
fn = ------------------
         sqrt 5
```

Where `phi` is the golden ratio or 1.618,033,988 == (1+sqrt 5)/2, this
number crops up in many different places from art to nature.

To speed up the calculation we compute `(phi^n)` and to get the second
value we note that this can be written as `(-1)^n/(phi^n)`. So we only
need to calculate `(phi^n)` once. Also we note `(-1)^n` can be
rewritten as `n&1?1:-1`;

In reality we don't even need to do this last trick, the contribution
to the sum of '(-1)^n/(phi^n)/sqrt 5' is going to be less than `0.5`
for all `n>=0` we can just reduce the formula to the first part to

```
fn = floor  (phi^n/sqrt 5)
```

```perl
sub climb_fib {
  my $q = ((1 + sqrt 5)/2)**($_[0]+1);
  return int(0.001+ ($q - ($_[0]&1?1:-1)/$q)*sqrt 0.2);
}

sub climb_fib_1liner {
  return int(0.001 + (($a = ((1+sqrt 5)/2)**($_[0]+1)) - ($_[0]&1?1:-1)/$a)*sqrt 0.2);
}

sub climb_fib_approx {
  return int(0.4 + (0.5+sqrt 1.25)**($_[0]+1)*sqrt 0.2);
}
```

## Analysis and conclusion

The following are data for computing all values up to "50 steps".

|       |      Rate |  climb |   fib | fib-1 | cache | g-cch | fib-a | look  |
| ----- |  -------: |  ----: | ----: | ----: | ----: | ----: | ----: | ----: |
| climb |   7,145/s |     -- |  -86% |  -88% |  -89% |  -89% |  -92% |  -96% |
| fib   |  52,854/s |   640% |    -- |   -8% |  -16% |  -21% |  -39% |  -72% |
| fib-1 |  57,208/s |   701% |    8% |    -- |   -9% |  -14% |  -34% |  -70% |
| cache |  62,657/s |   777% |   19% |   10% |    -- |   -6% |  -28% |  -67% |
| g-cch |  66,489/s |   831% |   26% |   16% |    6% |    -- |  -23% |  -65% |
| fib-a |  86,505/s | 1,111% |   64% |   51% |   38% |   30% |    -- |  -54% |
| look  | 189,394/s | 2,551% |  258% |  231% |  202% |  185% |  119% |    -- |


 * Using "Binet's" formula we see we get approx `8x` the speed of
   the original `climb` function.
 * Using the approximation to Binet's formulate we see we get a factor
   of about `12x` speed up.
 * Using the cache seems to give about a `9x` speed gain - the `global`
   variable version is better than the `state` version.
 * Interestingly if you pre-compute the cache then the speed gain is
   over `25x` to the original and `3x` times the speed of the basic
   cache function - this is probably due to the overhead of checking
   to see if the number is already in the cache.

So some food for thought on how to best handle calls within tight loops.
