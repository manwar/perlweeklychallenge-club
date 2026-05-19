#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 374 Task 2
Submitted by: Mohammad Sajid Anwar
=CHALLENGE
You are given a string containing 0-9 digits only.

Write a script to return the largest number with all digits the same in the given string.

=head3 Example 1:
Input: $str = "6777133339"
Output: 3333

=head3 Example 2:
Input: $str = "1200034"
Output: 4

=head3 Example 3:
Input: $str = "44221155"
Output: 55

=head3 Example 4:
Input: $str = "88888"
Output: 88888

=head3 Example 5:
Input: $str = "11122233"
Output: 222

=end pod

subset Digits of Str where / ^ \d+ $ /; # assume there is at least one number

multi largest-same-digits(Digits $str, --> Int) {
    # handle the special case if string is all zeros
    # then collect by digit, the highest quantity is the largest integer
    # in case of a tie, use the digit itself
    # examples all have the runs contiguous, but specification doesn't require
    return 0 if $str ~~ / ^ 0+ $ /;
    my $longest = $str.comb.grep(* > 0).Bag.max({ .value, .key });
    +($longest.key x $longest.value);
}

multi largest-same-digits($str) {
    die "Unexpected input $str";
}

#| find longest same-digits number in str
multi MAIN(Str:D $str) {
    say largest-same-digits($str);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    @tests.push(%{ input => "0", output => 0 });
    @tests.push(%{ input => "00", output => 0 });
    @tests.push(%{ input => "2211122", output => 2222 }); # assuming digits do not need to be contiguous
    my @should-throw;
    @should-throw.push(%{ input => "" });
    @should-throw.push(%{ input => "abc" });

    plan @tests + @should-throw;
    for @tests {
        is largest-same-digits(.<input>), .<output>, "{ .<input> }";
    }

    for @should-throw {
        dies-ok { largest-same-digits(.<input>) }, "dies on { .<input> }";
    }
}

sub extract-tests(--> Array[Hash]) {
    my Hash @tests;
    my $string = / '"' <-["]>* '"' /;
    my $int = / << \d+ >> /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / ($string) .* ($int)  / {
                @tests.push(%{ input => $0.EVAL, output => +$1 });
            }
        }
    }
    @tests;
}
