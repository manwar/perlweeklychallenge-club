# Addictive additive
**Challenge 224 solutions in Perl by Matthias Muth**

## Task 1: Special Notes

> You are given two strings, $source and $target.<br/>
> Write a script to find out if using the characters (only once) from source, a target string can be created.<br/>
> <br/>
> Example 1<br/>
> Input: $source = "abc"<br/>
>        $target = "xyz"<br/>
> Output: false<br/>
> <br/>
> Example 2<br/>
> Input: $source = "scriptinglanguage"<br/>
>        $target = "perl"<br/>
> Output: true<br/>
> <br/>
> Example 3<br/>
> Input: $source = "aabbcc"<br/>
>        $target = "abc"<br/>
> Output: true<br/>

Again, I let the magical Perl regex engine do the work for me.<br/>
The idea is the same as in my solution to Challenge 221 Task 1 'Good Strings'
([read here](https://github.com/MatthiasMuth/perlweeklychallenge-club/muthm-221/challenge-221/matthias-muth/README.md)).<br/>

What seems to be a bit counterintuitive at first,
is that we match the `$source` (all the possible letters) against the `$target` word,
not vice versa!

We need to sort the `$source` characters first.<br/>
Then we to turn the `$target` characters into a regular expression.
This regular expression will match those characters from `$source`
that are contained in the `$target` word.
All other characters from `$source` that are not needed
will be matched by `.*` patterns and ignored.

To illustrate this, here is how Example 2 is solved using a pattern match:
```
special_notes( 'scriptinglanguage', 'perl' )
    ordered source: 'aacegggiilnnprstu'
    target pattern: qr/^.*e.*l.*p.*r.*$/
    pattern match:  'aacegggiilnnprstu' =~ /^.*e.*l.*p.*r.*$/
```

What is left for us is to prepare the sorted source and the pattern.<br/>
Not a big deal:
```perl
    my $ordered_chars = join "", sort split '', $source;
    my $pattern = '^.*' . join( '.*', sort split '', $target ) . '.*$';
```

So all in all it's actually only three lines of code,
to which I added some debugging output
(`vsay` is a subroutine that does the same as `say`
if the global variable `$verbose` is set;
it can be set using the `-v` option in my environment).<br/>
Here is the whole thing:

```perl
sub special_notes {
    my ( $source, $target ) = @_;
    vsay "special_notes( '$source', '$target' )";

    my $ordered_source = join "", sort split '', $source;
    vsay "    ordered source: '$ordered_source'";

    my $pattern = '^.*' . join( '.*', sort split '', $target ) . '.*$';
    vsay "    target pattern: qr/$pattern/";

    vsay "    pattern match:  '$ordered_source' =~ /$pattern/";
    return $ordered_source =~ /${pattern}/ // 0;
}
```

## Task 2: Additive Number

> You are given a string containing digits 0-9 only.<br/>
> Write a script to find out if the given string is additive number. An additive number is a string whose digits can form an additive sequence.<br/>
> A valid additive sequence should contain at least 3 numbers. Except the first 2 numbers, each subsequent number in the sequence must be the sum of the preceding two.<br/>
> <br/>
> Example 1:<br/>
> Input: $string = "112358"<br/>
> Output: true<br/>
> The additive sequence can be created using the given string digits: 1,1,2,3,5,8<br/>
> 1 + 1 => 2<br/>
> 1 + 2 => 3<br/>
> 2 + 3 => 5<br/>
> 3 + 5 => 8<br/>
> <br/>
> Example 2:<br/>
> Input: $string = "12345"<br/>
> Output: false<br/>
> No additive sequence can be created using the given string digits.<br/>
> <br/>
> Example 3:<br/>
> Input: $string = "199100199"<br/>
> Output: true<br/>
> The additive sequence can be created using the given string digits: 1,99,100,199<br/>
>  1 +  99 => 100<br/>
> 99 + 100 => 199<br/>

In this task, we need to choose the first two numbers of the sequence.<br/>
Depending on that choice, we will find a continuation of the sequence
in the remaining string, or we won't.

So how do we choose the first two numbers?<br/>
We start with the first number having one digit, then two digits, and so on.<br/>
With each first number chosen, we then choose the second number,
again first using one digit, then two digits and so on. 

The maximum number of digits to use for the first and then the second number
is what took me longest to think about.<br/>
For the first number, it is relatively clear that
* we need to leave at least on digit for the second number,
* the sum will have at least the same number of digits that the first number has.

So if *len* is the length of the whole string, we can split it up between
the length of the first number *len1*, the minimum length of the second number *1*,
and the minimum length of the sum, which is also *len1*:<br/>
&nbsp;&nbsp; *len1* + 1 + *len1* <= *len* <br/>
which makes<br/>
&nbsp;&nbsp; *len1* <= ( *len* - 1 ) / 2.
    
For the length of the second number, *len2*, things are less obvious.<br/>
We can assume that the sum always has *at least* as many digits as the longer one
of the first and second number.<br>
&nbsp;&nbsp; *len1* + *len2* + max( *len1*, *len2* ) <= *len* <br/>
which is the same as<br/>
&nbsp;&nbsp; <*len1* + *len2* + *len1* <= *len* **and** *len1* + *len2* + *len2* <= *len* <br/>
which transforms to<br/>
&nbsp;&nbsp; *len2* <= *len* - 2 * *len1* **and** *len2* <= ( *len* - *len1* ) / 2<br/>
which means for *len2*:<br/>
&nbsp;&nbsp; *len2* <= min( *len* - 2 * *len1*, ( *len* - *len1* ) / 2 ).

We choose the lengths of the first and second number using two nested loops.<br/>
Inside the loop body we extract these numbers,
and we check whether the rest of the string starts with the sum of the two.<br/>
We use a regular expression for this,
at the same time removing that sum from the rest string if it matched.<br/>
We do the checking and removing sums in a loop until we don't find a match
or the string is completely used.

We can return from the subroutine onece we find a complete match.
But for demonstration, when `$verbose` is set, we continue going through
the rest ofcombinations, creating some nice output to see that
everything works nicely.

This is the whole subroutine:
```perl
sub additive_number {
    my ( $string ) = @_;
    vsay "additive_number( '$string' )";

    my $len = length $string;
    my $is_additive_number = 0;
    for my $len1 ( 1 .. int( ( $len - 1 ) / 2 ) ) {
        vsay "    len1: $len1, trying len2 1 .. min( ",
            $len - 2 * $len1, ", ",
            int( ( $len - $len1 ) / 2 ), " )";
        for my $len2 (
            1 .. min( $len - 2 * $len1, int( ( $len - $len1 ) / 2 ) ) )
        {
            my $n1 = substr $string, 0, $len1;
            my $n2 = substr $string, $len1, $len2;
            my $rest = substr $string, $len1 + $len2;
            vsay "        trying $n1 and $n2, leaving '$rest'";
            while ( $rest ne "" ) {
                my $sum = $n1 + $n2;
                $rest =~ s/^$sum// or do {
                    vsay "            no match for sum $sum";
                    last;
                };
                vsay "            sum $sum found";
                ( $n1, $n2 ) = ( $n2, $sum );
            }
            if ( $rest eq "" ) {
                return 1
                    unless $verbose;
                vsay "            SUCCESS!";
                $is_additive_number = 1;
            }
        }
    }
    return $is_additive_number;
}
```

With *$verbose* set, it produces this output for the examples:
```
additive_number( '112358' )
    len1: 1, trying len2 1 .. min( 4, 2 )
        trying 1 and 1, leaving '2358'
            sum 2 found
            sum 3 found
            sum 5 found
            sum 8 found
            SUCCESS!
        trying 1 and 12, leaving '358'
            no match for sum 13
    len1: 2, trying len2 1 .. min( 2, 2 )
        trying 11 and 2, leaving '358'
            no match for sum 13
        trying 11 and 23, leaving '58'
            no match for sum 34
additive_number( '12345' )
    len1: 1, trying len2 1 .. min( 3, 2 )
        trying 1 and 2, leaving '345'
            sum 3 found
            no match for sum 5
        trying 1 and 23, leaving '45'
            no match for sum 24
    len1: 2, trying len2 1 .. min( 1, 1 )
        trying 12 and 3, leaving '45'
            no match for sum 15
additive_number( '199100199' )
    len1: 1, trying len2 1 .. min( 7, 4 )
        trying 1 and 9, leaving '9100199'
            no match for sum 10
        trying 1 and 99, leaving '100199'
            sum 100 found
            sum 199 found
            SUCCESS!
        trying 1 and 991, leaving '00199'
            no match for sum 992
        trying 1 and 9910, leaving '0199'
            no match for sum 9911
    len1: 2, trying len2 1 .. min( 5, 3 )
        trying 19 and 9, leaving '100199'
            no match for sum 28
        trying 19 and 91, leaving '00199'
            no match for sum 110
        trying 19 and 910, leaving '0199'
            no match for sum 929
    len1: 3, trying len2 1 .. min( 3, 3 )
        trying 199 and 1, leaving '00199'
            no match for sum 200
        trying 199 and 10, leaving '0199'
            no match for sum 209
        trying 199 and 100, leaving '199'
            no match for sum 299
    len1: 4, trying len2 1 .. min( 1, 2 )
        trying 1991 and 0, leaving '0199'
            no match for sum 1991
```

#### **Thank you for the challenge!**
