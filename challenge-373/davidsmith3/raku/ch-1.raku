#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 373 Task 1 
Submitted by: Mohammad Sajid Anwar
=CHALLENGE
You are given two arrays of strings.

Write a script to return true if the two given array represent the same strings otherwise false.

=head3 Example 1:
Input: @arr1 = ("a", "bc")
       @arr2 = ("ab", "c")
Output: true

Array 1: "a" + "bc" = "abc"
Array 2: "ab" + "c" = "abc"

=head3 Example 2:
Input: @arr1 = ("a", "b", "c")
       @arr2 = ("a", "bc")
Output: true

Array 1: "a" + "b" + "c" = "abc"
Array 2: "a" + "bc" = "abc"

=head3 Example 3:
Input: @arr1 = ("a", "bc")
       @arr2 = ("a", "c", "b")
Output: false

Array 1: "a" + "bc" = "abc"
Array 2: "a" + "c" + "b" = "acb"

=head3 Example 4:
Input: @arr1 = ("ab", "c", "")
       @arr2 = ("", "a", "bc")
Output: true

Array 1: "ab" + "c" + "" = "abc"
Array 2: ""  + "a" + "bc" = "abc"

=head3 Example 5:
Input: @arr1 = ("p", "e", "r", "l")
       @arr2 = ("perl",)
Output: true

Array 1: "p" + "e" + "r" + "l" = "perl"
Array 2: "perl"

=end pod

sub my-sub(@arr1 where .all ~~ Str:D, @arr2 where .all ~~ Str:D --> Bool) {
    @arr1.join eq @arr2.join;
}

#| determine if comma separated arr1 and arr2 are equal lists
multi MAIN(Str:D $arr1, Str:D $arr2) {
    say my-sub($arr1.split(","), $arr2.split(","));
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    @tests.push(%{ input => (List.new, List.new), output => True });
    @tests.push(%{ input => (List.new, ("q",)), output => False });
    @tests.push(%{ input => (("",), ("",)), output => True });
    @tests.push(%{ input => (("", ""), ("", "")), output => True });
    @tests.push(%{ input => ((" ", " "), (" ", " ")), output => True });
    @tests.push(%{ input => (("raku",), ("r", "a", "k", "u")), output => True });

    my @should-throw;
    @should-throw.push(%{ input => ((1,2,3), (1,2,3))});
    @should-throw.push(%{ input => (("a",), (1,)) });
    @should-throw.push(%{ input => (("a", True), ("a", True))});
    
    plan @tests + @should-throw;
    for @tests {
        is my-sub(|.<input>), .<output>, "{.<input>}";
    }
    for @should-throw {
        dies-ok { my-sub(|.<input>) }, "dies on { .<input> }";
    }
}

sub extract-tests(--> Array[Hash]) {
    my Hash @tests;
    my $list = / '(' <-[(]>* ')' /;
    my $bool = / << [ [t|T] rue | [f|F] alse ] >> /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / ($list) .* ($list) .* ($bool)  / {
                @tests.push(%{ input => ($0.EVAL, $1.EVAL), output => $2.tc.EVAL });
            }
        }
    }
    @tests;
}
