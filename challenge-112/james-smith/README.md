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

### Array - 1-loop with backtracking

To avoid the double loop - we can use back-tracking so that when we
find a "`..`" instead of restarting the loop we just step back one
entry in the array - we see `$pointer--` after the `splice`
statement below.

 * If `$pointer == 0` then the `..` is at the start of the directory
   list so we just remove it (we can't go back beyond the root
   directory).

```perl
sub canonical_path_array {
  my $directory_path = shift;
  my @directory_names   = grep { $_ ne '' &&
                                 $_ ne '.' }
                          split m{/},
                          $directory_path;
  my $pointer = 1;
  while( $pointer < @directory_names ) {
    if( $directory_names[$pointer] eq '..' ) {
      if( $pointer > 0 ) {
        splice @directory_names, $pointer - 1, 2;
        $pointer --;
      } else {
        shift @directory_names;
      }
    } else {
      $pointer ++;
    }
  }
  return join '/','', @directory_names;
}
```

### String - 1-loop

Rather than store the parts in a list - we use a string to store
this canonical path - and we either add directories to the end of
it or remove them if we come across a "`..`".

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

 * We use variable `$a` as this is a variable we don't need to `my`.

 * We also store the split path name in `@_`, this has two advantages:
   we don't need to `my` it and secondly - we can just use `shift`
   without using a variable in the while loop - as `shift` in a
   function shifts off `@_`

 * We use **yoda** comparisons ( `"value" eq $variable` ) rather tha
   the more normal `$variable eq "value"` as it means we can save a
   byte { `$var eq''` vs `''eq$var` } as we don't need the extra space.

 * We re-order the if/else so that the we unravel it into an:
   `if() { } ifelse() {} else {}` format which is better for
   nested ternaries - even if it may seen to be less readable.

 * In the code above we separated the `$pointer - 1` in the `splice`
   line with the `$pointer--` in the next line to back-track. We can
   use `--$pointer` to achieve this all within the splice statement.

 * To futher shorten the code in `canonical_path_compact` we
   replace the `grep` clause with a regular expression which is
   7-bytes shorter.

```perl
sub canonical_path_compact_opt {
## Remove the regex in the grep and use ternarys...
$a=1,@_=grep{''ne$_&&'.'ne$_}split/\//,shift;
$_[$a]ne'..'?$a++:$a?splice@_,--$a,2:shift while$a<@_;
join'/','',@_
}
```
```perl
sub canonical_path_compact {
## Make shorted by using regex and ternarys
$a=1,@_=grep{!/^\.?$/}split/\//,shift;
$_[$a]ne'..'?$a++:$a?splice@_,--$a,2:shift while$a<@_;
join'/','',@_
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
   * `canonical_path_compact`     - short version of array code
   * `canonical_path_compact_opt` - optimized version of above - 1-less regex
 * "One-liner" perl {strings}
   * `canonical_path_shortest` - most compact method
   * `canonical_path_short`    - compact method
   * `canonical_path_fast`     - replace one of the regex with equality checks
   * `canonical_path_fastest`  - replace other regex with substr/rindex
   * `canonical_path_global`   - as fastest but with global variable...

### Performance of each method:

|                |     Rate | @-st | $-st | $-sh | @-2l | @-cf | @-ft | $-cd | $-fa | $-cf | $-ft | $-gl |
| -------------- | -------: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| @-shortest     | 17,483/s |   -- | -21% | -22% | -29% | -30% | -37% | -38% | -43% | -52% | -59% | -59% | 
| $-shortest     | 22,026/s |  26% |   -- |  -2% | -11% | -11% | -21% | -21% | -28% | -40% | -48% | -49% | 
| $-short        | 22,472/s |  29% |   2% |   -- |  -9% | -10% | -20% | -20% | -26% | -39% | -47% | -48% | 
| @-code-2loop   | 24,631/s |  41% |  12% |  10% |   -- |  -1% | -12% | -12% | -19% | -33% | -42% | -43% | 
| @-code-fastest | 24,876/s |  42% |  13% |  11% |   1% |   -- | -11% | -11% | -18% | -32% | -42% | -42% | 
| @-fastest      | 27,933/s |  60% |  27% |  24% |  13% |  12% |   -- |  -0% |  -8% | -24% | -35% | -35% | 
| $-code-fast    | 28,011/s |  60% |  27% |  25% |  14% |  13% |   0% |   -- |  -8% | -24% | -34% | -35% | 
| $-fast         | 30,488/s |  74% |  38% |  36% |  24% |  23% |   9% |   9% |   -- | -17% | -29% | -29% | 
| $-code-fastest | 36,765/s | 110% |  67% |  64% |  49% |  48% |  32% |  31% |  21% |   -- | -14% | -15% | 
| $-fastest      | 42,735/s | 144% |  94% |  90% |  74% |  72% |  53% |  53% |  40% |  16% |   -- |  -1% | 
| $-global-fast  | 43,103/s | 147% |  96% |  92% |  75% |  73% |  54% |  54% |  41% |  17% |   1% |   -- |

### Summary
What we see is:
 * that the string code is faster than the array code,
   by around 20-40%
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
    gain (about 1%) again due to memory management.

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

## Mathematical formula solution

There is a formula for the `n`th fibonacci number which is:

```
fn = phi^n - 1/(-phi)^n
     ------------------
         sqrt 5
```

Where `phi` is the golden ratio or 1.618,033,988 == (1+sqrt 5)/2, this
number crops up in many different places from art to nature.

To speed up the calculation we compute `(phi^n)` and to get the second
value we note that this can be written as `(-1)^n/(phi^n)`. So we only
need to calculate `(phi^n)` once. Also we note `(-1)^n` can be
rewritten as (n&1)||-1;

I offer a number of different versions of this calculation... Each
one gets slightly faster... really depending on whether we define
the variable in the return statement or define it separately and
whether we use a local or global variable...

```perl
sub climb_fib {
  my $q = ((1 + sqrt 5)/2)**($_[0]+1);
  return int(0.001+ ($q - ($_[0]&1?1:-1)/$q)*sqrt 0.2);
}

sub climb_fib_1liner {
  return int(0.001 + (($a = ((1+sqrt 5)/2)**($_[0]+1)) - ($_[0]&1?1:-1)/$a)*sqrt 0.2);
}

sub climb_fib_global {
  $p = ((1 + sqrt 5)/2)**($_[0]+1);
  return int(0.001+ ($p - ($_[0]&1?1:-1)/$p)*sqrt 0.2);
}

sub climb_fib_1liner_global {
  return int(0.001 + (($p = ((1+sqrt 5)/2)**($_[0]+1)) - ($_[0]&1?1:-1)/$p)*sqrt 0.2);
}
```

For up to 50 steps then we note that the `climb_fib` function is about
6-7 times faster than the original `climb` function, by using the 1-liner
and global tricks this gets to about 7-8 times the speed.

|        |     Rate | climb |   fib | fib-1 | fib-g | fib1g |
| ------ | -------: | ----: | ----: | ----: | ----: | ----: |
| climb  |  7,933/s |    -- |  -85% |  -86% |  -86% |  -87% |
| fib    | 52,770/s |  565% |    -- |   -6% |   -8% |  -11% |
| fib-1  | 56,180/s |  608% |    6% |    -- |   -3% |   -5% |
| fib-g  | 57,637/s |  627% |    9% |    3% |    -- |   -3% |
| fib-1g | 59,347/s |  648% |   12% |    6% |    3% |    -- |


