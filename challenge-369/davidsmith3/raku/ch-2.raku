#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Challenge 369 Task 2
Submitted by: Mohammad Sajid Anwar
=CHALLENGE
You are given a string, group size and filler character.

Write a script to divide the string into groups of given size. In the last group if the string doesn’t have enough characters remaining fill with the given filler character.

=head3 Example 1:
Input: $str = "RakuPerl", $size = 4, $filler = "*"
Output: ("Raku", "Perl")

=head3 Example 2:
Input: $str = "Python", $size = 5, $filler = "0"
Output: ("Pytho", "n0000")

=head3 Example 3:
Input: $str = "12345", $size = 3, $filler = "x"
Output: ("123", "45x")

=head3 Example 4:
Input: $str = "HelloWorld", $size = 3, $filler = "_"
Output: ("Hel", "loW", "orl", "d__")

=head3 Example 5:
Input: $str = "AI", $size = 5, $filler = "!"
Output: "AI!!!"

=end pod

subset PositiveInt of Int where * > 0;
subset Char of Str where *.chars == 1;

multi my-sub(Str:D $str, PositiveInt $size, Char $filler --> Seq) {
    my $s = $str;
    my $mod = $str.chars % $size;
    if $mod != 0 {
        $s ~= $filler x ($size - $mod);
    }
    $s.comb($size);
}

multi my-sub(Str:D $str, Int:D $size, Str:D $filler) {
    die "Unexpected input, received $str, $size, $filler";
}

#| group str into chunks of length size using filler to round
multi MAIN(Str:D $str, Int:D $size, Str:D $filler) {
    say my-sub($str, +$size, $filler);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    @tests.push(%{ input => ("", 4, "*"), output => "" }); # assumed this behavior
    @tests.push(%{ input => ("foo", 1, "*"), output => ("f", "o", "o") });
    @tests.push(%{ input => ("f", 2, "*"), output => "f*" });

    my @should-throw;
    @should-throw.push(%{ input => ("", 0, "*") }); 
    @should-throw.push(%{ input => ("", -1, "*") });
    @should-throw.push(%{ input => ("", 1, "") });
    @should-throw.push(%{ input => ("", 1, "**") });

    plan @tests + @should-throw;
    # example 5 has a Str output, fortunately is ("foo"), "foo" is True
    for @tests {
        is my-sub(|.<input>), .<output>, "{.<input>}";
    }
    for @should-throw {
        dies-ok { my-sub(|.<input>) }, "dies on {.<input>}";
    }
}

sub extract-tests(--> Array[Hash]) {
    my Hash @tests;
    my $string = / '"' <-["]>* '"' /;
    my $int = / << \d+ >> /;
    my $list = / '(' <-[)]>* ')' /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / ($string) .* ($int) .* ($string)  .* ($list) / {
                @tests.push(%{ input => ($0.EVAL, +$1, $2.EVAL), output => $3.EVAL });
            } elsif $text ~~ / ($string) .* ($int) .* ($string)  .* ($string) / {
                @tests.push(%{ input => ($0.EVAL, +$1, $2.EVAL), output => $3.EVAL });
            }
        }
    }
    @tests;
}
