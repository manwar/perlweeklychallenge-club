#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Challenge 372 Task 1 Rearrange Spaces
Submitted by: Mohammad Sajid Anwar
=CHALLENGE
You are given a string text of words that are placed among number of spaces.

Write a script to rearrange the spaces so that there is an equal number of spaces between every pair of adjacent words and that number is maximised. If you can’t distribute, place the extra spaces at the end. Finally return the string.

=head3 Example 1:
Input: $str = "  challenge  "
Output: "challenge    "

We have 4 spaces and 1 word. So all spaces go to the end.

=head3 Example 2:
Input: $str = "coding  is  fun"
Output: "coding  is  fun"

We have 4 spaces and 3 words (2 gaps). So 2 spaces per gap.

=head3 Example 3:
Input: $str = "a b c  d"
Output: "a b c d "

We have 4 spaces and 4 words (3 gaps). So 1 space per gap and 1 remainder.

=head3 Example 4:
Input: $str = "  team      pwc  "
Output: "team          pwc"

We have 10 spaces and 2 words (1 gap). So 10 spaces per gap.

=head3 Example 5:
Input: $str = "   the  weekly  challenge  "
Output: "the    weekly    challenge "

We have 9 spaces and 3 words (2 gaps). So 4 spaces per gap and 1 remainder.

=end pod

my constant $SPACE = ' ';
subset WordOrSpace of Str where / ^ [\w | $SPACE ]* $ /;

multi my-sub(WordOrSpace $str --> Str:D) {
    my @words = $str.split($SPACE, :skip-empty);
    return $str if @words == 0;
    my $spaces = $str.comb($SPACE).elems;
    return @words[0] ~ $SPACE x $spaces if @words == 1;
    my $gaps = @words - 1;
    my $equal-gap = $SPACE x ($spaces div $gaps);
    my $right-gap = $SPACE x ($spaces % $gaps);
    @words.join($equal-gap) ~ $right-gap;
}

multi my-sub(Str:D $str) {
    die "Unexpected input character in $str";
}

#| rearrange spaces for str
multi MAIN(Str:D $str) {
    say "'{my-sub($str)}'";
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%{ input =>  "  challenge  ",
                   output => "challenge    " });
    @tests.push(%{ input =>  "coding  is  fun",
                   output => "coding  is  fun" });
    @tests.push(%{ input =>  "a b c  d",
                   output => "a b c d " });
    @tests.push(%{ input =>  "  team      pwc  ",
                   output => "team          pwc" });
    @tests.push(%{ input =>  "   the  weekly  challenge  ",
                   output => "the    weekly    challenge " });
    @tests.push(%{ input =>  "",
                   output => "" });    
    @tests.push(%{ input =>  " ",
                   output => " " });    
    @tests.push(%{ input =>  "  ",
                   output => "  " });    
    @tests.push(%{ input =>  "    challenge",
                   output => "challenge    " });

    my @should-throw;
    @should-throw.push(%{ input => "a\tb" });

    plan @tests + @should-throw;
    for @tests {
        is my-sub(.<input>), .<output>, "{.<input>}";
    }

    for @should-throw {
        dies-ok { my-sub(.<input>) }, "dies on {.<input>}";
    }
}

