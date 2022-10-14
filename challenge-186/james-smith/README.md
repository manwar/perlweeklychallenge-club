[< Previous 185](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-185/james-smith) |
[Next 187 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-187/james-smith)

# Ʈʯḗ Ŵꭂḵⱡʏ Chåɫleŋȅ 186

Ỷȣ ʗầņ fɪƞẟ ḿồṛĕ ĩƞꬵõɽɯɑẖıọǹ ꬰƀȣƫ ðiŝ ŵꭂḵꭍ, ẚꬻḋ ṗʁeỽíȣẜ ẅꭂks cẗâỻɛŋɘṧ ẩṱ:

  https://theweeklychallenge.org/

Ïf ỿȣ ḁrẽ ṇọť aľɻəǻďƴ ẟƣŋ ðe ĉʮảꬸḽeŋḗ - íṯ ȉṥ ẫ ġỏoď plẵꭢ ʈⱺ ṗꭉaꬿŧiśe ɏỗůꭆ
**ƥěꭈⱡ** öṟ **ꭉakū**. Įƒ ȋt iȿ nóť **ṗḙɽl** oṙ **rakʊ** ẏȣ ƍȩvȅŀơƥ in - ỿȣ ĉẚṅ
ṡūḃꭑĭƫ šôȴuʈīoňẛ įṋ ẉɥḯċʯḝʋḕr ʟaŋʉaĝe ꭅȣ ꬵꭂⱡ cőmḟởrṯaƀłꬳ ẁið.

Ȳȣ ɕañ ḟḭꬻḑ þe sȯḹȕțḭǫṋs ʯeɿe ốņ gɩʇḥùɓ ấţ:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-186/james-smith

# Task 1 - Zip List

***You are given two list `@a` and `@b` of same size. Create a subroutine `sub zip(@a, @b)` that merge the two list as shown in the example below.***

## Solution

This is a problem where perl signatures come into play. We use a signature so that we can
use arrays in call rather than references to arrays. The signature `(\@\@)` then converts
the arrays in the call into references.

### Solution 1 - Simple code:

Rather using a loop variable and select out of the two arrays
we loop through 1 and use a pointer to loop through the
other.

```perl
sub zip (\@\@) {
  my $c = 0;
  map { $_, $_[1][$c++] } @{$_[0]}
}
```

### Solution 2 - Using a pointer for both arrays:

This is the naive version where we have a counter and use it to index both arrays.

The plus is that it is a single line, no need for a variable.

```perl
sub zipt (\@\@) {
  map { $_[0][$_], $_[1][$_] } 0..@{$_[0]}-1;
}
```

### Solution 3 - Golfed code:

Now I couldn't go a week without putting in some golf code - which is slightly
off the wall! We loop through one array and shift off the other

As we are golfing we try and avoid new variables, we can therefore reuse/abuse `@_`
(if we are careful)... this is the reason for `local` which stops our changes
affecting the loop variable outside the function call.

Not only does using `@_` avoid using `my` when we loop through the array as we
`shift` off the first entry we can use the bare `shift` as it assumes that the
array is `@_`...

Finally we have to do `@{shift()}` as perl can't distinguish between this meaning
the variable `@shift` or `@{$_[-1]}`.

```perl
sub zipx (\@\@) {
  local($_,@_)=(shift,@{shift()});
  map{$_,shift}@$_
}
```

## Performance

With out original tests of up to 10 entries in the array we came up
with an ordering of `zip`, `zipt`, `zipx` as faster to slowest -
although with only about a 10-15% difference between all 3.

We then tried with a larger array (initially 1000) and sptted that
`zipx` is now the fastest, about 20% faster than `zip` and 50% faster
then `zipt`.

The break even point is around `35` entries in each array. So the
`zipx` is probably a better method to use as if the size is small
all are lightning fast - around 1 micro-second, but as the array
gets larger this gets around the millisecond - which could well be
more significant.

# Task 2 - Unicode Makeover

***You are given a string with possible unicode characters. Create a subroutine `sub makeover($str)` that replace the unicode characters with ascii equivalent. For this task, let us assume it only contains alphabets.***

## Solution

We could use packages/built in support for UTF-8. But where would be the fun in that... can we replicate this
in compact perl!

We first need to define a data structure where we can define the mapping between unicode symbol and plain latin ASCII character.
We could use a straight hash. But as the blocks of letters are in Unicode 'code blocks' we can use this to define the arrays
more efficiently.

`%blocks` is a hash whose key is the numeric value of the first character in the block `ord($ch)`.
the second is a series of letter substitutions for that block. If the value in array is `?` then we assume there is
no direct mapping.

```perl
%blocks = (
 192 => [qw(
          A A A A A A A C E E E E I I I I TH N O O O O O x O U U U U Y TH SS
          ...
          q ? ? dz ? dz ts ? tc ? ls lz ? ? h h)],
  7680 => [qw(
          A a B b B b B b C c D d D d D d D d D d E e E e E e E e E e F f
          ...
          O o O o U u U u U u U u U u U u U u Y y Y y Y y Y y LL ll V v Y y)],
  ...
  43824 => [qw(
          a ae e e e f g l l l m n n ? ? c oe oe ee co co y r r r r r r r s n n
          m m n x x x x x x x y ? ? ? ? ? lb ie ce uo a)],
}
```
Now note we allow "ligatures" & "diagraphs" in the array so there is a potential
for a 1-many mapping. (Diagraphs may be written as two letters, but sometimes the
letters are merged into a ligature, e.g. oe as in Phoenix; ss; ll in welsh ...)

And now `makeover` - this might be seen as nasty code! But we will explain below

```perl
sub makeover { join '', map { my $t = ord $_;
  ( grep( { $_ ne '?' }
      map { $t >= $_ && $t-$_ < @{$blocks{$_}}
          ? $blocks{$_}[$t-$_] : () }
      keys %blocks
    ), chr $t )[0]
} split //, shift }

```

```
    shift -> split -> map -> join
```

Remember with nested blocks we work backwards. The outer map is simple, we
split the parameter, and then process each character in turn, and join them
together. We split the string into chunks we assume it is a UTF-8 string, and
not a byte string, as the examples are the perl code - we can guarantee that
as we `use utf8`, for file/command line - we can use *e.g.*

```perl
binmode(STDIN, "encoding(UTF-8)");
```

There are similar was to ensure that database results are UTF-8

```
    keys -> map -> grep
```

Now for the inner loop - We loop through each block and see if the character
would be in that block - if it is we grab the mapped version of the character
- this is the `map` portion. This `map` returns at most one character.
We then `grep` out any `?` character

We then add the original symbol to the list... So the results of the outer
bracket will be an array with one or two values

    `[ mapped, original ]` or `[ original ]`.

So getting the zero-th element we have the mapped character if there is one or the original character if there isn't.

We know output is going to be UTF-8 ans we changed the *binmode*
of STDOUT to be UTF-8.

This is a bit messy and slow - so can we think of a different way of using our data structure:

### A simpler solution!!

Well we can convert the data structure into a hash... and see how the code works - this is an initial overhead
but each symbol is a lot quicker!

```perl
my %map = map {
  my $c = $_;
  map { $_ eq '?' ? ($c++,$_) : ($c++) x 0 }
  @{$blocks{$_}}
} keys %blocks;
```

This then gives us a `makeover` function of:

```perl
sub makeover { join '', map { $map{ord $_}//$_ } split //, shift }
```

### Some examples and performance...

Here are some examples....

```
                 ÃÊÍÒÙ! => AEIOU!
                  âÊíÒÙ => aEiOU
    Ƭȟȩ Ẇḕȅǩȴƴ Ćħąỻḝṅḡể => The Weekly Challenge
```

With these three examples the 2nd method is 4-5x faster than the previous method... Pre-computing is always the way to go,
if you have a complex function and not too much memory is required to store the mappings.

## Now lets go the other way...

This is interesting - but it was hard to write examples - so I thought why don't I go the other way and produce
the "decorated" code from the plain text - I find it weird calling it "`makeunder`" but as it is opposite over
`makeover` so be it. I think switching names would be more understandable.

Now there are two ways we can do this - we can either just use the single character mappings or we can look to see if we
can include the ligatures/digraphs.

We also add in a small random feature meaning we don't necessarily modify all characters...

### Getting the mapping

```perl
my @inv;
push @{$inv[length $map{$_}]{$map{$_}}},$_ for keys %map;
```

We have made this slightly more complex by splitting the mapping into two hashs - `$inv[1]` the mapping of characters and
`$inv[2]` the mapping of digraphs.

### First pass no ligatures

This one is relatively simple - lookup character in list - if is mappable map it - if not just copy it, and we use the
`join map split` mode...

```perl
sub makeunder_nolig {
  join '', map {
    $inv[1]{$_} && 0.8 > rand ? chr $inv[1]{$_}[rand @{$inv[1]{$_}}] : $_
  } split //,$_[0];
}
```

### Now with ligatures

```perl
sub makeunder {
  my $res = '';
  my @T = split //,$_[0];
  while(@T) {
    my $x = shift @T;
    $res .=
      @T && exists $inv[2]{$x.$T[0]} && 0.8 > rand
    ? chr($inv[2]{$x.$T[0]}[rand @{$inv[2]{$x.$T[0]}}]).(shift @T)x 0
    : exists $inv[1]{$x} && 0.8 > rand
    ? chr $inv[1]{$x}[rand @{$inv[1]{$x}}]
    : $x
  }
  $res;
}
```

We can't use the `join map split` model this time - as the `map` section is looking at one or two characters at a time.
So through the loop we first look for a ligature - if we have one we use that (OK - we might not with a random change).
If we don't we then try a single character, or if not fall through.

**Notes:** We use our favourite `x 0` trick to shift the 2nd character from a digraph, without it affecting the output...

Here is some output (this weeks challenges) you will already have seen some at the top of this document!

```
Ṫaṩḵ 1: Zįƥ Ḽiẛƭ
Ṧuɓṃïtŧȩƍ ḅꭅ: Ḿoḧǟmꭐaƌ Ṧ Ḁŉẁẳr
Ỵồŭ äɺɞ ɡɪʌȅṅ țẅồ ƚīṧẖ @à ãɴḓ @b ōf ṥąꬺⱻ ṥĩȥe.

Čʁeꭤťꬲ a ṧuɓꭆȣtȋñḛ ẜȕƃ ẕĩṗ(@ḁ, @ɓ) ðằṫ ṃềrĝe ðɚ ʈẇợ
łıẛƫ aṣ ẜhowṇ ɪn ðⱻ ềẋaꭑpɭȇ ḃʚꬸȯw.

Ṭẫꭍḳ 2: Ʊꬼıꭄȡɜ Ṁắƙẹȱỽėȓ
ſȗḇɯïţⱦɜȡ bʏ: Ṁổɦẩɰṃåḋ S Ấꬼwǡɾ
Ÿȣ äꭋe ǥiṿȩȵ ȃ śẖȑḭnĝ ẁịʇḧ ṕȱṣẝɨḇlé uņĩꭄdě ċȟắꭇäȼṱḕȓȿ.

Çɹḛaƭe ậ ẝửḃꭊôuṫiꭎḗ ṩṳƃ ɯắkeṓỽeꭆ($ṩẖꭋ) ðat rȩpḷāče ƫḣẹ
uꭎịʗɔdē cḫắɾȁḉțễꭈʂ ẁĭð aẜḉɨĭ ɘɋữǐṿaļėꭎť. Ƒỏꭊ ðis ṯꭤśk,
ḷeƭ ǘʂ aʂṣụɯȩ ḯŧ ȭṉḹꭅ ꭄṋʈấïṋș alṕẗǎƀeʦ.
```
