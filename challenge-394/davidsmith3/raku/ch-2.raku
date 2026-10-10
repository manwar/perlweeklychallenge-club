#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 394 Task 2

Submitted by: Mohammad Sajid Anwar
=head2 Alternating Vowels Consonants

You are given three strings containing English alphabetic characters.

Find all the longest contiguous substrings common to all three strings that strictly alternate between vowels and consonants.

=head3 Example 1:

Input: @str = ("relocate", "delocate", "allocate")
Output: ("locate")

=head3 Example 2:

Input: @str = ("apple", "banana", "cherry")
Output: ()

=head3 Example 3:

Input: @str = ("navigate", "cavity", "gravity")
Output: ("avi")

=head3 Example 4:

Input: @str = ("pedalgia", "pedalboard", "pedantic")
Output: ("peda")

=head3 Example 5:

Input: @strings = ("schoolmaster", "schoolhouse", "schooling")
Output: ("ho", "ol")

=end pod

my constant VOWEL = "aeiou";

sub is-alternating(Str:D $s --> Bool) {
    my $is-vowel = VOWEL.contains($s.substr(0, 1));
    for 1..^$s.chars -> $i {
        my $curr-is-vowel = VOWEL.contains($s.substr($i, 1));
        return False if $is-vowel !^^ $curr-is-vowel;
        $is-vowel = $curr-is-vowel;
    }
    True;
}

multi alternating-vowels-consonants(@str where .elems == 3 && .all ~~ / ^ <[a..zA..Z]>+ $ / --> List) {
    my @result;
    my @str-insensitive = @str.map({ .lc });
    my $shortest = @str-insensitive.min({ .chars });
    for 0..^$shortest.chars -> $start {
        for 1..($shortest.chars-$start) -> $len {
            my $curr = $shortest.substr($start, $len);
            last unless is-alternating($curr);
            last unless all(@str-insensitive.map({ .contains($curr) }));
            @result.push($curr);
        }
    }
    my $max-len = @result.max({ .chars }).chars;
    @result.unique.grep({ .chars == $max-len }).List;
}

multi alternating-vowels-consonants(@str) {
    die "Unexpected input {@str}";
}

#| return longest substrings containing alternating vowels and consonants
multi MAIN(*@str) {
    say alternating-vowels-consonants(@str);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => ("relocate", "delocate", "allocate"), output => ("locate",)));
    @tests.push(%( input => ("apple", "banana", "cherry"), output => ()));
    @tests.push(%( input => ("navigate", "cavity", "gravity"), output => ("avi",)));
    @tests.push(%( input => ("pedalgia", "pedalboard", "pedantic"), output => ("peda",)));
    @tests.push(%( input => ("schoolmaster", "schoolhouse", "schooling"), output => ("ho", "ol")));
    @tests.push(%( input => ("aba", "aba", "aba"), output => ("aba",)));
    @tests.push(%( input => ("a", "a", "a"), output => ("a",)));
    @tests.push(%( input => ("a", "A", "a"), output => ("a",))); # assume case-insensitive

    my @should-throw;
    @should-throw.push(%( input => ("foo", )));
    @should-throw.push(%( input => ("foo", "bar", "baz", "quz")));
    @should-throw.push(%( input => ("foo", "bar!", "baz")));
    @should-throw.push(%( input => ("foo4", "bar", "baz")));
    @should-throw.push(%( input => ("foo", "bar", "baz_")));
    @should-throw.push(%( input => ("foo", "bar", "")));

    plan @tests + @should-throw + 3;
    for @tests {
        is-deeply alternating-vowels-consonants(.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        throws-like { alternating-vowels-consonants(.<input>) }, Exception, "dies on { .<input> }", message => /Unexpected/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, 'ab', 'abab', 'ababab', :out, :err);
    is $proc.out.slurp(:close).trim, '(ab)', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
