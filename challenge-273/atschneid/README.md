# Trying to Be X Percent More Interesting

**Challenge 273 solutions by Andrew Schneider**

Being a stream of consciousness write up of some details of my code for [PWC 273](https://theweeklychallenge.org/blog/perl-weekly-challenge-273/)

The challenges this week seemed pretty straightforward. Both of them have pretty direct solutions based on an algorithm of walking along a string, character by character, setting some flag variables or counts. In both cases it was simple to come up solutions that go through each string exactly one time, clearly in $\mathcal{O}(n)$ for $n = |\text{string}|$.

So it is basically impossible to find a better algorithm. But I needed to remind myself that that is *boring!* For one, I try to make my solutions in different languages as different as possible, and just transcribing the same code into different syntax would not be that. And this is supposed to be a chance to do something fun, learn something new.

So let big-O be darned, I'll throw caution to the wind and solve these problems in whatever wacky way I want, and I'll try to not be such a buzzkill. Strong caveat: there is still a lot of similarity between certain pairs of solutions, because I only have a limited amount of imagination, but I'm trying, or I'm growing, or I'm trying to grow, or something.

## Challenge 1: Percentage of Character

> Task 1: Percentage of Character</br>
> Submitted by: Mohammad Sajid Anwar</br>
> You are given a string, $str and a character $char.</br>
> </br>
> Write a script to return the percentage, nearest whole, of given character in the given string.</br>
> </br>
> Example 1</br>
> Input: $str = "perl", $char = "e"</br>
> Output: 25</br>
> Example 2</br>
> Input: $str = "java", $char = "a"</br>
> Output: 50</br>
> Example 3</br>
> Input: $str = "python", $char = "m"</br>
> Output: 0</br>
> Example 4</br>
> Input: $str = "ada", $char = "a"</br>
> Output: 67</br>
> Example 5</br>
> Input: $str = "ballerina", $char = "l"</br>
> Output: 22</br>
> Example 6</br>
> Input: $str = "analitik", $char = "k"</br>
> Output: 13

To start, I think this Julia snippet best shows my idea for the *canonical* solution to this problem

```julia
function percent_char_v1(string, char)
    # the simplest and cheapest algorithm
    # also the most boring
    # 
    # step through each char of the string
    # count the matches, count all chars
    # one pass through the string
    #
    # divide matches by total chars and convert to integer percent 
    count_c = 0
    count_all = 0
    for c in string
        count_c += c == char ? 1 : 0
        count_all += 1
    end
    Int( round( count_c / count_all * 100 ) )
end
```

We need to look at every character in the string to see if it matches. There's no way around that, so we at least need to iterate over the string one time. This algorithm iterates over the string one time. In fact, since we are already doing the iteration, we can count the number of total characters along the way, so there's no extra call to `size` or `length` or anything. I could probably do some work around the last line, we do floating point division, multiply by 100, round, then cast back to an int, not strictly necessary that last part but why not.

### Perl

When I first read this problem description I thought, "great! a chance to use `use integer`!" Only the specification of going to the *nearest whole* threw me off that plan. So I glumly typed out a Perlish version of the above algorithm until I heard a voice whisper "buzzkill" inside my head, and I thought, there's gotta be a way to do this using `use integer`, and voila, I cooked us this gem

```perl
sub percent_char_string( $char, $string ) {
    # do all arithmetic in integer domain
    use integer;

    # get the length of $string
    my $length = length( $string );

    # count how many characters match $char
    my $sum_chars = $string =~ s"$char""g;

    # find the integer division of $sum_chars / $length
    # then figure out if we would round up or down and add 1 or 0 respectively
	my $result = $sum_chars * 100 / $length + (($sum_chars * 100 % $length) * 2 >= $length);

    return $result;
}
```

What's the runtime? I really don't know. `length( $string )` should be $\mathcal{O}(|\text{string}|)$ either when called or at string creation. `$string =~ s"$char""g` is the big question mark for me. Would it be cheaper to do `$string =~ s"$char"\1"g`? Does this even reliably work? I suppose `$char` could have a special regex meaning... bah. Anyway, we're not worrying about all that! we're here to have fun.

Now to what I think is the craziest bit here, figuring out if we round up. Integer division, easy, it truncates. This part `($sum_chars * 100 % $length) * 2 >= $length` made me a little squeamish at first and in my first implementation I made a subtle bug here. What we're asking is: is the remainder (`$sum_chars * 100 % $length`) greater than or equal to half the string length. If yes then we would round up if we had been using floats, so we add 1. We could even do the `* 2` part as a bitshift, so really this has to be at least as efficient as converting to float and back.

The bug I mentioned, I had written `($sum_chars * 100 % $length) >= $length / 2` at first, but since we're doing `use integer` then `$length / 2` gets truncated, which is not what we want. It didn't affect any of the examples, but a simple case to illustrate the problem, suppose `$sum_chars` was 1 and `$length` was 3 (as if our string was "ada" and our character was 'd'). This way we get $100 \mod 3 = 1 \ge 3 // 2 = 1$ using integer division, ie, $1 \ge 1$ and we *round up* when we shouldn't. In the correct formulation this comes out to $2 \ge 3$ (work it out for yourself) and we *round down* which is correct. The trouble with integer division! Sheesh. But worth it to get to use `use integer`.

### Julia

For my *fun* version of the function in Julia I ended up leaning on mostly builtin functionality. It yields a nice one-liner plus comments

```julia
percent_char_v2(string, char) =
    # size( findall( char, string ), 1 ) gives the count of all char in string
    # divide by length of string, times 100 and convert to Int
    Int( round( size( findall( char, string ), 1 ) / length( string ) * 100 ) )
```

Here I have all the inefficiencies, separately counting the matches and total characters, converting to float and back to int, but it's short! Also I got to play around with the Julia REPL help mode to find the names of functions I wanted.

### C++

Oh how I have resisted learning any C++ for so long. To be fair, there is a *lot* there, a lot of code, a lot of functions, a lot of directions, all kind of bolted on a core C frame. But there is some cool stuff bubbling up too. What turned me around on C++ was starting to learn some Rust and realizing a lot of the cool stuff I was learning about in Rust you can do in C++ too, like RAII. 

```cpp
int percent_string_char( std::string s, char c ) {
  // this is the boring algorithm that walks through each char in s
  int sum_char = 0;
  int sum_all = 0;
  for (char sc : s ) {
    sum_char += (sc == c);
    sum_all++;
  }
  return std::round( sum_char * 100.0 / sum_all );
}
```

Well, here is the boring old algorithm after all. The compiler does seem to be letting me play fast and loose with any kind of numeric type, implicitly casting, which is convenient but also, seems like there could be some bugs from this. The most unique thing in my C++ solution is that I made a struct to hold the input data. How very object oriented of me

```cpp
struct char_and_string {
  // a struct to hold a char, string for inputs
  char character;
  std::string string;
};

std::ostream& operator<<( std::ostream& os, char_and_string const& cas ){
  // specifies how to pipe our struct into iostream
  return os << "{ char='" << cas.character << "', string=\"" << cas.string << "\" }";
}
```

I thought about making the core function a method on `char_and_string` but I didn't get there. Next time C++ comes around in my solutions I'll go all-in OO Programming, methods everywhere!

### Rust

If it compiles it runs. Actually I had some logic bugs I nearly missed because I get into the compilation means success mindset. Is it partly out of frustration with how many tries it takes to get it to compile...? Anyway, I know Rust ain't gonna let me go around cast numerics implicitly, because it complained about using a `usize` as a `u32`. Safety!

My Rust function is most like my Perl solution. I keep it in the integer domain.

```rust
fn percent_of_string_char_v2(string: &str, character: &char) -> usize {
    let match_count = string.chars().filter(|c| c == character).count();
    let string_length = string.chars().count();
    let mc_100 = 100 * match_count;
    let (div, remainder) = (mc_100 / string_length, mc_100 % string_length);
    if remainder * 2 >= string_length {
        div + 1
    } else {
        div
    }
}
```

Not much to add to my Perl commentary here. Rust implicitly returns the last value so it's either `div + 1` or `div`. I could have left out the third `let` line, and baked that into the first one, but I thought it was a little clearer this way.

## Challenge 2: B After A

> Task 2: B After A</br>
> Submitted by: Mohammad Sajid Anwar</br>
> You are given a string, $str.</br>
> </br>
> Write a script to return true if there is at least one b, and no a appears after the first b.</br>
> </br>
> Example 1</br>
> Input: $str = "aabb"</br>
> Output: true</br>
> Example 2</br>
> Input: $str = "abab"</br>
> Output: false</br>
> Example 3</br>
> Input: $str = "aaa"</br>
> Output: false</br>
> Example 4</br>
> Input: $str = "bbb"</br>
> Output: true

Again, there's a simple algorithm that looks at every character in the string, we can even short circuit it if we fail early by seeing an 'a' after a 'b'. Let's look at the boring algorithm, this time in C++

```cpp
int validate_a_b_string_v1( std::string s ) {
  // this is the boring algorithm that walks through each char in s
  bool first_b = false;
  for ( char sc : s ) {
    // update if we've seen a 'b' yet
    first_b |= ( sc == 'b' );
    if (first_b && sc == 'a') {
      // if we see an 'a' after a 'b' then false
      return false;
    }
  }
  // if we haven't seen any 'b's then first_b is still false
  return first_b;
}
```

Let's just say we're in C++ section already because this is all I did for C++. Oops! Like I said, next C++ time I'll go all in OO and make up for it. Also, this week I got distracted by some new insights into [PWC 270](https://theweeklychallenge.org/blog/perl-weekly-challenge-270/) which I'll mention below.

### C++

First we create a variable `first_b` to remember if we've seen any 'b' yet, because that determines how we proceed. Now for each char, if it's a 'b' `first_b` gets set to true. Next, if `first_b` is true, if we have seen a 'b' already, and the current character is 'a' then we can fail, return false. Otherwise, doesn't matter what character we see. Finally, if we make it through the string loop, if we have ever seen a 'b' then `first_b` is true, and success! otherwise `first_b` is false and failure, so we can just return `first_b`.

### Perl

The algorithm I came up with here is possibly as efficient as the C++ one, but in much more idomatic Perl (I think) so it's a win-win for my goals this week.

```perl
sub check_a_b_string( $string ) {
    # find the first 'b' index
    # if there's none (ie returns -1) then false
    return 0 if 0 > ( my $first_b_idx = index $string, 'b' );

    # if there are any 'a's after the first 'b' then false
    return 0 if ( substr $string, $first_b_idx ) =~ tr/a//;

    # otherwise true!
    return 1;
}
```

Using builtin functions there's some uncertainty about runtimes, but I'll assume index will stop searching the string once it finds the first match. If there's no match of a 'b' then we return false. Otherwise we use that index as a starting point for a substring, and check if there are any 'a's in there. Assuming that is linear in the size of the searched string, it essentially only needs to pass over the chars of the string one time. Efficient and sleek! It kind of flips the logic of the C++ version, there we check last if we ever saw a 'b', here we check that first.

### Rust

In Rust for this challenge, I'm basically using the C++ algorithm, but I'm using match, and what is more idiomatic Rust than match?! Really Rust has a very powerful match operator, and you see it used often when unwrapping a function that returns a Result, which can be a value or an error, each wrapped inside of its own datatype. Here I'm just matching on the character value.

```rust
fn good_a_b_string(string: &str) -> bool {
    let mut first_b = false;
    for c in string.chars() {
        match c {
            // on 'b' then set first_b to true
            'b' => first_b |= true,
            // on 'a', if we've seen a 'b' then false
            'a' => {
                if first_b {
                    return false;
                }
            }
            // otherwise no action, keep iterating
            _ => continue,
        }
    }
    // if we've seen a 'b' this is true
    first_b
}
```

Match operates on a variable, here `c`. Each leg of the match represents a possible value, here just a simple value, and `_` is the else match, if it hasn't matched anything prior then it will match the on the `_` leg. 

### Julia

In Julia I use a couple of builtin functions.

```julia
function validate_a_b( string )
    first_b = findfirst( 'b', string )
    last_a = findlast( 'a', string )
    # there is a 'b' 
    # and ( there are no 'a's or the last 'a' is before the first 'b' )
    first_b != nothing && ( last_a == nothing || last_a < first_b )
end
```

`findfirst` and `findlast` each return either the index of the found match or the value `nothing` if there was no match. We combine these into a long boolean expression that checks, from left to right, we found a 'b' and we found no 'a' or the last 'a' is before the first 'b'. Simple!

## Revisiting a 270 Problem

Mohammad linked to a great discussion about Challenge 2 from [PWC 270](https://theweeklychallenge.org/blog/perl-weekly-challenge-270/) by [E. Choroba](https://blogs.perl.org/users/e_choroba/2024/06/equalise-an-array.html) which expanded my mind on the problem. If you haven't read it yet you should. On reading the problem description I didn't think about the possibility of all values ending up larger than they came in, and it sounds like nobody else among the official submissions did either, but he gives a case where the optimal solution requires this.

I have been working on my own solution to the elucidated problem and some discussion thereof, but as of press time it is still in revision. I may try to finish it up this week, but definitely check out his blog post.

## Conclusion

Great work this week! I can't wait for the next problem set.
