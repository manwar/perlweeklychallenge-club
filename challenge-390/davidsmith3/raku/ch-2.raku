#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 390 Task 2

Submitted by: Mohammad Sajid Anwar
=head2 Order Characters

You are given a string $s (containing only alphabetic characters) and an integer $k > 0.

Write a script to choose one of the first $k letters of given string and append it at the end of the string. You keep doing this until you have lexicographically smallest string and return the string.

=head3 Example 1:

Input: $str = "dbca", $k = 1
Output: "adbc"

Move 1: "bcad"
Move 2: "cadb"
Move 3: "adbc"

=head3 Example 2:

Input: $str = "geeks", $k = 2
Output: "eegks"

First 2 letters: "g", "e"

Move 1: "gekse" (move second letter "e")
Move 2: "gksee" (move second letter "e")
Move 3: "kseeg"
Move 4: "seegk"
Move 5: "eegks"

=head3 Example 3:

Input: $str = "cbaed", $k = 3
Output: "abcde"

First 3 letters: "c", "b", "a"

Move 1: "cbeda"  (move "a")
Move 2: "cedab"  (move "b")
Move 3: "edabc"  (move "c")
Move 4: "eabcd"  (move "d")
Move 5: "abcde"  (move "e")

=head3 Example 4:

Input: $str = "fedcba", $k = 4
Output: "abcdef"

First 4 letters: "f", "e", "d", "c"

Move 1: "fdcbae" (move "e")
Move 2: "dcbaef" (move "f")
Move 3: "dcbefa" (move "a")
Move 4: "dcefab" (move "b")
Move 5: "defabc" (move "c")
Move 6: "efabcd" (move "d")
Move 7: "fabcde" (move "e")
Move 8: "abcdef" (move "f")

=head3 Example 5:

Input: $str = "perl", $k = 1
Output: "erlp"

Move 1: "erlp" (move "p")

=head3 Example 6:

Input: $str = "oloolooo", $k = 1
Output: "looloooo"

=head3 Example 7:

Input: $str = "oloooolo", $k = 1
Output: "looloooo"

=end pod

multi order-characters(Str:D $str where / ^ <[a..zA..Z]>* $ /, Int:D $k where * > 0 --> Str) {
    return $str if $str eq '';
    return $str.comb.sort.join if $k > 1;          # k > 1 - can use bubble sort
    my @result;
    my $s = $str;
    for ^$s.chars {                                # k = 1 - order cannot change
        @result.append($s);                        # rotate through all start positions
        $s = $s.substr(1) ~ $s.substr(0, 1);       # and return the lexicographic minimum
    }
    @result.min;
}

multi order-characters(Str:D $str, Int:D $k) {
    die "Expected STR with alphabetic characters and a positive K.  Received $str and $k";
}

#| reorder STR by choosing from first K letters and appending to end
multi MAIN(Str:D $str, Int:D $k) {
    say order-characters($str, $k);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => ("dbca", 1), output => "adbc"));
    @tests.push(%( input => ("geeks", 2), output => "eegks"));
    @tests.push(%( input => ("cbaed", 3), output => "abcde"));
    @tests.push(%( input => ("fedcba", 4), output => "abcdef"));
    @tests.push(%( input => ("perl", 1), output => "erlp"));
    @tests.push(%( input => ("oloolooo", 1), output => "looloooo"));
    @tests.push(%( input => ("oloooolo", 1), output => "looloooo"));
    @tests.push(%( input => ("Perl", 1), output => "Perl"));
    @tests.push(%( input => ("", 1), output => ""));
    @tests.push(%( input => ("", 100), output => ""));
    @tests.push(%( input => ("a", 1), output => "a"));
    @tests.push(%( input => ("a", 100), output => "a"));
    @tests.push(%( input => ("oloolooo", 2), output => "lloooooo"));
    @tests.push(%( input => ("oloooolo", 2), output => "lloooooo"));

    my @should-throw;
    @should-throw.push(%( input => ("5", 1) ));
    @should-throw.push(%( input => ("foo", -1) ));
    @should-throw.push(%( input => ("foo", 0) ));

    plan @tests + @should-throw + 3;
    for @tests {
        is order-characters(|.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        throws-like { order-characters(|.<input>) }, Exception, "dies on { .<input> }", message => /Expected/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, 'raku', '1', :out, :err);
    is $proc.out.slurp(:close).trim, 'akur', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
