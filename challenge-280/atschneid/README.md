# Weighted Letters and Even Chars

**Challenge 279 solutions by Andrew Schneider**

[PWC 279](https://theweeklychallenge.org/blog/perl-weekly-challenge-279/)

### Refreshment on Rust Iterators

Pretty straightforward challenges this week. The first basically requires zipping two lists together, sorting on one value, and outputting the other. 

The specifications for the second asks to both find a properly split string, if possible, and to output whether it was possible to find such a split. But since it is easier to find out if a proper split is possible (only need counting for this!) than to actually find the split (proof by construction as it were, easily doable but slightly less easy) I'm treating the function as a black box that outputs the correct answer, and we can ignore how it does it.

This week my guest language is Rust. My random selector actually chose both Rust and C++ for me this week, it often seems to pair the two, but for reasons including: I expected a C++ solution to be substantially similar to my Rust solution, and -- I ran out of time, I only did Rust.

I ran into some trouble handling Rust iterators and had to go back to the book to read up on the topic, for instance, what is the difference between `.iter()` and `.to_iter()` (answer: references v. values). An issue I had to work through was when to `.collect()` and when to not. I learned that `.sort_by_key()` sorts in place so I did need to `.collect()` before calling that, hiyah!

## Task 1: Sort Letters

> Task 1: Sort Letters</br>
> Submitted by: Mohammad Sajid Anwar</br>
> You are given two arrays, @letters and @weights.</br>
> </br>
> Write a script to sort the given array @letters based on the @weights.</br>
> </br>
> Example 1</br>
> Input: @letters = ('R', 'E', 'P', 'L')</br>
>        @weights = (3, 2, 1, 4)</br>
> Output: PERL</br>
> </br>
> Example 2</br>
> Input: @letters = ('A', 'U', 'R', 'K')</br>
>        @weights = (2, 4, 1, 3)</br>
> Output: RAKU</br>
> </br>
> Example 3</br>
> Input: @letters = ('O', 'H', 'Y', 'N', 'P', 'T')</br>
>        @weights = (5, 4, 2, 6, 1, 3)</br>
> Output: PYTHON</br>

I might have called the second input list 'indices' instead of 'weights' although there is a reason not to, which relates to the question of: what to do if a weight is repeated? The examples give no guidance here. All example weights are unique and exhaustive, giving a complete, continuous range (once sorted). Based on my reading of the instructions, "missing" weights are no problem, such as a list of (2, 4, 1), we simply sort them in order giving (1, 2, 4). But how to handle repeated weights, such as (2, 4, 2)? My answer here is to keep both, and order them by their original order. 

To give an example: take letters = ('Z', 'B', 'A') and weights = (2, 4, 2), I propose to return "ZAB" (and not "AZB" or "AB" or "ZB"). Sorting breaking ties by sorting on the letter would return "AZB", which I do not like for this challenge. And if we consider the second input as indices, that would suggest to take either the first or last only, give "ZB" or "AB". I think I came up with the optimal solution here and it is "ZAB". yeah!

### Perl


```perl
sub sort_letters( $letters, $weights ) {
    my @letters = @$letters;
    my @weights = @$weights;

    die "inputs must be the same length" unless $#weights == $#letters;

    my @zipped = map {[$weights[$_], $letters[$_]]} (0 .. $#weights);
    return join '', map { $_->[1] } sort {$a->[0] <=> $b->[0]} @zipped;
}
```

I pass the input arrays to the function as references, because, you know, Perl, so first I cast them to proper lists. I check that they are the same length because they must be then I zip them together into (weight, letter) pairs. I sort on the weight value only! (as discussed above) then map to a list of the (now sorted) letters. Join that list, and done!

### Rust

```rust
fn sort_letters(letters: &[char], weights: &[u64]) -> String {
    if letters.len() != weights.len() {
        panic!("inputs must be same length")
    }

    let mut list_of_pairs: Vec<(&u64, &char)> = weights.iter().zip(letters.iter()).collect();
    list_of_pairs.sort_by_key(|k| k.0);
    list_of_pairs
        .iter()
        .map(|x| x.1.to_string())
        .collect::<Vec<String>>()
        .join("")
}
```

Very similar logic to the Perl solution here, but where Perl is very much the "do what I mean" language, Rust is very much the "I'm not doing *anything* until you tell me exactly what you want, and even then, here are a few compilation errors I want you sort out while you're at it" language. 

Again, I start by checking that the inputs are the same length. Then I zip the two lists together, which I `.collect()` back into vector value, which is necessary because I next `.sort_by_key()` which sorts in place and so can't operate on an iterator. Then convert back into an iterator, and map to the letter value, explicitly converting the `char` to `String`, `.collect()` again, then `.join()` from a vector of strings into a string.

## Task 2: Split String

> Task 2: Split String</br>
> Submitted by: Mohammad Sajid Anwar</br>
> You are given a string, $str.</br>
> </br>
> Write a script to split the given string into two containing exactly same number of vowels and return true if you can otherwise false.</br>
> </br>
> Example 1</br>
> Input: $str = "perl"</br>
> Ouput: false</br>
> </br>
> Example 2</br>
> Input: $str = "book"</br>
> Ouput: true</br>
> </br>
> Two possible strings "bo" and "ok" containing exactly one vowel each.</br>
> </br>
> Example 3</br>
> Input: $str = "good morning"</br>
> Ouput: true</br>
> </br>
> Two possible strings "good " and "morning" containing two vowels each or "good m" and "orning" containing two vowels each.</br>
> 

As I said, I don't bother to actually create the split strings, because we can just check if it would be possible by counting the vowels and checking if there are an even number of them. It reminds me of an old joke about a mathematician and a fire extinguisher... A typical mathematician joke.

### Perl

```perl
sub splittable_string( $string ) {
    my @count = $string =~ /[aeiou]/gi;
    return $#count % 2;
}
```

Easy to do with Perl and regexes. Count the number of case insensitive matches of the regex group `[aeiou]`, then return if the count is 0 mod 2. Conveniently `$#` gives the max index, and since we are zero indexed, the return value is just this index mod 2.

One question I didn't tackle was semi-vowels: 'y', and to a much less extent 'w', and much much less 'r' and 'l'. The only one I might have addressed is 'y' but how to do that? count it as a vowel *half* the time? Nah, skip it. Core vowels only!

### Rust

```rust
fn splittable_string(s: &str) -> bool {
    let mut counter: u32 = 0;
    let vowels: Vec<char> = "AEIOUaeiou".chars().collect();
    for c in s.chars() {
        if vowels.contains(&c) {
            counter = (counter + 1) % 2;
        }
    }
    counter == 0
}
```

In Rust, I would have uses regexes again, but it is rather annoying to impossible to use additional crates (Rust's droll term for packages) in a standalone module, without going through a whole cargo setup, which I try to avoid here for simplicity. So instead I directly count the vowels in the string, one by one. I actually think this may have given a better solution, and at least a more interesting one *vis a vis* my Perl solution.

I create a vector of vowel chars from the string `"AEIOUaeiou"`. Then, iterating over each char in the string, I check if it's in the vowels vector. I could have used a better data structure than vector for this, but it is short and should be fast enough. If the char is a vowel (in the vector) then increment the counter mod 2. In the end, if the counter is even mod 2, ie, 0 then the string is splittable, otherwise not.

## Conclusion

Only one guest language for me this week. I deserve to take it a little easy over the summer :-)
