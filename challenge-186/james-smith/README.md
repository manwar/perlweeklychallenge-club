[< Previous 184](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-184/james-smith) |
[Next 186 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-186/james-smith)

# The Weekly Challenge 185

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-184/james-smith

# Task 1 - MAC Address

***You are given MAC address in the form i.e. `hhhh.hhhh.hhhh`. Write a script to convert the address in the form `hh:hh:hh:hh:hh:hh`.***

## Solution

There are a number of different approaches to this problem, use `substr`, use `pack`/`unpack`, use `split`, use `s///`.

```perl
sub mac_regex  { pop =~ s{(\w\w)(\w\w)[.](\w\w)(\w\w)[.](\w\w)(\w\w)}
                         {$1:$2:$3:$4:$5:$6}r }
sub mac_submap { join ':', map { substr $_[0], $_, 2 } 0,2,5,7,10,12 }
sub mac_substr { join ':', substr($_[0],0,2), substr($_[0],2,2), substr($_[0],5,2),
                           substr($_[0],7,2), substr($_[0],10,2), substr($_[0],12,2) }
sub mac_pack   { sub { pack 'ScScScScScS', $_[0],58, $_[1],58, $_[3],58,
                       $_[4],58, $_[6],58,$_[7] }->( unpack 'SScSScSS', $_[0] ) }
sub mac_split  { join ':', @{[split /(\w\w)/, pop]}[1,3,5,7,9,11] }
```

Most of the methods are relatively simple:
 * First method - we write a regex to replace the '`.`'s with '`:`'s, and also to split each pair in two and separate with a `:`.
 * Two and three are variants on grabbing the elements of the string representing the digits and stitching them back together.
 * Method 4 uses `unpack` to unpack the string into 16-bit integers and then pack it with 
 * Last method uses split with capture brackets which keeps the separators as well as the parts of the string between the seprators. In this case the separators are the hex-pairs, and when we join together using an array slice we only keep the separators {the odd elements of the array}

### How do they perform?

Method name | Rate(/s)  | Relative rate
----------- | --------: | ------------:
mac_regex   | 2,272,727 |          1.00
mac_substr  |   568,182 |          0.25
mac_submap  |   555,556 |          0.24
mac_pack    |   374,222 |          0.15
mac_split   |   101,215 |          0.04

So we see (unlike the last week) the regex version is the most efficient by a factor of 4...

# Task 2 - Mask Code

***You are given a list of codes in many random format. Write a script to mask first four characters (`a`-`z`,`0`-`9`) and keep the rest as it is***

## Solution

Again this is string manipulation so that we can think of the all the tools in our arsenal... but in this case looks like `s{}{}r` or `sprintf` our our easiest solutions...

```perl
sub mask_reghc { map {
  s{[0-9a-z]([^0-9a-z]*)[0-9a-z]([^0-9a-z]*)[0-9a-z]([^0-9a-z]*)[0-9a-z]}
  {x$1x$2x$3x}r
} @_ }

sub mask_split { map { join 'x', split /[0-9a-z]/, $_, 5 } @_ }
```
Our first solution looks for the first alphnumeric character, we then skip anynumber of non-alphanumeric - alternating until we have 4 matches, we then replace those characters.

Our second uses the 3 parameter version of `split` which allows you to stipulate how many matches we make - as we have 4 separators that we wish to replace we need 5 stings. When we have these we just stitch the strings back together.

### Performance

In this case the second method (`split`) is approximately 50% faster than the regex method.
