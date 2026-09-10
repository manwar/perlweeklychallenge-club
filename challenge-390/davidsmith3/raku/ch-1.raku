#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 390 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Decode String

You are given an encoded string.

Write a script to return the decoded string of the given encoded string.

The encoding rule is: K[encoded_string], where the encoded_string inside the square brackets is repeated exactly K > 0 times.

=head3 Example 1:

Input: $str = "2[3[a]]"
Output: "aaaaaa"

3[a]    => aaa
2[3[a]] => aaa aaa

=head3 Example 2:

Input: $str = "10[a]"
Output: "aaaaaaaaaa"

=head3 Example 3:

Input: $str = "a2[b]c3[d]e"
Output: "abbcddde"

=head3 Example 4:

Input: $str = "2[a2[b]c]"
Output: "abbcabbc"

=head3 Example 5:

Input: $str = "1[a]2[b3[c]]"
Output: "abcccbccc"

=end pod

grammar Decoder {
    regex TOP { <sequence> }
    regex sequence { <term> <term>* }
    regex term { <char> | <qty> '[' <sequence> ']' }
    regex qty { <[1..9]> <[0..9]>* }
    regex char { <[a..z]> } # assuming from examples
}

class DecoderActions {
    method TOP($/) { make $<sequence>.made }
    method sequence($/) { make $<term>.map({ .made }).join }
    method term($/) { make $<char> ?? $<char>.made !! $<sequence>.made x $<qty>.made }
    method qty($/) { make +$/ }
    method char($/) { make ~$/ }
}

sub decode-string(Str:D $str --> Str:D) {
    my $result = Decoder.parse($str, :actions(DecoderActions));
    die "Unable to parse $str" unless $result;
    $result.made
}

#| decode STR
multi MAIN(Str:D $str) {
    say decode-string($str);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => "2[3[a]]", output => "aaaaaa"));
    @tests.push(%( input => "10[a]", output => "aaaaaaaaaa"));
    @tests.push(%( input => "a2[b]c3[d]e", output => "abbcddde"));
    @tests.push(%( input => "2[a2[b]c]", output => "abbcabbc"));
    @tests.push(%( input => "1[a]2[b3[c]]", output => "abcccbccc"));
    @tests.push(%( input => "a", output => "a"));
    @tests.push(%( input => "ab", output => "ab"));
    @tests.push(%( input => "aba", output => "aba"));
    @tests.push(%( input => "3[a]", output => "aaa"));
    @tests.push(%( input => "3[abc]", output => "abcabcabc"));

    my @should-throw;
    @should-throw.push(%( input => "" ));
    @should-throw.push(%( input => "0[a]" ));
    @should-throw.push(%( input => "3[a" ));
    @should-throw.push(%( input => "3a]" ));
    @should-throw.push(%( input => "A" ));
    @should-throw.push(%( input => "%" ));

    plan @tests + @should-throw + 3;
    for @tests {
        is decode-string(.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        throws-like { decode-string(.<input>) }, Exception, "dies on { .<input> }", message => /'Unable to parse'/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, '2[3[a]]', :out, :err);
    is $proc.out.slurp(:close).trim, 'aaaaaa', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
