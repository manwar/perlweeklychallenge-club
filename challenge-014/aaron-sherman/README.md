# Solutions by Aaron Sherman.

## Challenge #1: Van Eck’s sequence

This week's first puzzle happens to be one that I just finished
adding to [`Math::Sequences::Integer`](https://github.com/ajs/perl6-Math-Sequences)
so my solution is an underwhelming reference to and plug for that
module. [Here is the specific definition](https://github.com/ajs/perl6-Math-Sequences/blob/cb8d9f58092718f85debf68d2f183288741bdfad/lib/Math/Sequences/Numberphile.pm#L196).

## Challenge #2: State Words

My solution is pretty simple. It uses Perl 6's powerful regex engine
to match the state abbreviations against a wordlist. A short example
wordlist is provided, but it can also use a web version that is VERY
large and then the solution takes much longer (feels like a performance
bug to me).

### Examples

    $ ./us-words.p6
    decade
    $ ./us-words.p6 --verbose
    Delaware + California + Delaware = decade
