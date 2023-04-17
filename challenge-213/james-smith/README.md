[< Previous 211](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-211/james-smith) |
[Next 213 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-213/james-smith)

# The Weekly Challenge 212

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-212/james-smith

# Task 1: Jumping Letters

***You are given a word having alphabetic characters only, and a list of positive integers of the same length. 
Write a script to print the new word generated after jumping forward each letter in the given word by the integer in the list. The given list would have exactly the number as the total alphabets in the given word.***

## Solution

The solution below is compact - but by chaining `map`s we can break up the functionality.

 * `shift` - grab the first parameter - the string.
 * `split //` - split this into single characters
 * `map { (96&ord) | ( (31&ord) -1 + shift)%26 +1 }` - loop through each letter
   * (96&ord) - get the 2 & 3 bits of the representation - uppercase have only the first bit set, lowercase both.
     * Note `ord` without any parameters acts on $_ or the loop variable - in this case the characters of the sting.
   * `|` - we **or** this back with the result of the second calculation, this means the character will keep it's case
   * `((31&ord) -1 + shift)%26+1` computes the letter shift
     * `31&ord` gets the last 5 bits of the character - this gives the same for the upper/lower case version of a letter, and is the 1-based position of the letter in the alphabet.
     * `-1` converts this to the 0-based position (easier to work with)
     * `+ shift` adds the next element of the parameter list to this - applying the shift.
     * `( .. )%26` wraps this to map back to the alphabet [hence need for 0-based position]
     * `+1` converts back to the 1-based position.
 * `chr` converts back to the character (again no parameter uses `$_`
 * `join ''` joins the string back together

We have no `return` here as perl by default returns the last value computed.... similarly no trailing `;` as one isn't needed for a `}`.

```perl
sub jumping_letters {
  join '',
  map { chr }
  map { (96&ord) | ( (31&ord) -1 + shift)%26 +1 }
  split //,
  shift
}
```

**Note:** An alternative version of the long `map` is available at the same length - which doesn't rely on shifting to `0-based` numbers but converts `0` to `26` by means of an `||26`.

```perl
  map { ( ( (31&ord) + shift )%26 || 26 ) | 96&ord }
```
# Task 2: 

***You are given a list of integers and group size greater than zero. Write a script to split the list into equal groups of the given size where integers are in sequential order. If it can’t be done then print `-1`.***

## Solution

We make the following observations:
 * the order of the numbers is irrelevant - so it can help us by sorting the numbers;
 * not only that but just keeping the count of each number is sufficient.

We therefore compute the counts and loop through these in numeric order:
 * We check to see if the count for the next "n-1" numbers are greater than the count for the current one.
   * If they are we reduce the count and continue.
   * If not we return `-1` as there is no solution.

Again we make the observations:
 * We can reduce the number of the subsequent numbers within the loop that checks as we can be "destructive" in the approach - we return `-1` in the only case this would be bad.
 * We don't store `$n` but `$n` as we never use `$n` without using `$s`
 * We only have to keep track of the first element of each list which starts a sequence - and it's count. Well this is a by-product of the approach. It is what is left in the frequency table...

Notes:
 * Really only one here - that we have to be careful in the last map `[...] x $x` returns `('Array(0x..)','Array(0x..)',...)`, so we have to wrap it in `()` to convert it into an array of scalars to get it to return `([...],[...],...)`.
### Solution 1 - multi-liner...

```perl
sub rearrange_groups {
  my($s,%f) = -1+shift;
  $f{$_}++ for @_;                         ## Get counts
  for my $k ( sort {$a<=>$b} keys %f ) {   ## Loop through numbers
    $f{$k}||next;                          ## Next unless defined and non-zero
      exists $f{$_} && $f{$_}>=$f{$k}      ## Loop through the next $s numbers
    ? $f{$_}-=$f{$k}                       ## If defined & greater than $f{$k}
    : return -1                            ## we update o/w return -1
      for $k+1..$k+$s;
  }
  [ map  { ([$_..$_+$s]) x $f{$_} }        ## Now just output
    sort { $a<=>$b }                       ## note ([...]) as o/w [...] is
    keys %f ]                              ## handled as a string.
}
```

Now with some "craft" the main function can be rewritten as a series of maps to
generate a single statement for everything after we produce the list of frequences.

We replace the inner loop with a `map` to allow us to replace the outer loop with a `map` also.

A trick here - we map `$_` -> `$'` by running the empty regex `//`. `$'` the after value
is assigned to whole of the unmatch string of `$_`. Interestingly `//` appears again - but this
time not an empty regex but as the "*or if defined*" operator.

We then extract this as it is what we
need by by returning it in the 2nd value of the array and accessing with `[1]`.

This leaves the hash `%f` containing the frequence of each list starting at a given point.

Which we again use map to generate the list of lists - which in turn avoids us resorting the
list...

```perl
sub rearrange_groups_one_liner {
  my($s,%f) = -1+shift;
  $f{$_}++ for @_;
  [ map { ([$_..$_+$s]) x $f{$_} }
    map { ( //,
            $',
            $f{$'} && map {
              $f{$_}//0>=$f{$'} ? $f{$_}-=$f{$'} : return -1
            } $'+1..$'+$s
          )[1] }
    sort {$a<=>$b}
    keys %f ]
}
```
