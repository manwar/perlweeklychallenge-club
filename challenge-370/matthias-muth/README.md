# Good Tags and Good Chunks

**Challenge 369 solutions in Perl by Matthias Muth**

## Task 1: Valid Tag

> You are given a given a string caption for a video.<br/>
> Write a script to generate tag for the given string caption in three steps as mentioned below:<br/>
> 1. Format as camelCase<br/>
> Starting with a lower-case letter and capitalising the first letter of each subsequent word.<br/>
> Merge all words in the caption into a single string starting with a #.<br/>
> 2. Sanitise the String<br/>
> Strip out all characters that are not English letters (a-z or A-Z).<br/>
> 3. Enforce Length<br/>
> If the resulting string exceeds 100 characters, truncate it so it is<br/>
> exactly 100 characters long.
>
> **Example 1**
>
> ```text
> Input: $caption = "Cooking with 5 ingredients!"
> Output: "#cookingWithIngredients"
> ```
>
> **Example 2**
>
> ```text
> Input: $caption = "the-last-of-the-mohicans"
> Output: "#thelastofthemohicans"
> ```
>
> **Example 3**
>
> ```text
> Input: $caption = "  extra spaces here"
> Output: "#extraSpacesHere"
> ```
>
> **Example 4**
>
> ```text
> Input: $caption = "iPhone 15 Pro Max Review"
> Output: "#iphoneProMaxReview"
> ```
>
> **Example 5**
>
> ```text
> Input: $caption = "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!"
> Output: "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn"
> ```

### Think international: Not every tag is based on English

For tags that are based on phrases in foreign languages,
I don't find it sufficient to simply remove all non-ASCII letters,
because there may be language-specific characters
that are esssential to the meaning.

Consider this caption in French as an example: 

> Élégance à Noël : Où déguster des pâtés, bœufs rôtis et crèmes brûlées à l’ancienne ?

Blindly removing all non-ASCII characters would result in this tag, which doesn't make any sense to the reader:

> `#lganceNolODgusterDesPtsBufsRtisEtCrmesBrlesLancienne`

The `Text::Unidecode` module contains a `unidecode` function
that does a plain ASCII transliteration of Unicode texts.
For example, `unidecode( "The α and ω" )`
results in `"The a and o"`,
and the tag for the French caption above then becomes much mode useful:

> `#eleganceANoelOuDegusterDesPatesBoeufsRotisEtCremesBruleesALancienne`

### My One-Statement (but multi-line) solution

I constructed a one-liner (or, to be exact: a one-statement solution).<br/>
Here it is:

```perl
use v5.36;
use utf8::all;
use Text::Unidecode;

sub valid_tag( $caption ) {
    return substr(
        "#" . lcfirst( join "",
            map ucfirst,
                split " ",
                    lc unidecode( $caption ) =~ s/[^[:alpha:]\s]//igr ),
        0, 100 );
}
```

### I'd better be able to understand what I wrote

If you have a little difficulty to understand what it does,
don't worry, it also happened to me
when I came back to it after three days.

The problem is that it's a mix of a non-trivial pipeline
and a subroutine call
with the final parameters located far away
from the subroutine name itself,
which is not easy to grasp visually.
Then it also switches back and forth between different data types:
a string, a list of words, and then a string again.

There's no way that I could call that 'easy to maintain'.

So I tried again:

```perl
use v5.36;
use utf8::all;
use Text::Unidecode;

sub valid_tag( $caption ) {
    # Convert all non-ASCII UNICODE characters into an ASCII transliteration.
    $caption = unidecode( $caption );

    # Remove everything that is not a letter or whitespace.
    $caption =~ s/[^[:alpha:]\s]//ig;

    # Transform the whole string into lower case,
    # then split into words on any sequence of whitespace.
    # Uppercase the first letter of each word.
    my @words = map ucfirst, split " ", lc $caption;

    # Combine the words into a hash tag,
    # lowercasing the first letter of the result.
    my $hash_tag = "#" . lcfirst join "", @words;

    # Return the first 100 characters.
    return substr( $hash_tag, 0, 100 );
}
```

This looks more structured, more readable and more maintainable to me,
with the comments hopefully providing enough explanation
of what is happening.

## Task 2: Group Division

> You are given a string, group size and filler character.<br/>
> Write a script to divide the string into groups of given size. In the last group if the string doesn’t have enough characters remaining fill with the given filler character.
>
> **Example 1**
>
> ```text
> Input: $str = "RakuPerl", $size = 4, $filler = "*"
> Output: ("Raku", "Perl")
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "Python", $size = 5, $filler = "0"
> Output: ("Pytho", "n0000")
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "12345", $size = 3, $filler = "x"
> Output: ("123", "45x")
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "HelloWorld", $size = 3, $filler = "_"
> Output: ("Hel", "loW", "orl", "d__")
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "AI", $size = 5, $filler = "!"
> Output: "AI!!!"
> ```

For this task, too, I wrote a one-line solution, but it is much less complex. It consists of two operations only:

* Add `( $size - 1 )` filler characters to `$str`.

  To illustrate the effect that this has, consider the following examples, all using `$size = 4` and `$filler = "F"`.

  > `$str = "1234"    `   fillers appended: `"1234FFF"    `  chunks: **`1234`** *`FFF`*
  >
  > `$str = "12345"   `   fillers appended: `"12345FFF"   `  chunks: **`1234` `5FFF`**
  >
  > `$str = "123456"  `   fillers appended: `"123456FFF"  `  chunks: **`1234` `56FF`** *`F`*
  >
  > `$str = "1234567" `   fillers appended: `"1234567FFF" `  chunks: **`1234` `567F`** *`FF`*
  >
  > `$str = "12345678"`   fillers appended: `"12345678FFF"`  chunks: **`1234` `5678`** *`FFF`*

  Note that returning all *complete* chunks of `$size` characters
  (highlighted in **bold** in these examples)
  delivers the correct result for this task.

* For splitting up that extended string into chunks of  `$size` characters,
  I use a regular expression.
  Using `$size` as a quantifier does the trick,
  and the `/g` *global* flag makes it work repetitively,
  returning the list of all matches found:

  ```perl
      /.{$size}/g
  ```

This time I don't see any need for restructuring it, so here is a real one-liner:

```perl
use v5.36;

sub group_division( $str, $size, $filler ) {
    return ( $str . $filler x ( $size - 1 ) ) =~ /.{$size}/g;
}
```

#### **Thank you for the challenge!**
