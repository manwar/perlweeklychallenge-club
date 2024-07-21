# Sginrt and droW

**Challenge 278 solutions by Andrew Schneider**

[PWC 278](https://theweeklychallenge.org/blog/perl-weekly-challenge-278/)

### Racket - typically

Two challenges this week. The first was probably the simpler, with much left open to interpretation. It could become as easy or as complicated as you wanted to make it, I think I opted for somewhat more complicated. The second seemed more fully specified, so less room for me to go off the rails with it. 

The titles of the challenges threw me off a few times, twice I implemented the second challenge to reverse the string up until the character, not sort, but hey.

This week I returned to Racket, but using it's typed variant. I struggled mightily getting the first challenge to run, because of type specifications, but the second one proceeded much more easily, largely due, I'm sure, to all of the hard-earned knowledge from sweating over the first one! That's how I learn I suppose, it's not easy and it's not pretty.

## Task 1: Sort String

> Task 1: Sort String</br>
> Submitted by: Mohammad Sajid Anwar</br>
> You are given a shuffle string, $str.</br>
> </br>
> Write a script to return the sorted string.</br>
> </br>
> A string is shuffled by appending word position to each word.</br>
> </br>
> Example 1</br>
> Input: $str = "and2 Raku3 cousins5 Perl1 are4"</br>
> Output: "Perl and Raku are cousins"</br>
> </br>
> Example 2</br>
> Input: $str = "guest6 Python1 most4 the3 popular5 is2 language7"</br>
> Output: "Python is the most popular guest language"</br>
> </br>
> Example 3</br>
> Input: $str = "Challenge3 The1 Weekly2"</br>
> Output: "The Weekly Challenge"

The examples given all have a single digit word position, so we could assume that all word positions are one digit and every sentence has at most 10 (9 really since we're 1 indexing again) words, but that seemed too mundane. Instead I'll interpret the encoding as: any continuous block of digits at the end of an encoded word represents a word position. This does pose a problem if we were to encode a word which ends in a digit, but ... not gonna worry about that.

Another aspect to think about: missing words. Let's say we have only index 1 and index 5 words, what to do here? I decided to pad the decoded string with a filler word for each space missing between 1 and the max word position.

One final consideration: bad encodings - encoded words without a trailing word position. These I ignore in the decoded string. Decisions had to be made and I made them!

### Perl

Since I'm allowing arbitrary length word positions, I decided to use regex to capture the word position. What's more, this is a great opportunity to use non-greedy matching. What we want is to capture the "word" part and the "index" part, where the word part can be any length, but we want it to stop once the final index part begins, so we use non-greedy matching on the word part, and let the greediness of the index match handle this. Like so `/(\w+?)(\d+$)/`

```perl
sub unshuffle_string( $s ) {
    my %words;
    for (split ' ', $s) {
	my ($word, $idx) = /(\w+?)(\d+$)/;
	# if the regex pattern matched
	if ( $word ) {
	    $words{ $idx } = $word;
	}
    }

    my @sorted_words = ();
    for (1..max( keys %words )) {
	my $word = exists($words{ $_ }) ? $words{ $_ } : 'REDACTED';
	push @sorted_words, $word;
    }
    return join ' ', @sorted_words;
}
```

We split the string on whitespace, then create a hashmap indexed by the word position with a value of the word. Ah, one more decision I neglected to mention above, if we have multiple of the same word index, I use the last occurring one.

Once the hashmap has been created, we step through each value from 1 to the max word position found. Starting with an empty list, if the index value is in the hashmap keys, push its value onto the list, otherwise push the filler value "REDACTED". Then join our list of words and return.

### Julia

My Julia solution is very similar to my Perl solution. The Julia docs mention how Perl was an influence on Julia, and the regex capabilities show it.

```julia
function unshuffle_string( string )
    words = split( string )
    keywords = Dict{Int, String}()

    re = r"(?<word>^\w+?)(?<index>\d+$)"
    for word in words
        m = match( re, word )
        if ~isnothing(m)
            keywords[ parse( Int, m["index"] ) ] = m["word"]
        end
    end

    max_key = maximum( keys( keywords ); init=1 )
    out_words = [get!( keywords, i, "REDACTED" ) for i = 1:max_key]
    join( out_words, " " )
end
```

One new thing here is I used named matches, calling the first portion `word` and the second `index`. Then I can access these values from the match object directly by name, `m["index"]`, `m["word"]`

### Racket

Yeah, typed Racket. It seemed interesting and I wanted to try it out, but I'm undecided if it is a good fit for such a list-based language. I struggled mightily passing a list, like the result of a regex match, which I knew would either have a value of `false` or be a list of strings of length 3, but I could not get the compiler to know it.

```racket
(struct word-idx ([token : String] [word : String] [idx : Integer]))

(: build-word-idx (-> String String (U String Number) word-idx))
(define (build-word-idx token word idx)
  (if (string? idx)
      (word-idx token word (assert (string->number idx) exact-integer?))
      (word-idx token word (assert idx exact-integer?))))

(define (good-match? (l : (U (Listof Any) False)))
  (and l (andmap string? l) (eq? (length l) 3)))

(: split-word-idx (-> String (U word-idx False)))
(define (split-word-idx token)
  (let ([pattern #px"^(\\w+?)(\\d+)$"])
    (let ([capture (regexp-match pattern token)])
      (if (good-match? capture)
          (apply build-word-idx (cast capture (List String String String)))
          #f))))

(: unshuffle-string (-> String String))
(define (unshuffle-string s)
  (let* ([splitted (string-split s)]
         [index-list (sort (filter word-idx? (map split-word-idx splitted))
                           (lambda ([x : word-idx] [y : word-idx])
                             (> (word-idx-idx x) (word-idx-idx y))))])
    (if (null? index-list)
        ""
        (let loop ([input-list index-list]
                   [out-list : (Listof String) '()]
                   [current-idx (word-idx-idx (car index-list))])
          (if (null? input-list)
              (string-join out-list)
              (let ([top-item (car input-list)])
                (cond
                  [(> current-idx (word-idx-idx top-item))
                   (loop input-list (cons "REDACTED" out-list) (sub1 current-idx))]
                  [else
                   (loop (cdr input-list)
                         (cons (word-idx-word top-item) out-list)
                         (sub1 current-idx))])))))))
```

Specifically here

```racket
(: split-word-idx (-> String (U word-idx False)))
(define (split-word-idx token)
  (let ([pattern #px"^(\\w+?)(\\d+)$"])
    (let ([capture (regexp-match pattern token)])
      (if (good-match? capture)
          (apply build-word-idx (cast capture (List String String String)))
          #f))))
```

The best I could do was to `cast` the list to be a list of 3 strings, which the documantation warned me could be a performance drag.

Overall the solution here is similar to the design of the others. Instead of a dictionary I sort the list of word-index objects, and I sort them in descending order so I can build the final word backwards, since appending to the beginning of a list is much preferred.

## Task 2: Reverse Word

> Task 2: Reverse Word</br>
> Submitted by: Mohammad Sajid Anwar</br>
> You are given a word, $word and a character, $char.</br>
> </br>
> Write a script to replace the substring up to and including $char with its characters sorted alphabetically. If the $char doesn’t exist then DON'T do anything.</br>
> </br>
> Example 1</br>
> Input: $str = "challenge", $char = "e"</br>
> Ouput: "acehllnge"</br>
> </br>
> Example 2</br>
> Input: $str = "programming", $char = "a"</br>
> Ouput: "agoprrmming"</br>
> </br>
> Example 3</br>
> Input: $str = "champion", $char = "b"</br>
> Ouput: "champion"

Nary a loose end to be figured out for this, as far as I can see.

### Perl

```perl
sub reverse_substring( $char, $string ) {
    my $idx = index $string, $char;
    my @chars = split '', $string;
    return join '', (
	( sort @chars[0..$idx] ),
	@chars[$idx+1..$#chars]
	);
}
```

Find the first index of the character, split the list at that index, sort the first part and append back together. Easy! Plus, if the char isn't found, then the index is -1 and sorted part of the list is empty and the result is as desired.

### Julia

```julia
function reverse_substring( char, string )
    index = findfirst( char, string )
    if isnothing(index)
        return string
    end

    chars = split( string, "" )
    join( vcat( ( sort( chars[1:index] ) ), chars[index+1:end] ), "" )
end
```

Again very similar to the Perl solution. How very unlike me. I try to make the solutions unique to each language, but Julia just allows a very similar solution as Perl, on account fo the influence I'm sure. 

The main difference here is that I explicitly check if the `findfirst` (find index) failed, in which case I directly return the input string

### Racket

After my struggle with typed Racket on the first challenge I was not looking forward to this one, but I got the type signature correct almost from the very start. So I went from deeming typed Racket a failed experiment for me, to something I may keep trying with.

```racket
(: sort-string-to-char (-> String Char String))
(define (sort-string-to-char str c)
  (let ([char-list (string->list str)])
    (let loop ([prefx : (Listof Char) '()]
               [suffix : (Listof Char) char-list])
      (cond
        [(null? suffix) str]
        [(eq? (car suffix) c)
         (list->string (append (sort (cons (car suffix) prefx) char<?) (cdr suffix)))]
        [else (loop (cons (car suffix) prefx) (cdr suffix))]))))
```

This is a function that takes a String and a Char and returns a String, no tricky polymorphous lists to typify. 

Inside the function we make a recursive let (a loop really) that builds a list of prefix chars from the input chars until it finds a char that matches the input character. Then it sorts the prefix list (we build it backwards for easiness again, and here it doesn't matter because we end up sorting it) and appends it to the remaining string characters. If we run out of string characters without seeing the match char, then we just return the input string.

## Conclusion

Good challenges again. See you next week!
