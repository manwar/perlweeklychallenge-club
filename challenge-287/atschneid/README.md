# 

**Challenge 287 solutions by Andrew Schneider**

[PWC 287](https://theweeklychallenge.org/blog/perl-weekly-challenge-287/)

Trying to get back to some blog words this week. Fortunately there is something to say about each of this week's challenges.

## Task 1: Strong Password
Submitted by: Mohammad Sajid Anwar

> You are given a string, $str.</br>
> </br>
> Write a program to return the minimum number of steps required to make the given string very strong password. If it is already strong then return 0.</br>
> </br>
> Criteria:</br>
> </br>
> - It must have at least 6 characters.</br>
> - It must contains at least one lowercase letter, at least one upper case letter and at least one digit.</br>
> - It shouldn't contain 3 repeating characters in a row.</br>
> Following can be considered as one step:</br>
> </br>
> - Insert one character</br>
> - Delete one character</br>
> - Replace one character with another</br>
> </br>
> Example 1</br>
> Input: $str = "a"</br>
> Output: 5</br>
> </br>
> Example 2</br>
> Input: $str = "aB2"</br>
> Output: 3</br>
> </br>
> Example 3</br>
> Input: $str = "PaaSW0rd"</br>
> Output: 0</br>
> </br>
> Example 4</br>
> Input: $str = "Paaasw0rd"</br>
> Output: 1</br>
> </br>
> Example 5</br>
> Input: $str = "aaaaa"</br>
> Output: 2</br>

Ok. Seems easy enough ... until you start to think about it. All of the operations having the same cost certainly makes things easier. 

So if your password isn't long enough, and you need to add some extra character types (uppercase, lowercase, numeral) then you can add those as the extra chars. Or if you have some 3-consecutive chars, you can change some of them to upper/lower case letters or numbers as needed to fill things out. 

In the broadly general case, you find out how many changes you need to make, and you can count those towards the missing character types.

Unless ... 

It is easier to think about changing a character than adding a character (or deleting one), because it either doesn't make a difference or is cheaper. Like say you have five consecutives 'A's : 'AAAAA'. You could try to break it up by adding a character, say try 'AABAAA' -- but now you need another to break up the final three. Instead you can *change* the middle one: 'AABAA' and fix it in one step.

The exception being when we need to satisfy the 6 character minimum. Then we'll want to add chars. But then we need to be careful that we get the right answer when we have consecutive chars.

As it turn out (I'm like, pretty sure about this. Pretty. Sure.) there is only one case we want to treat specially. If our input is precisely 5 consecutive characters. In this case we need 2 changes. One to break up the 3 consecutive and one to get to 6 total (or we can think about them both as inserts giving us a 7 char password, but I'm not gonna think like that). We can be sure that we'll have one of each character type because we start with 1 and we can add one of each of the missing 2 add each step: change, and insert.

Ok, great! We've solved one case. Now we only need to solve a countable infinitude of other cases.

But in fact, for every other case we can use a simple algorithm: count how many characters we are short of 6. If we need some, we can insert that many characters to get to six. Even if we have consecutive triples, we can add between them to break them up (except in the previously discussed quintuple!). Ok hang on to that number as the needed value.

If we have at least 6 chars, great! Then we look at how many triples we have. Each triple needs attention, so it doesn't matter if a triple is part of a quintuple or a nontuple (?), or whatever, we just count how many consecutive threes there are (easy to handle via regex coincidentally!). This becomes our needed value.

Ok, now we have a number of changes that we need to satisfy the minimum char length and nonconsecutive 3s conditions. Finally, we check how many of the character types we have. If we already have more changes needed than missing character types, we can just use some of those changes (changes or inserts to be precise) to add in the missing character types. Otherwise, we'll need to add the missing types. So if we have, say, 'aabbcc' we'll have zero needed to satisfy minimum and triple conditions, but 2 changes needed to get all the char types.

So there, I'm pretty sure that covers it.

```perl
sub password_distance( $password ) {
    # needed to meet length min of 6
    my $needed = max( 6 - length $password, 0 );

    if ( $needed > 0 ) {
	if ( $password =~ /(.)\1{4}/ ) {
	    $needed = 2;
	}
    } else {
	# changes neede to break up threes
	$needed = () = $password =~ /(.)\1\1/g;
    }
    
    # changes needed for satisfying
    # lowercase, uppercase, digit
    my $lud = ( $password !~ /[a-z]/ ) + ( $password !~ /[A-Z]/ ) + ( $password !~ /[0-9]/ );

    return max( $needed, $lud );
}
```

Something like that. Presto!

## Task 2: Valid Number
Submitted by: Mohammad Sajid Anwar

> You are given a string, $str.</br>
> </br>
> Write a script to find if it is a valid number.</br>
> </br>
> Conditions for a valid number:</br>
> </br>
> - An integer number followed by an optional exponent.</br>
> - A decimal number followed by an optional exponent.</br>
> - An integer number is defined with an optional sign '-' or '+' followed by digits.</br>
> Decimal Number:</br>
> </br>
> A decimal number is defined with an optional sign '-' or '+' followed by one of the following definitions:</br>
> - Digits followed by a dot '.'.</br>
> - Digits followed by a dot '.' followed by digits.</br>
> - A dot '.' followed by digits.</br>
> Exponent:</br>
> </br>
> An exponent is defined with an exponent notation 'e' or 'E' followed by an integer number.</br>
> </br>
> Example 1</br>
> Input: $str = "1"</br>
> Output: true</br>
> </br>
> Example 2</br>
> Input: $str = "a"</br>
> Output: false</br>
> </br>
> Example 3</br>
> Input: $str = "."</br>
> Output: false</br>
> </br>
> Example 4</br>
> Input: $str = "1.2e4.2"</br>
> Output: false</br>
> </br>
> Example 5</br>
> Input: $str = "-1."</br>
> Output: true</br>
> </br>
> Example 6</br>
> Input: $str = "+1E-8"</br>
> Output: true</br>
> </br>
> Example 7</br>
> Input: $str = ".44"</br>
> Output: true</br>

Ok, so after hammering out the finer points of challenge 1, I thought this one looked like the easy one, *except*...

There is a recursive element. An 'integer' (or a 'decimal') can be followed by an exponent, which contains as part of its definition ... an 'integer'! We could have an infinitude of 'exponent'-'integer' elements at the end of a legal number!! Aiyah!

This would be a great case to use a parser, something like Raku has built in (right? I think) or an external Perl module, and I am all about parsers and lexers, and syntax and all that stuff. But I'm often also all about laziness, and not worrying about googling how to do stuff I haven't done before, and so in this case that second side of me won out. meh

Fortunately, it turns out that we can handle it **reasonably** well with ordinary regexes (regices anyone?). What the infinite regress amounts to is simply that we can have any number of trailing, legal 'exponent's. If we remove all trailing legal 'exponent's then whatever remains will be a valid number iff the original input was a valid number.

So there, our solution. First we peel off all trailing, legal 'exponent's iteratively. Then for what remains, we check if it is a legal 'integer' or 'decimal' and return this truth value.

```perl
sub check_numberable( $str ) {
    # iteratively remove trailing 'exponent' strings
    while ( $str =~ s/(e|E)(\+|-)?\d+$// ) {}
    
    return $str =~ /^(\+|-)?(\d+|(\d+\.\d*|\d*\.\d+))$/;
}
```

There it is. Much regex mumbo jumbo, but it seems to do what I want, which I feel is the highest praise one can give to a regex.

## Conclusion

So there you have it. No guest languages this week. I'm slacking.

Each challenge this week threw me a curveball. It wasn't until I was mostly done with a straightforward, simple, and wrong solution did I start to ponder the intricacate nuances of the challenge descriptions and edge cases.

Thanks for the challenges!
