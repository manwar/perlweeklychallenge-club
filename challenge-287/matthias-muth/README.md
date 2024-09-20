# About Passwords, Birds, and Common Regexes

**Challenge 287 solutions in Perl by Matthias Muth**

## Task 1: Strong Password

> You are given a string, $str.<br/>
> Write a program to return the minimum number of steps required to make the given string very strong password. If it is already strong then return 0.<br/>
> Criteria:<br/>
> - It must have at least 6 characters.<br/>
> - It must contains at least one lowercase letter, at least one upper case letter and at least one digit.<br/>
> - It shouldn't contain 3 repeating characters in a row.<br/>
> 
> Following can be considered as one step:<br/>
> - Insert one character<br/>
> - Delete one character<br/>
> - Replace one character with another<br/>
> 
> Example 1<br/>
> Input: \$str = "a"<br/>
> Output: 5<br/>
> <br/>
> Example 2<br/>
> Input: \$str = "aB2"<br/>
> Output: 3<br/>
> <br/>
> Example 3<br/>
> Input: \$str = "PaaSW0rd"<br/>
> Output: 0<br/>
> <br/>
> Example 4<br/>
> Input: \$str = "Paaasw0rd"<br/>
> Output: 1<br/>
> <br/>
> Example 5<br/>
> Input: \$str = "aaaaa"<br/>
> Output: 3<br/>

#### Dealing with short passwords

If the password is too short, there is no other way than inserting characters up to the required length.

Example 2 is a test case for this:<br/>
    `aB2` => 3 (like insert `X`, `Y`, `Z` to get `aB1XYZ` )<br/>
but also:<br/>
    `""` => 6 (like `aB1cde`).

#### Dealing with missing categories

For every category (digits, upper case or lower case letters) that we don't find, we can choose to *insert* a new character or to *replace* an existing one.

We will see later that both operations have their use, in different cases.

We can use some extra test cases for this:<br/>
    `abcABC` => 1 (e.g. *insert* `1` to get `abcABC1`, or *replace* `b` by `1` to get `a1cABC`)<br/>
    `abcdef` => 2 (e.g. *insert* `1` and `A` to get `abcdef1A`, or *replace* `b` by `1` and `c` by `A` to get `a1Adef`)<br/>

#### Dealing with repeating characters (like 'aaaaa')

The third criteria says that the password '*shouldn't contain 3 repeating characters in a row*'.<br/>
If we find a sequence that is longer, there are three ways to modify it to comply with the rule:

* *Insert* a different character into the sequence after every second character.<br/>
  This will split the sequence into chunks of two, separated by the new characters:<br/>
    `aaaaaa => aaiaaiaa` (2 *insert*s for a sequence of 6)<br/>
    `aaaaaaaaa => aaiaaiaaiaaia` (**4 *inserts*** for a sequence of 9)<br/>
* *Replace* every third character by a different one.<br/>
  This also splits it into chunks of 2, but it is more efficient.
  Each replaced character 'consumes' one character of the sequence and thus reduces the amount of work still left to do:<br/>
      `aaaaaa => aaraar`  (2 replacements for a sequence of 6)<br/>
      `aaaaaaaaa => aaraaraar` (**3 *replacements*** for a sequence of 9)<br/>

* *Delete* all characters in excess of the first 2.<br/>
    Deleting characters is a dangerous thing, and it is inefficient:<br/>
    Dangerous, because it also reduces the overall length of the password,
    and in the end we might be violating the 'at least 6 characters' criteria.<br/>
    Inefficient, because each *deletion* only takes care of exactly one excess character,
    whereas at the same time, *replacing* one character at the right spot 'neutralizes' three of them:<br/>
        `aaaaaa => aa`  (4 *deletions* for a sequence of 6)<br/>
        `aaaaaaaaa => aa` (**7 *deletions*** for a sequence of 9)<br/>
    So we better do not consider 'delete' operations at all.

Some more examples:

| sequence length | example sequence | *insert* result     | *replace* result | *insert* operations needed | *replace* operations needed |
| :-------------: | :--------------- | :------------------ | :--------------- | :------------------------: | :-------------------------: |
|        6        | `aaaaaa`         | `aabaabaa`          | `aabaab`         |             2              |              2              |
|        7        | `aaaaaaa`        | `aabaabaaba`        | `aabaaba`        |             3              |            **2**            |
|        9        | `aaaaaaaaa`      | `aabaabaabaaba`     | `aabaabaab`      |             4              |            **3**            |
|       12        | `aaaaaaaaaaaa`   | `aabaabaabaabaabaa` | `aaXaaXaaXaaX`   |             5              |            **4**            |

These examples show that for dealing with longer sequences, *replacing* characters is more efficient than *inserting* characters.<br/>
This leads us to some more test cases:<br/>
    `aaa1B` => 1 (e.g. *replacing* one `a` by `b` to get `aab1B`)<br/>    `aaaa1B` => 1 (e.g. *replacing* one `a` by `b` to get `aaba1B`)<br/>    `aaaaa1B` => 1 (e.g. *replacing* one `a` by `b` to get `aabaa1B`)<br/>    `aaaaaa1B` => 2 (e.g. *replacing* 2 times `a` by `b` to get `aabaab1B`)<br/>    `aaaaaaa1B` => 2 (e.g. *replacing* 2 times `a` by `b` to get `aabaaba1B`)<br/>    `aaaaaaaa1B` => 2 (e.g. *replacing* 2 times `a` by `b` to get `aabaabaa1B`)<br/>
    `aaaaaaaaaaaa1B` => 4 (e.g. *replacing* 4 times `a` by `b` to get `aabaabaabaab1B`)

#### Up to three birds with one shot!

It turns out that if we are lucky, by *inserting* one character we can solve three problems at the same time:

* make the password longer,
* add a missing category by choosing the character to be from that category,
* shorten a long repeated-character sequence by inserting the character to split off two characters of the sequence.

In this example, one operation solves all three shortcomings, which makes it another good test case:<br/>
`aaaBc` => 1 (e.g. by *inserting * one digit at the right place, like `aa1aBc`).<br/>

#### And another two birds with another shot...

Similarly, we also can solve *two* problems at the same time by *replacing* one character:

* add a missing category by choosing the character to be from that category,
* shorten a long repeating character sequence by choosing a 'third' character to be replaced, which will 'neutralize' the two characters preceding it.

For example (and yet another test case):<br/>
    `aaaabC` => `aa1aabC` => 1 change only for solving two shortcomings.


#### Solution structure

For our solution this means that we can proceed as follows:

1. We determine how many *inserts* are needed
    for reaching the **minimum password length**.<br/>
    Every *insert* is counted as a cost for our final result
    (the number of operations needed).<br/>
    In addition, we keep a separate counter for the inserted characters,
    which we will decrement when we use them 'for more birds'
    (to add categories or to split up long sequences).

2. For each **missing category**,
    we first use one of the characters inserted in step 1
    for adding that category.<br/>
    This causes *no additional cost*,
    as long as we have any of those characters left.

3. If we *still* are missing categories,
    we *replace* existing characters of another category
    by a character of the respective missing category.<br/>
    Every character to be replaced is counted as a cost.<br/>
    We don't care to choose *which* characters to be replaced here,
    because we might choose good positions later,
    when we try to split long repeating sequences.<br/>
    For this, we also keep another counter for the replaced characters.<br/>
    The reason why we prefer replacing to inserting here is that later on,
    *replaced* characters might serve better than *inserted* ones.

4. For every **long repeating character sequence** that we find,
    we do this:

    Position any *replacement* characters from the previous step
    on every third character of the sequence,
    each one 'neutralizing' *three* characters of the repetition,
    until we have used all the *replacement* characters, or the sequence is fully neutralized.<br/>
    There's *no additional cost* for this.

    If there are no *replaced* characters available any more,
    position any *inserted* characters from step 1
    after every second character of the sequence,
    neutralizing two characters of the sequence.<br/>
    Even if using the *inserted* characters is less efficient than using replacements, these here come for free, because we've paid for them already. Now they can be used with *no additional cost*.

    For the rest of the sequence,
    we *replace* every third characters within the sequence to split it up further.<br/>
    These replacements count for the cost, though.

5. We return the cost that we have determined.

Here are some more 'combination' test cases:<br/>

    `aaaacccc` => 2 (like `aa1accBc)
         (replacing one `a` by a digit,<br/>
         and one `c` by an upper case character.<br/>
         and two `b`s by anything else but a `b`).<br/>
    `aaaaaabbbbbb` => 4 (like `aa1aaXbbYbbY`),<br/>
         (replacing one `a` by a digit,<br/>
         another `a` by  an upper case character,<br/>
         and two `b`s by anything else but a `b`).<br/>
    `aaacc` => 2 (e.g. `aa1ccX`).<br/>

And this is my solution:

```perl
use v5.36;

use List::Util qw( sum min );

use constant MIN_PASSWORD_LENGTH => 6;

sub strong_password( $str ) {
    # Make pattern matches easier to write.
    $_ = $str;

    my ( $cost, $available_inserted, $available_replaced ) = ( 0, 0, 0 );

    # 1: Do *inserts* for bringing the password up to length.
    if ( length() < MIN_PASSWORD_LENGTH ) {
        $available_inserted = MIN_PASSWORD_LENGTH - length();
        $cost += $available_inserted;
    }

    # 2: Use the inserted characters to add missing categories
    #    (*no additional cost!*),
    my $n_missing_categories = sum( ! /\d/, ! /[a-z]/, ! /[A-Z]/ );
    if ( $n_missing_categories && $available_inserted ) {
        my $n_to_use = min( $n_missing_categories, $available_inserted );
        $n_missing_categories -= $n_to_use;
    }

    # 3: If there still are categories missing,
    #    we *replace* existing characters.
    if ( $n_missing_categories ) {
        $available_replaced = $n_missing_categories;
        $cost += $available_replaced;
    }

    # 4: Deal with long repeating sequences (3 or more same characters).
    while ( /(.)\1\1\1*/g ) {
        my $sequence_length = length( $& );
        while ( $sequence_length > 2 && $available_replaced ) {
            $sequence_length -= 3;
            --$available_replaced;
        }
        while ( $sequence_length > 2 && $available_inserted ) {
            $sequence_length -= 2;
            --$available_inserted;
        }
        while ( $sequence_length > 2 ) {
            $sequence_length -= 3;
            ++$cost;
        }
    }
    return $cost;
}
```

The `ch-1.pl` file also contains switchable debugging output, and all the test cases. This is its output:

```terminal
ok 1 - Example 1: strong_password( "a" ) == 5
ok 2 - Example 2: strong_password( "aB2" ) == 3
ok 3 - Example 3: strong_password( "PaaSW0rd" ) == 0
ok 4 - Example 4: strong_password( "Paaasw0rd" ) == 1
ok 5 - Example 5: strong_password( "aaaaa" ) == 2 (like "aa1aaB")
ok 6 - Extra 1: strong_password( "" ) == 6 (like "1aBcde")
ok 7 - Extra 2: strong_password( "abcABC" ) == 1 (like "a1cABC")
ok 8 - Extra 3: strong_password( "abcdef" ) == 2 (like "a1Adef")
ok 9 - Extra 4: strong_password( "aaa1B" ) == 1 (like "aab1B")
ok 10 - Extra 5: strong_password( "aaaa1B" ) == 1 (like "aaba1B")
ok 11 - Extra 6: strong_password( "aaaaa1B" ) == 1 (like "aabaa1B")
ok 12 - Extra 7: strong_password( "aaaaaa1B" ) == 2 (like "aabaab1B")
ok 13 - Extra 8: strong_password( "aaaaaaa1B" ) == 2 (like "aabaaba1B")
ok 14 - Extra 9: strong_password( "aaaaaaaa1B" ) == 2 (like "aabaabaa1B")
ok 15 - Extra 10: strong_password( "aaaaaaaaaaaa1B" ) == 4 (like "aabaabaabaab1B")
ok 16 - Extra 11: strong_password( "aaaBc" ) == 1 (like "aa1aBc")
ok 17 - Extra 12: strong_password( "aaaabC" ) == 1 (like "aa1aabC")
ok 18 - Extra 13: strong_password( "aaaacccc" ) == 2 (like "aa1accBc")
ok 19 - Extra 14: strong_password( "aaaaaabbbbbb" ) == 4 (like "aa1aaXbbYbbY")
ok 20 - Extra 15: strong_password( "aaacc" ) == 2 (like "aa1ccX")
1..20
```

It has never been easier to create good passwords! :wink::joy:



## Task 2: Valid Number

> You are given a string, $str.<br/>
> Write a script to find if it is a valid number.<br/>
> Conditions for a valid number:<br/>
>
> - An integer number followed by an optional exponent.<br/>
> - A decimal number followed by an optional exponent.<br/>
> - An integer number is defined with an optional sign '-' or '+' followed by digits.<br/>
> <br/>
> Decimal Number:<br/>
> A decimal number is defined with an optional sign '-' or '+' followed by one of the following definitions:<br/>
> - Digits followed by a dot '.'.<br/>
> - Digits followed by a dot '.' followed by digits.<br/>
> - A dot '.' followed by digits.<br/>
> <br/>
> Exponent:<br/>
> An exponent is defined with an exponent notation 'e' or 'E' followed by an integer number.<br/>
> <br/>
> <br/>
> Example 1<br/>
> Input: $str = "1"<br/>
> Output: true<br/>
> <br/>
> Example 2<br/>
> Input: $str = "a"<br/>
> Output: false<br/>
> <br/>
> Example 3<br/>
> Input: $str = "."<br/>
> Output: false<br/>
> <br/>
> Example 4<br/>
> Input: $str = "1.2e4.2"<br/>
> Output: false<br/>
> <br/>
> Example 5<br/>
> Input: $str = "-1."<br/>
> Output: true<br/>
> <br/>
> Example 6<br/>
> Input: $str = "+1E-8"<br/>
> Output: true<br/>
> <br/>
> Example 7<br/>
> Input: $str = ".44"<br/>
> Output: true<br/>

Probably the easiest way to solve this is to use the `Regexp::Common` CPAN module:

```perl
use v5.36;

use Regexp::Common;

sub valid_number( $str ) {
    return $str =~ /^$RE{num}{real}$/;
}
```
This works well for all examples.

If you don't want to use a module, this regular expression might be used instead:
```perl
use v5.36;

sub valid_number( $str ) {
    return
        $str =~ /^ [+-]? (?: \.\d+ | \d+(?:\.\d*)? ) (?: [Ee] [+-]? \d+ )? $/xa;
}
```

Nothing really special about it, except maybe the `a` modifier, which is used to make sure that no other Unicode characters with a 'digit' property match `\d`. Basically this makes `\d` equivalent to `[0-9]`, which is the safer most of the time.

#### **Thank you for the challenge!**
