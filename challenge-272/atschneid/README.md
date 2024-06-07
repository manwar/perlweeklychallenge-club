# Defang 

**Challenge 272 solutions by Andrew Schneider**

Let's get right to the problems

## Task 1: Defang IP Address
Submitted by: Mohammad Sajid Anwar

> You are given a valid IPv4 address.<br/>
> <br/>
> Write a script to return the defanged version of the given IP address.<br/>
> <br/>
> A defanged IP address replaces every period “.” with “[.]".<br/>
> <br/>
> Example 1<br/>
> Input: $ip = "1.1.1.1"<br/>
> Output: "1[.]1[.]1[.]1"<br/>
> Example 2<br/>
> Input: $ip = "255.101.1.0"<br/>
> Output: "255[.]101[.]1[.]0"<br/>

Really I think this problem wants a one-liner solution. Most of my chance to use Perl at work is writing one-liners like this guy

```bash
perl -lpe 's/\./[.]/g'
```

which actually works just the same in sed

```bash
sed 's/\./[.]/g'
```

What we're doing here is a simple regex substitution on a period literal (gotta escape special characters) replacing with `[.]`

But, it didn't just feel right to get away with this one so easily. Where's the boilerplate? What am I learning? So I coded up a fully respectable Perl version.

The heart of the program is this little function

```perl
sub defang {
    shift;
    s/\./[.]/g;
    return $_;
}
```

which is powered by much Perl magic. It expects a string variable, which gets `shift`ed into `$_`. Then substitution automagically happens on our `$_` variable by `s/\./[.]g;` (cf. `$_ =~ s/\./[.]/g;` for the same result with 90% less magic). Then pass back the substituted value in `$_`. I wondered if Perl would automagically return the special variable `$_` if the last line was simply `return;` and I learned it would not. So the final line is more sleight-of-hand than magic, but still. I often find it so much easier to use Perl's "do what I want" power on hidden magic variables that I contort my functions into horribly unnatural shapes just to get the magic to do what I need it to. Fortunately this particular function actually flows pretty naturally.

Not satisfied to simply code this up in Perl I worked on a few other solutions.

Originally I had coded up my C implementation using `strtok_r`, but I realized it wasn't quite doing what I wanted.

```c
void defang(char * input, char * output) {
	//first design
	
	char * token, * next_token;

	// blank the string contents in ouput
	strcpy(output, "");
	token = strtok_r(input, ".", &next_token);
	while (token) {
		strcat(output, token);
		printf("  %s\n", next_token);
		token = strtok_r(NULL, ".", &next_token);
		if (token) {
			// if its not the last
			strcat(output, "[.]");
		}
	}
}
```

It handles the example cases just fine, but based on a strict reading of the specification, every '.' should be replaced by '[.]', this implementation fails on basically all edge cases: leading, multiple, and trailing '.'s all get dropped. I thought about how to handle these cases in general, and decided 'every' means *every* so in case like "..." we'd expect to get "[.][.][.]". In keeping consistency across all of my implementations I decided on this one

```c
void defang(char * input, char * output) {
	size_t out_index = 0;
	for (; *input != '\0'; input++) {
		if (*input == '.') {
			output[out_index] = '[';
			output[out_index+1] = '.';
			output[out_index+2] = ']';
			out_index += 3;
		}
		else {
			output[out_index] = *input;
			out_index++;
		}
	}
	output[out_index] = '\0';
}
```

Here I'm crawling along the string one character at a time. If the char is '.' then add the chars '[', '.', ']' to the output string, otherwise just add the char itself. Interesting that my crude solution here is about as long as the one using `strtok`. If this problem had been *slightly* more complicated I might have had to use a library.

Next up, Prolog. Getting anything done in Prolog is always a trip for me. It takes a little while to adjust, in particular, I always forget I have to pass the output variable to the function. With Prolog, at very high level, you're not really saying "compute this function and store the return value in X" as much as "give me an X that is a solution to this function." What's really cool is that often you can flip that to be "here is an X that is the solution to this function, give its input Y that yields X" or something like that. Besides all that, the syntax turns out to be very similar to a functional language like Haskell or Lisp. Anyway, I digress.

I decided to write this in a way that could be run using GNU Prolog. I don't remember why I decided that, maybe I wanted a challenge. Because once I started running into issues and started Googling (DuckDuckGoing really) for answers I got a lot of results telling me how to do the thing I wanted very easily in SWI Prolog, which is a much more fully-featured, batteries included Prolog implementation. In particular, handling strings is not easy to do in Prolog in general, but SWI has adding a lot of functionality around this. If my understanding is correct, in Prolog a string is just a list of chars, except that it's not. For instance, you can't pattern match on it. But if you print a string you get a list of char codes, so it's kind of a lose-lose. The solution, or rather *a* solution, or better yet *my* solution is to convert strings to atoms. Prolog loves atoms and there are functions to convert a list of chars into an atom, and by the Prolog reflexive property, vice versa. Printing an atom gives it's name as you would expect, so that is what I use for output too. So in my roundabout Prolog solution, I start by converting a string to a list of chars

```prolog
str_to_chars(S, Cs) :- atom_codes(X, S), atom_chars(X, Cs).
```

If we initialize this function as `str_to_chars("hello", Cs).` it first looks for a solution to `atom_codes(X, "hello")` which is, it looks for an atom whose characters match the list of char codes (recall the string is represented as a list of char codes) of "hello" (explicitly `[104,101,108,108,111]`). This is exactly the atom `hello` which is bound to the variable `X`. Next it tries `atom_chars(X, Cs)` which is now `atom_chars(hello, Cs)` which attempts to find a list of chars (not char codes here) which make up the characters of `hello`, obviously giving `['h', 'e', 'l', 'l', 'o']` which gets bound to the variable `Cs`. Phew. There's got to be a better way to do this, but this works.

Now that we have a list of chars, the rest is pretty easy. The easy part was the hard part. What we'll do is walk through the list of chars. If the list is empty, return an empty list. If the first char is '.' return the list `['[', '.', ']']` appended to the defanged list minus its head, and otherwise append the head to the defanged list minus its head. Like so

```prolog
defang_chars([], []).
defang_chars(['.'|Xs], ['[', '.', ']'|Y]) :- defang_chars(Xs, Y), !.
defang_chars([X|Xs], [X|Y]) :- defang_chars(Xs, Y).
```

You know I really abused terminology there. Prolog doesn't return anything! It just shows how hard it is to get my mind into logic programming mode. Really it's (constructive) matching. One thing to point out is the cut `!` operator in line 2. What I want here is that if we match a '.' then commit to it. Don't backtrack on to line 3, since that won't give us the correct output.

I'll mention briefly my Racket solution. After struggling through my Prolog implementation, this one was a breeze. The logic is basically the same, convert strings to lists, then recursively operate on the head of the list.

```racket
(define (defang-list s)
  (let loop ([s s])
    (if (empty? s)
        '()
        (let ([first (car s)] [rest (cdr s)])
          (case first
            [(#\.) (append '(#\[ #\. #\]) (loop rest))]
            [else (cons first (loop rest))])))))
```

One cool thing I dug up was `raco fmt` which is a code formatter for Racket. I used to think, "I'm a freewheelin' guy, don't fence me in, I'll format my code however I feel," but now I know that guy was a jerk! Find a style and stick with it, it will make your life easier. It doesn't matter so much what format you use as that you use a format. I read somewhere, and I agree.

Funny side note, I had mentally converted 'defang' to 'defrang', and coded up all my solutions using 'defrang' in the function names somewhere, then had to do a substitution to get things back to normal. Maybe that's an idea for a future PWC - fix all the function names in some C code or something like that. Also, defrang ... I like that word. I'll have to rememebr to try to use that somewhere.


## Task 2: String Score
Submitted by: Mohammad Sajid Anwar

> You are given a string, $str.<br/>
> <br/>
> Write a script to return the score of the given string.<br/>
> <br/>
> The score of a string is defined as the sum of the absolute difference between the ASCII values of adjacent characters.<br/>
> <br/>
> Example 1<br/>
> Input: $str = "hello"<br/>
> Output: 13<br/>
> <br/>
> ASCII values of characters:<br/>
> h = 104<br/>
> e = 101<br/>
> l = 108<br/>
> l = 108<br/>
> o = 111<br/>
> <br/>
> Score => |104 - 101| + |101 - 108| + |108 - 108| + |108 - 111|<br/>
>       => 3 + 7 + 0 + 3<br/>
>       => 13<br/>
> Example 2<br/>
> Input: "perl"<br/>
> Output: 30<br/>
> <br/>
> ASCII values of characters:<br/>
> p = 112<br/>
> e = 101<br/>
> r = 114<br/>
> l = 108<br/>
> <br/>
> Score => |112 - 101| + |101 - 114| + |114 - 108|<br/>
>       => 11 + 13 + 6<br/>
>       => 30<br/>
> Example 3<br/>
> Input: "raku"<br/>
> Output: 37<br/>
> <br/>
> ASCII values of characters:<br/>
> r = 114<br/>
> a = 97<br/>
> k = 107<br/>
> u = 117<br/>
> <br/>
> Score => |114 - 97| + |97 - 107| + |107 - 117|<br/>
>       => 17 + 10 + 10<br/>
>       => 37<br/>

What I like most about this challenge is it finally gives us a way to directly compare programming languages. Now if someone asks if Raku is better than Perl I can say 37 > 30 so yes!

Let's see some code

```perl
sub sum_char_abs_diff ($s) {
    my @slist = map { ord } split '', $s;
    my $sum = 0;
    for my $idx ( 1..scalar(@slist) - 1 ) {
	$sum += abs( $slist[$idx] - $slist[$idx-1] );
    }
    return $sum;
}
```

Steps

```c
int sum_abs_char_diffs(const char * s) {
  const size_t s_len = strlen(s);

  int abs_diff, sum = 0;
  for (int i=1; i < s_len; i++) {
    abs_diff = abs(s[i] - s[i-1]);
    sum += abs_diff;
  }
  return sum;
}
```

Plays to C's strengths, a char is basically an int! I wonder if I can do this in perl?

```prolog
sum_char_diffs([], 0).
sum_char_diffs([_], 0).
sum_char_diffs([A, B|Xs], S) :-
    A > B,
    sum_char_diffs([B|Xs], S2), S is S2 + A - B.
sum_char_diffs([A, B|Xs], S) :-
    B >= A,
    sum_char_diffs([B|Xs], S2), S is S2 + B - A.
```

The trickiest bit here is that I didn't know if there's an absolute value function so I just treat `A > B` and `B >= A` separately. The fact that Prolog thinks of strings as a list of char codes works well for me here, no conversion necessary!

```racket
(define (sum-abs-char-diffs s)
  (let* ([char-list (string->list s)] [num-list (map char->integer char-list)])
    (let loop ([num-list num-list] [diff-sum 0])
      (if (> 2 (length num-list))
          diff-sum
          (loop (cdr num-list) (+ diff-sum (abs (- (car num-list) (cadr num-list)))))))))
```


#### **Thanks!**
