# The Mxamium Jmubled Wkeely Chllaegne

**Challenge 289 solutions in Perl by Matthias Muth**

## Task 1: Third Maximum

> You are given an array of integers, @ints.
>
> Write a script to find the third distinct maximum in the given array. If third maximum doesn’t exist then return the maximum number.
>
> Example 1<br/>
> Input: @ints = (5, 6, 4, 1)<br/>
> Output: 4<br/>
> The first distinct maximum is 6.<br/>
> The second distinct maximum is 5.<br/>
> The third distinct maximum is 4.
>
> Example 2<br/>
> Input: @ints = (4, 5)<br/>
> Output: 5<br/>
> In the given array, the third maximum doesn't exist therefore returns the maximum.
>
>
> Example 3<br/>
> Input: @ints =  (1, 2, 2, 3)<br/>
> Output: 1<br/>
> The first distinct maximum is 3.<br/>
> The second distinct maximum is 2.<br/>
> The third distinct maximum is 1.

This is an easy one:

We need to sort the array so that the maximum is in the front:

```perl
    sort { $b <=> $a } @ints
```

For getting the *distinct* maximum,
we use `uniq` from `List::Util` to eliminate double entries:

```perl
    uniq sort { $b <=> $a } @ints
```

Actually, it's better to reduce the number of elements *before* sorting,
so that `sort` has less work to do:

```perl
    my @sorted_uniq = sort { $b <=> $a } uniq @ints;
```

Then we return the third element of that sorted list of unique maximums.<br/>
Perl makes it easy in that we don't need to check its existence first,
but we will get an `undef` value if it doesn't  exist.<br/>
And together with the 'defined or' operator,
returning the result is simple, too:

```perl
    return $sorted_uniq[2] // $sorted_uniq[0];
```

So all put together:

```perl
use v5.36;

use List::Util qw( uniq );

sub third_maximum( @ints ) {
    my @sorted_uniq = sort { $b <=> $a } uniq @ints;
    return $sorted_uniq[2] // $sorted_uniq[0];
}
```



## Task 2: Jumbled Letters

> An Internet legend dating back to at least 2001 goes something like this:<br/>
>
> Aoccdrnig to a rscheearch at Cmabrigde Uinervtisy, it deosn’t mttaer in waht oredr the ltteers in a wrod are, the olny iprmoetnt tihng is taht the frist and lsat ltteer be at the rghit pclae. The rset can be a toatl mses and you can sitll raed it wouthit porbelm. Tihs is bcuseae the huamn mnid deos not raed ervey lteter by istlef, but the wrod as a wlohe.
>
> This supposed Cambridge research is unfortunately an urban legend. However, the effect has been studied. For example—and with a title that probably made the journal’s editor a little nervous—Raeding wrods with jubmled lettres: there is a cost by Rayner, White, et. al. looked at reading speed and comprehension of jumbled text.
>
> Your task is to write a program that takes English text as its input and outputs a jumbled version as follows:
>
> 1. The first and last letter of every word must stay the same
> 2. The remaining letters in the word are scrambled in a random order (if that happens to be the original order, that is OK).
> 3. Whitespace, punctuation, and capitalization must stay the same
> 4. The order of words does not change, only the letters inside the word
>
> So, for example, “Perl” could become “Prel”, or stay as “Perl,” but it could not become “Pelr” or “lreP”.
>
> I don’t know if this effect has been studied in other languages besides English, but please consider sharing your results if you try!

#### Let's jumble!

I decided to use a very straightforward technique for 'jumbling' a string of characters,
that is easy to implement in Perl.
It works by randomly selecting a character from the input string,
removing it from there and adding it to the output string.
This is repeated until no characters remain.
I find it easiest to use an array for all the operations.

```perl
sub jumble_string( $str ) {
    my @chars = split "", $str;
    return join "", map { splice @chars, rand( @chars ), 1, () } 0..$#chars;
}
```

What this does in detail:

- `my @chars = split "", $str;`<br/>
splits up the string into an array of characters.
- `map {...} 0..$#chars`<br/>
executes the `{...}` code block as many times as we have characters in `@char`.
- Within the code block,<br/>
`rand( @chars )`<br/>
randomly chooses an index from the list.
It returns a floating point number,
but using it as an array index, implicitly, only the integer part will be used.
- Then,<br/>
`splice @chars, rand( @chars ), 1, ()`<br/>
returns that random entry from the array,
at the same time replacing it with the empty list `()`,
thus deleting it from the array.<br/>
- Eventually,<br/>
`return join "", ...;`<br/>
combines the extracted random characters into a string, and returns that now 'jumbled' string.

#### Applying the Jumble

The next thing is to apply the 'jumbling' to only the inner part of the words found in the input text.
Not a big problem with Perl regular expressions &mdash;
a global substitution with an evaluated expression as a replacement does the job:

```perl
sub jumbled_letters( $str ) {
    return $str =~ s{
            (?<=[A-Za-z]) [a-z]+ (?=[a-z])
        }{
            jumble_string( $& )
        }xegr;
}
```

The first and last characters of a word are matched by a lookbehind and a lookahead, respectively,
so that the matched string will be the inner part only.<br/>
There is the `x` flag for better readability,
the `e` flag for using the substitution part as an evaluated expression,
the `g` flag for doing the substitution as many times as possible,
and the `r` flag for returning the result of the substitution
instead of changing the `$str` variable itself.

#### Testing the Random

In this task, we don't have any examples containing expected results for a given input,
which most other Weekly Challenge tasks have.
In addition, the output is supposed to be produced using random changes to the input,
so we cannot rely on any repeatability when we run the program several times.

But I found that there are at least two criteria that we *can* test:

- *The output is expected to be different from the input.*<br/>
Ok, there's this case where we 'randomly' produce output that is exactly the same as the input.
But the probability for getting this reminds me of the story of the monkey hitting random keys
on a typewriter who will eventually produce the complete works of William Shakespeare,
if he types long enough...<br/>
So let's at least assume that if our implementation is correct,
there will be a (very) high probability that the output will differ from the input.
- *All words of the input text contain the same characters as the words in the output text.*<br/>
This should help us to verify that the output is not just a *completely* random text,
but has the same structure as the input.       

So we have at least two test cases that we can implement.<br/>
Using `Test2::V0` (which I cannot help repeating that it is now a core module!),
the first test is easy:

```perl
my $input_text = <<EOF;
According to a researchch at Cambridge University, it doesn’t matter in what
order the letters in a word are, the only importent thing is that the first and
last letter be at the right place.
The rest can be a total mess and you can still read it without problem.
This is because the human mind does not read every letter by itself,
but the word as a whole.
EOF

my $jumbled = jumbled_letters( $input_text );

ok $jumbled ne $input_text,
    "Jumbled text and original text differ";
```

For the second test, we need to put in a little more effort.<br/>
To compare whether the *inner* of all words of the input and output texts
contain the same characters, I implemented a 'normalization' function.
It works very similar to the `jumble_letters` function itself,
but instead of jumbling the inner characters, it *sorts* them.
If we compare the input and output texts both 'normalized' in that way,
they have to be the same!
It's like completely 'un-jumbling' both, before comparing them.

So we can add this for the second test case:

```perl
sub normalize( $str ) {
    return $str =~ s{
            (?<=[A-Za-z]) [a-z]+ (?=[a-z])
        }{
            join( "", sort split "", $& );
        }xegr;
}

is normalize( $jumbled ), normalize( $input_text ),
    "Normalized jumbled text and normalized original text are equal";

done_testing;
```

Whatever implementation of 'jumbling' you have,
it should produce at least the following testing output:

```text
ok 1 - Jumbled text and original text differ
ok 2 - Normalized jumbled text and normalized original text are equal
1..2
```

#### Readability?

Concerning the readability of the jumbled text,
I personally find that
as long as there are only some character pairs that are flipped
(in addition to keeping the first and last letter the same),
it's quite ok.<br/>
But as soon as the letters move further away from their original positions,
as it is easily the case with the 'jumbling' implemented here,
readability goes down a lot.<br/>
The typical output produced by my jumbling looks much more difficult to read
than the famous original jumbled text:

```text
Acdinrocg to a reeacshcrh at Camrgbdie Usirvtiney, it doesn’t mttear in what
oderr the leretts in a wrod are, the only iormptent thnig is that the fsrit and
last leettr be at the rgiht palce.
```

Maybe it would be interesting to only *flip* pairs of characters at some random positions,
not modifying  the same character twice,
and not moving characters too far away from their original position.

Actually I think that this is the way that the original jumbled text was produced:
in general only flipping characters,
maybe with some extra rules for repeated characters (like in 'l(tt/e)ers')
or for some other fixed letter combinations (like 'w(out/hi)t').<br/>
Maybe there also was a bit of 'cheating',
at least being selective for jumbled words not looking too strange.

Checking the difference in readability for different 'jumbling' algorithms
seems like a real research topic.<br/>
It's a pity that that is more than can be done within a Weekly Challenge. :-)

#### **Thank you for the challenge!**
