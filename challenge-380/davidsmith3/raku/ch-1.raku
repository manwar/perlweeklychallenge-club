#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 380 Task 1

Submitted by: Mohammad Sajid Anwar

=head2 Sum of Frequencies

You are given a string consisting of English letters.

Write a script to find the vowel and consonant with maximum frequency. Return the sum of two frequencies.

=head3 Example 1:

Input: $str = "banana"
Output: 5

Vowel: "a" appears 3 times.
Consonant: "n" appears 2 times, "b" appears 1 time.

Max frequency of vowel: 3
Max frequency of consonant: 2

=head3 Example 2:

Input: $str = "teestett"
Output: 7

Vowel: "e" appears 3 times.
Consonant: "t" appears 4 times, "s" appears 1 time.

Max frequency of vowel: 3
Max frequency of consonant: 4

=head3 Example 3:

Input: $str = "aeiouuaa"
Output: 3

Vowel: "a" appears 3 times, "u" 2 times, "e", "i", "o" 1 time each.
Consonant: None.

Max frequency of vowel: 3
Max frequency of consonant: 0

=head3 Example 4:

Input: $str = "rhythm"
Output: 2

Vowel: None
Consonant: "h" appears 2 times, "r", "y", "t", "m" 1 time each.

Max frequency of vowel: 0
Max frequency of consonant: 2

=head3 Example 5:

Input: $str = "x"
Output: 1

Vowel: None
Consonant: "x" appears 1 time.

Max frequency of vowel: 0
Max frequency of consonant: 1

=end pod

subset WordChars of Str:D where / ^ <[a..zA..Z]>+ $/;

sub sum-frequencies(WordChars $str --> Int) {
    my $vowels = BagHash.new;
    my $consonants = BagHash.new;
    "aeiou".contains($_) ?? $vowels.add($_) !! $consonants.add($_) for $str.lc.comb;
    my $v-max = $vowels ?? $vowels.max({ .value }).value !! 0;
    my $c-max = $consonants ?? $consonants.max({ .value }).value !! 0;
    $v-max + $c-max;
}

#| find sum of frequencies of str
multi MAIN(Str:D $str){
    say sum-frequencies($str);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => "banana", output => 5 ));
    @tests.push(%( input => "teestett", output => 7 ));
    @tests.push(%( input => "aeiouuaa", output => 3 ));
    @tests.push(%( input => "rhythm", output => 2 ));
    @tests.push(%( input => "x", output => 1 ));
    @tests.push(%( input => "AaBb", output => 4 )); # assuming case insensitivity
    my @should-throw;
    @should-throw.push(%( input => "" ));
    @should-throw.push(%( input => "a4" ));
    @should-throw.push(%( input => "z!" ));

    plan @tests + @should-throw + 3;
    for @tests {
        is sum-frequencies(.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        dies-ok { sum-frequencies(.<input>) }, "dies on { .<input> }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, "x", :out, :err);
    is $proc.out.slurp(:close).trim, '1', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
