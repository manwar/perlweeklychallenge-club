# A.A.B.A. (Acronym And Build Array)

Challenge 240: https://theweeklychallenge.org/blog/perl-weekly-challenge-240/

## Task 1: Acronym

> You are given an array of strings and a check string.

> Write a script to find out if the check string is the acronym of the words in the given array.

Example 1
```
Input: @str = ("Perl", "Python", "Pascal")
       $chk = "ppp"
Output: true
```

Example 2
```
Input: @str = ("Perl", "Raku")
       $chk = "rp"
Output: false
```

Example 3
```
Input: @str = ("Oracle", "Awk", "C")
       $chk = "oac"
Output: true
```

I am sure there are plenty of more interesting ways to solve this but the way my mind works is to create a real acronym by looping through each word in the in the input array to get the first letter.

```
sub check_acronym {
    my ($acronym, $words) = @_;
    my $real_acronym;
    foreach (@{$words}) {
        $real_acronym .= substr($_, 0, 1);
    }
```

With that in place just compare the strings, forcing them both into uppercase so that it's a case insensitive comparison. You could also do this with a simple RegEx compare but this feels simpler to write/read to my brain.

```
uc($acronym) eq uc($real_acronym) ? print "true\n" : print "false\n";
```

I did a similar approach with Raku and Python. With Perl the final print statement is a conditional so that it will print the words "true" or "false" instead of 0 or 1 but that's not needed with Python and Raku. 

## Task 2: Build Array

> You are given an array of integers.

> Write a script to create an array such that new[i] = old[old[i]] where 0 <= i < new.length.

Example 1
```
Input: @int = (0, 2, 1, 5, 3, 4)
Output: (0, 1, 2, 4, 5, 3)
```
Example 2
```
Input: @int = (5, 0, 1, 2, 3, 4)
Output: (4, 5, 0, 1, 2, 3)
```

Doing `new[i] = old[old[i]]` seemed simple enough but I do have trouble mentally processing `where 0 <= i < new.length`. If `i` is a postion of the input array it is always going to be equal to or greater than 0 because of how arrays are numbered. Since each new[i] is mapped to a value calculated from the old array they should naturally end up the same length, so `i` should never be longer than new.length because `i` shouldn't be less than old.length either.

With that out of the way, I did a simple for loop using the iterator variable `$i` -- within the loop I am literally just doing the exact mapping from the question: `new[i] = old[old[i]]`

```
for (my $i = 0; $i < @ints; $i++) {
    $new_ints[$i] = $ints[$ints[$i]];
}
```

That's it! After the loop I print the new array in the desired format:
```
print "(" . join(', ', @new_ints) . ")\n";
```

This task sounded more complicated so I will be curious to see if others took a more interesting approach.