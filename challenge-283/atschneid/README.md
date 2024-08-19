# Exact Triples and Modulation

**Challenge 282 solutions by Andrew Schneider**

[PWC 282](https://theweeklychallenge.org/blog/perl-weekly-challenge-282/)

Two challenges both related to repetitions this week. I solved them in two languages each with a very different kind of solution.

## Task 1: Good Integer

> Task 1: Good Integer</br>
> Submitted by: Mohammad Sajid Anwar</br>
> You are given a positive integer, $int, having 3 or more digits.</br>
> </br>
> Write a script to return the Good Integer in the given integer or -1 if none found.</br>
> </br>
> A good integer is exactly three consecutive matching digits.</br>
> </br>
> Example 1</br>
> Input: $int = 12344456</br>
> Output: "444"</br>
> </br>
> Example 2</br>
> Input: $int = 1233334</br>
> Output: -1</br>
> </br>
> Example 3</br>
> Input: $int = 10020003</br>
> Output: "000"</br>

Pretty clear description, but what are we to do if there are more than 1 Good Integers in a number? I could have returned the first and been done, but it really felt like we should return them all, so that's how I did it.

### Perl

With Perl, for both challenges this week I went full in with regexes, because, of course, Perl! 

```perl
sub good_integer( $int ) {
    my @val = $int =~ /((\d)(?!\g-1)|(^))((\d)\g-1{2})(?!\g-1)/g;
    if (@val) {
        my @retval;
        my $idx = 3;
        while ($idx <= $#val) {
            push @retval, $val[$idx];
            $idx += 5;
        }
        return @retval;
    }
    return (-1);
}
```

Ok, that looks bad. There are two parts here: finding the GIs and pushing the GI values into a list to return.

For finding the GIs it's regex

```perl
    my @val = $int =~ /((\d)(?!\g-1)|(^))((\d)\g-1{2})(?!\g-1)/g;
```

Which can be split into 2 logical pieces:

```((\d)(?!\g-1)|(^))``` matches either: a decimal which is followed by a different decimal value (which is checked by a non-consuming, non-capturing lookahead) or the beginning of the string. The purpose of this piece is to make sure we don't match the end of a sequence of the same decimal values that is longer than 3.

I capture the start of string anchor because later, when I want to find the GIs I want them to be at predictable indices in the match array.

```((\d)\g-1{2})(?!\g-1)``` this will match a decimal followed by 2 more of the same decimal value, followed by anything except the same value (as a non-consuming, non-capturing lookahead). This makes sure that we don't match the start of a sequence of the same decimal values that is longer than 3. Combined with the first part of the regex, this is the part that will capture the GI (and the decimal value).

I never really did much with lookaheads before. I was aware they existed but I never had a good use case for them. They turned out to be pretty intuitive. Originally I tried to use a lookbehind for the first part of the regex, but I couldn't get that to work (and suspect it was doomed anyway, without some acrobatics). Covering the first part with a lookahead wasn't too bad once I had the idea.

This whole match is global so it should capture GIs, plus some other stuff, as many times as they are found.

Now on to the second part of the function. This checks if the regex matched, and if so it extracts the captures that cover the GIs.

```perl
    if (@val) {
        my @retval;
        my $idx = 3;
        while ($idx <= $#val) {
            push @retval, $val[$idx];
            $idx += 5;
        }
        return @retval;
    }
    return (-1);
```

Because of all the captures we use as references within the regex, we end up with values in our matching list besides just the GIs. If there is/are match(es) the first GI is in the match list at index 3. For each GI match we add 5 values to the match list. I figured out these values by counting! So if there is a match we push the value at index 3, then step forward at step size 5 pushing the value we land on until we exhaust the match list. This gives us our matches.

If we didn't find any GIs then we directly return a list of `(-1)`

*UPDATE:* At press time I peeked at some other solutions and realized a much simpler way to handle ... most of this. For the regex we could capture all runs of consecutive same values. Then `grep` the results for array values of length exactly 3. Of course!

```perl
sub good_integer_v2( $int ) {
    my @val = grep { 3 == length $_ } $int =~ /((\d)\g-1*)/g;
    if (@val) {
        return @val;
    }
    return (-1);
}
```

Very nearly a one-liner there, if not for the `-1` return ...

### Rust

For Rust, for both of my solutions, I didn't use regex at all, instead I iterated directly over the characters of a string. For one, it is annoying to impossible to use external crates in Rust without going through a whole `cargo` build, which I try to avoid where I can, and regexes in Rust come via an external crate. But also, for these problems, looking at each character doesn't lead to an obviously less complicated solution. Although certainly more verbose.

```rust
fn good_integer(input: &u64) -> Vec<String> {
    let input_string = input.to_string();
    if input_string.len() < 3 {
        return ["-1".to_string()].to_vec();
    }

    let mut vec = Vec::new();
    let mut count = 1;
    let mut chars = input_string.chars();
    let mut last = chars.next().unwrap();
    for current in chars {
        if last == current {
            count += 1;
        } else {
            if count == 3 {
                vec.push(format!("{}{}{}", last, last, last));
            }
            count = 1;
        }
        last = current;
    }
    // catch possible trailing valid ints
    if count == 3 {
        vec.push(format!("{}{}{}", last, last, last));
    }

    if vec.len() > 0 {
        return vec;
    }
    ["-1".to_string()].to_vec()
}
```

To start we convert the integer input to a string. We need to make sure that the string is at least length 1, but while we're at it we may as well check if it's less than length 3 since in either case the result will be the same: no GIs. I think there is a neater solultion for handling an empty string than what I have here, more on that below.

Next I make an empty vector for storing our results and initialize a counter to 1. Then convert our string to an iterable of chars, and get the first. Currently I assume this will succeed because I have already checked the length, but instead of checking the length I could check for an error getting the first char and interpret this to mean an empty string. Future work!

Now the loop. While the current character matches the previous we increment the counter. Once we find a mismatch we check if the count is 3. If yes we can add a string of 3 of the previous character to the results vector. Then we reset the counter.

We have to repeat the last bit after the loop one last time in case of a GI that falls at the end of the int.

Finally, if we have anything in our results vec we return it, otherwise we return a vec with "-1". Easy!


## Task 2: Changing Keys

> Task 2: Changing Keys</br>
> Submitted by: Mohammad Sajid Anwar</br>
> You are given an alphabetic string, $str, as typed by user.</br>
> </br>
> Write a script to find the number of times user had to change the key to type the given string. Changing key is defined as using a key different from the last used key. The shift and caps lock keys won’t be counted.</br>
> </br>
> Example 1</br>
> Input: $str = 'pPeERrLl'</br>
> Ouput: 3</br>
> </br>
> p -> P : 0 key change</br>
> P -> e : 1 key change</br>
> e -> E : 0 key change</br>
> E -> R : 1 key change</br>
> R -> r : 0 key change</br>
> r -> L : 1 key change</br>
> L -> l : 0 key change</br>
> </br>
> Example 2</br>
> Input: $str = 'rRr'</br>
> Ouput: 0</br>
> </br>
> Example 3</br>
> Input: $str = 'GoO'</br>
> Ouput: 1</br>

Similar to the previous task, we are concerned with repetitions here. This time ignoring them.

### Perl

I iterated on my regex solution to this one. 

In an early version I did 2 steps, first substituting all case insensitive consecutive matches to one char, then finding the length of the resulting string. The answer is this length minus 1, which is the number of changes

```perl
sub count_change_v1( $str ) {
    $str =~ s/(.)\g1*/$1/gi;
    return -1 + length $str;
}
```

I liked this solution, but it felt like it was one line too long. 

Instead of substituting I could directly capture a char and consume all following identical chars (case insensitive of course), then count the number of captures.

```perl
sub count_change_v2( $str ) {
    return scalar ( () = $str =~ /(.)\g1*/gi ) - 1;
}
```

The trickiest bit here was getting the perlism exactly right to return the count.

### Rust

My Rust solution turned out much like a stripped down version of my solution for Task 1

```rust
fn count_change(s: &str) -> u32 {
    if s.len() < 2 {
        return 0;
    }

    let mut count = 0;
    let binding = s.to_lowercase();
    let mut chars = binding.as_str().chars();
    let mut last = chars.next().unwrap();
    for current in chars {
        if last != current {
            count += 1;
        }
        last = current;
    }
    count
}
```

Again we check the length of the string, we really care if it is less than 1 but we might as well check if it is less than length 2 because the result will be the same. Then we iterate over the chars of the string counting how many times the char changes. Easy!

## Conclusion

That's it for this week. Two challenges, two languages, two different ways to solve the problems! Which one did you like better? The character iterating solutions were easy to write and very direct for the problems, but doing some moderately complicated stuff with regexes makes me feel like I'm operating on a higher plane. I'm torn!

Thanks for reading. See you next week!
