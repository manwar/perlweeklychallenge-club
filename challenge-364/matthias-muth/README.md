# I Don't Lie, Sheriff!

**Challenge 363 solutions in Perl by Matthias Muth**

## Task 1: String Lie Detector

> You are given a string.<br/>
> Write a script that parses a self-referential string and determines whether its claims about itself are true. The string will make statements about its own composition, specifically the number of vowels and consonants it contains.
>
> **Example 1**
>
> ```text
> Input: $str = "aa — two vowels and zero consonants"
> Output: true
> ```
>
> **Example 2**
>
> ```text
> Input: $str = "iv — one vowel and one consonant"
> Output: true
> ```
>
> **Example 3**
>
> ```text
> Input: $str = "hello - three vowels and two consonants"
> Output: false
> ```
>
> **Example 4**
>
> ```text
> Input: $str = "aeiou — five vowels and zero consonants"
> Output: true
> ```
>
> **Example 5**
>
> ```text
> Input: $str = "aei — three vowels and zero consonants"
> Output: false
> ```

To make the task more interesting,
I would like to be a bit generous regarding the input format.<br/>
My solution shall accept these inputs:

```text
    "hello - three vowels and two consonants"     # (standard form)
    "aei - three vowels"                          # (no mention of consonants)
    "xyz - three consonants"                      # (no mention of vowels)
    "ab  - one vowel, one consonant"              # (comma)
    "bb  - no vowels, two consonants"             # (using 'no' instead of 'zero')
    "xa  - one consonant and one vowel"           # (reversed order)
    "abe - one vowel, one consonant, one vowel"   # (multiple entries, to be summed up)
```

The first step is to separate the string itself
from the statement about the string.

It seems to be a sort of a convention
that there is a separator character between the two:<br/>
A minus sign in some examples,
or a dash (Unicode U+2014 EM-DASH) in some others.

In any case, this separator character is a 'non-word' character,
so we could use `/\W/` as a regex for the separator.
But this would also split on the first whitespace character,
because a whitespace character is a 'non-word' character, too.
I would like to be a bit more generous about the format of the string,
allowing embedded space characters, for example, like in<br/>
`"abc def - two vowels and four consonants"`.

So I choose the separator to be the first
'non-whitespace, non-word' character:
`/[^\w\s]/`.<br/>
Actually the whitespace surrounding the separator can be removed, too:
`/\s*[^\w\s]\s*/`.

What happens when there are *longer sequences*
of whitespace characters before the separator is this:   

```text
"abc     def - two vowels and four consonants"
    ^^^^^ <=== Recognized sequence of whitespace characters for the \s* sequence.
         ^ <=== Oh, not the expected separator.
    ^^^^ <=== Trying again after a shorter whitespace sequence ...
        ^ <=== Of course, no separator here, either.
    ^^^ <=== Trying again ...
       ^ <=== *We* know it, but the regex engine doesn't.
```

This can be avoided by scanning the whitespace 'possessively',
using `/\s*+/` instead of `/\s*/`.
Once there is no separator after the whitespace,
no backtracking retries with shorter `/\s*/` sequences are done.

So eventually, the separator regex is this one:
`/\s*+[^\w\s]\s*/`.

I use `split` to extract the statement, leaving the string to be examined in `$str`.
I tell `split` explicitly to split into two parts *only*,
in order not to lose anything that could come after a second separator character.

```perl
    ( $str, $statement ) = split /\s*+[^\s\w]\s*+/, $str, 2;
```

The next step is to extract the numbers from the statement,
and as they are given as English words,
to translate them to actual numbers.

For the translation part,
I rely on the `Lingua::EN::Words2Nums` CPAN module,
calling `words2nums` with the extracted English number words.

As multiple entries should be possible, I use two loops,
one each for adding up the number of vocals and of consonants,
respectively.
Each loop is driven by a `/g` *global* pattern match,
capturing the number word in `$1`.

If the number recognition using `words2nums` fails,
the number word is checked for the word 'no',
and a zero is returned in that case.
If that check fails, too, the subroutine exits, returning a `false` value.

```perl
my ( $expected_vowels, $expected_consonants ) = ( 0, 0 );
$expected_vowels +=
    words2nums( $1 ) // ( $1 =~ /^no$/i ? 0 : return false )
    while $statement =~ /(\w+)\s+vowels?/ig;
$expected_consonants +=
    words2nums( $1 ) // ( $1 =~ /^no$/i ? 0 : return false )
    while $statement =~ /(\w+)\s+consonants?/ig;
```

The last step is to really count the number of vowels
and consonants in the string.
Again, a pattern match using the `/g` *global* flag can do that,
returning all the occurrences of vowels or consonants.

Recognizing vowels (in English) is easy:  `[aeiou]`.<br/>
For consonants, we have to recognize a letter (`[a-z]`)
that is *not* a vowel (`[^aeiou]`).<br/>
A lookahead probably is the easiest way to do that:
`/(?=[^aeiou])([a-z])/`.

Counting the occurrences needs a trick, though:

We cannot just use a scalar context to get the number of entries
as we would do with `grep` for example,
or for counting the entries in a real array.
Instead, we use what is called the 'Saturn' operator.
It uses the fact that when the `=` assignment operator does
a list assignment in scalar context,
it returns the number of elements in the list,
no matter how many of the list elements were actually assigned.
That can be used to assign the list to an empty list of variables,
and then assign the result of that assignment
(the number of list elements)
to a scalar variable.<br/>
For this solution, it looks like this:

```perl
    my $vowels     = () = $str =~ /([aeiou])/ig;
    my $consonants = () = $str =~ /(?=[^aeiou])([a-z])/ig; 
```

Now that everything is in place, returning the result is easy:

```perl
    return $vowels == $expected_vowels && $consonants == $expected_consonants;
```

My whole solution is this, then:

```perl
use v5.36;
use builtin qw( true false );
use Lingua::EN::Words2Nums;

sub string_lie_detector( $str ) {
    # Separate the statement from the string, using any
    # non-whitespace, non-word character (typically a '-') as the separator.
    # Remove whitespace around that separator while we're at it.
    ( $str, my $statement ) = split /\s*+[^\s\w]\s*+/, $str, 2;
    
    # Sum up the respective numbers mentioned in the statement.
    my ( $expected_vowels, $expected_consonants ) = ( 0, 0 );
    $expected_vowels +=
        words2nums( $1 ) // ( $1 =~ /^no$/i ? 0 : return false )
        while $statement =~ /(\w+)\s+vowels?/ig;
    $expected_consonants +=
        words2nums( $1 ) // ( $1 =~ /^no$/i ? 0 : return false )
        while $statement =~ /(\w+)\s+consonants?/ig;
    
    # Count the actual numbers of vowels and consonants.
    my $vowels     = () = $str =~ /([aeiou])/ig;
    my $consonants = () = $str =~ /(?=[a-z])([^aeiou])/ig;
    
    return $vowels == $expected_vowels && $consonants == $expected_consonants;
}
```

## Task 2: Subnet Sheriff

> You are given an IPv4 address and an IPv4 network (in CIDR format).<br/>
> Write a script to determine whether both are valid and the address falls within the network. For more information see the Wikipedia article.
>
> **Example 1**
>
> ```text
> Input: $ip_addr = "192.168.1.45"
>        $domain  = "192.168.1.0/24"
> Output: true
> ```
>
> **Example 2**
>
> ```text
> Input: $ip_addr = "10.0.0.256"
>        $domain  = "10.0.0.0/24"
> Output: false
> ```
>
> **Example 3**
>
> ```text
> Input: $ip_addr = "172.16.8.9"
>        $domain  = "172.16.8.9/32"
> Output: true
> ```
>
> **Example 4**
>
> ```text
> Input: $ip_addr = "172.16.4.5"
>        $domain  = "172.16.0.0/14"
> Output: true
> ```
>
> **Example 5**
>
> ```text
> Input: $ip_addr = "192.0.2.0"
>        $domain  = "192.0.2.0/25"
> Output: true
> ```

Actually, IP addresses are 32-bit integers.<br/>
Comparing parts of the host address
with parts of the network address,
with the length of those parts being variable and only known at runtime (the network mask length),
is best done using bit operations on these 32-bit numbers.

That's why my solution has three parts:

* extracting and checking the numbers from the address string ('dot-decimal' notation),<br/>directly returning `false` if anything is not okay with the input, 
* converting the four numbers of each the host and network address into 32-bit integers,<br/>and create 32-bit host and network masks,
* return the result of the necessary comparisons.

As none of the numbers can be larger than 255 (or 32 for the network mask size), my regex used for the extraction accepts only numbers having at most 3 digits, and with no leading zeros:

```perl
    my $n3 = qr/(?: 0 | [1-9]\d{0,2} )/x;    
```

Using this regex, the address parts (decimal numbers) can be extracted:

```perl
    my @ip_addr_parts = $ip_addr =~ m<^($n3)\.($n3)\.($n3)\.($n3)$>;
    my @domain_parts  = $domain  =~ m<^($n3)\.($n3)\.($n3)\.($n3)/($n3)$>;
    my $network_mask_bits = pop @domain_parts;
```

The number of network mask bits is extracted together with the address parts themselves, then assigned to a variable and removed from the `@domain_parts` array.

Next, the input format is checked for correctness, These are the criteria:

+ eight address parts were be extracted, and all of them are less than or equal to 255<br/>
  (which means that both regexes matched, which also means that a number for the network mask length was given),
+ the network mask length is less than or equal to 32.

I use `grep` to filter for correct numbers.<br/>
There have to be eight of them (as returned by `grep` in scalar context):

```perl
    return false
        unless scalar grep( $_ <= 255, @ip_addr_parts, @domain_parts ) == 8
            && $network_mask_bits <= 32;
```

In the next step, the address parts are combined into a 32-bit integer. The method chosen is to use a sequence of `pack "CCCC"` to create a 4-byte string, where each byte contains an address part (range 0 to 255), and then `unpack "N"` to extract a network order (big-endian) 32-bit unsigned integer from that byte string.

The 32-bit host and network masks are calculated using bit-shift, bitwise AND and bitwise negation operators.

Once all these are available, it is easy to return the result of these two conditions:

* the host part of the network address must be all zeros,
* the host address with the host part masked out must be equal to the network address (whose host part was just verified to be all zeros).

This is the complete solution:

```perl
use v5.36;
use builtin qw( true false );

sub subnet_sheriff( $ip_addr, $domain ) {
    # Define a regex for a number with up to three digits (0..999)
    # and no leading zeroes.
    my $n3 = qr/(?: 0 | [1-9]\d{0,2} )/x;

    # Extract the numbers.
    my @ip_addr_parts = $ip_addr =~ m<^($n3)\.($n3)\.($n3)\.($n3)$>;
    my @domain_parts  = $domain  =~ m<^($n3)\.($n3)\.($n3)\.($n3)/($n3)$>;
    my $network_mask_bits = pop @domain_parts;
    return false
        unless scalar grep( $_ <= 255, @ip_addr_parts, @domain_parts ) == 8
            && $network_mask_bits <= 32;

    # Convert the respective four parts into a 32-bit integer,
    # and calculate the 32-bit network and host masks.
    my $host_addr    = unpack "N", pack "CCCC", @ip_addr_parts;
    my $network      = unpack "N", pack "CCCC", @domain_parts;
    my $host_mask    = 0xFFFFFFFF >> $network_mask_bits;
    my $network_mask = ~ $host_mask & 0xFFFFFFFF;

    return ( $network & $host_mask ) == 0
        && ( $host_addr & $network_mask ) == $network;
}
```

#### **Thank you for the challenge!**
