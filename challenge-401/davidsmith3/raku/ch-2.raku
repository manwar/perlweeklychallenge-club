#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 401 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Reconstruct Digits

You are given a string containing an out-of-order English representation of digits 0-9.

Write a script to return the digits in ascending order.

=head3 Example 1:

Input: $str = "zroezerotwotwotwo"
Output: "00222"

'z' appears two times => two "zero"
'w' appears three times => three "two"

=head3 Example 2:

Input: $str = "sveeeinght"
Output: "78"

'g' appears one time => one "eight"
Removing the letters of "eight" leaves "sveen".
Now 'v' appears one time => one "seven"

=head3 Example 3:

Input: $str = "onenineninefive"
Output: "1599"

'f' appears one time => one "five"
After removing "five", 'o' appears one time => one "one".
The remaining letters are "ninenine", where 'i' appears two times => two "nine".

=head3 Example 4:

Input: $str = "zeroonetwothreeeightfivesixsevenninefour"
Output: "0123456789"

The input contains the scrambled letters of every single digit from 0 through 9 exactly once:
"zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine".

=head3 Example 5:

Input: $str = "ninenineninenine"
Output: "9999"

Character counts: 'n' = 8, 'i' = 4, 'e' = 4.
Every set of letters matches "nine", giving four 9s.

=end pod

sub extract-letter(Str:D $letter, Str:D $word, Int:D $digit, Str:D $str --> List) {
    my @result;
    my $s = $str;
    while $s.contains($letter) {
        # letter is in the string, so we remove all the letters in word and
        # add digit to the result
        my $prev = $s.chars;
        for $word.comb -> $target {
            $s .= subst($target, '');
            die "Letter $target not found" unless $s.chars == $prev - 1;
            $prev = $s.chars;
        }
        @result.push($digit);
    }
    (@result, $s);
}

sub reconstruct-digits(Str:D $str --> Str:D) {
    my $s = $str.lc;
    my @result;

    # g is only present in 'eight', u in 'four', and so on.
    my @unique = [("g", "eight", 8),
                  ("u", "four", 4),
                  ("w", "two", 2),
                  ("x", "six", 6),
                  ("z", "zero", 0),
                  # after the first group is removed, f positively identifies 'five'...
                  ("f", "five", 5),
                  ("s", "seven", 7),
                  ("t", "three", 3),
                  # now i positively identifies 'nine'
                  ("i", "nine", 9),
                  # only 'one' remains
                  ("o", "one", 1)];
    for @unique -> ($letter, $word, $digit) {
        my ($digits, $new-s) = extract-letter($letter, $word, $digit, $s);
        @result.append(@$digits);
        $s = $new-s;
    }
    die "Unmatched characters $s" unless $s eq "";
    @result.sort.join;
}

#| return STR converted to digits and sorted
multi MAIN(Str:D $str) {
    say reconstruct-digits($str);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => "zroezerotwotwotwo",
                   output => "00222"));
    @tests.push(%( input => "sveeeinght",
                   output => "78"));
    @tests.push(%( input => "onenineninefive",
                   output => "1599"));
    @tests.push(%( input => "zeroonetwothreeeightfivesixsevenninefour",
                   output => "0123456789"));
    @tests.push(%( input => "ninenineninenine",
                   output => "9999"));
    @tests.push(%( input => "",
                   output => ""));
    @tests.push(%( input => "ThrEe",
                   output => "3"));
    @tests.push(%( input => "itovnneveoewfes",
                   output => "1257"));
    @tests.push(%( input => "heieogeiwntgihtnt",
                   output => "2889"));
    @tests.push(%( input => "zesooveeentehrtrw",
                   output => "0237"));
    @tests.push(%( input => "trreehtorefhereueht",
                   output => "3334"));
    @tests.push(%( input => "voinnhnrtgtwiotoivzereesixrufseenheeeoef",
                   output => "0123456789"));
    my @should-throw;
    @should-throw.push(%( input => "zer", msg => /Letter/ ));
    @should-throw.push(%( input => "a", msg => /Unmatched/ ));
    @should-throw.push(%( input => "zerro", msg => /Unmatched/ ));

    plan @tests + @should-throw + 3;
    for @tests {
        is reconstruct-digits(.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        throws-like { reconstruct-digits(.<input>) },
                    Exception,
                    "dies on { .<input> }",
                    message => .<msg>;
    }
    my $proc = run($*EXECUTABLE, $?FILE, 'zero', :out, :err);
    is $proc.out.slurp(:close).trim, '0', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
