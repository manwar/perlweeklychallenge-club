#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 398 Task 2

Submitted by: Mohammad Sajid Anwar
=head2 String Difference

You are given an array of equal length strings.

Write a script to find the difference integer array of each word in the given array. There will be one word with a different array; return that word.

Each words[i] can be converted into a difference integer array difference[i] of length n - 1 where difference[i][j] = words[i][j+1] - words[i][j]

=head3 Example 1:

Input: @words = ("ab", "bc", "cd", "zy")
Output: "zy"

"ab" => [1 - 0] = [1]
"bc" => [2 - 1] = [1]
"cd" => [3 - 2] = [1]
"zy" => [24 - 25] = [-1]

=head3 Example 2:

Input: @words = ("cba", "fed", "azy")
Output: "azy"

"cba" => [1 - 2, 0 - 1] = [-1, -1]
"fed" => [4 - 5, 3 - 4] = [-1, -1]
"azy" => [25 - 0, 24 - 25] = [25, -1]

=head3 Example 3:

Input: @words = ("pop", "ada", "beb", "cfc")
Output: "pop"

"pop" => [14 - 15, 15 - 14] = [-1, 1]
"ada" => [3 - 0, 0 - 3] = [3, -3]
"beb" => [4 - 1, 1 - 4] = [3, -3]
"cfc" => [5 - 2, 2 - 5] = [3, -3]

=head3 Example 4:

Input: @words = ("aaaa", "zzzz", "mmmm", "aaba")
Output: "aaba"

"aaaa" => [0 - 0, 0 - 0, 0 - 0] = [0, 0, 0]
"zzzz" => [25 - 25, 25 - 25, 25 - 25] = [0, 0, 0]
"mmmm" => [12 - 12, 12 - 12, 12 - 12] = [0, 0, 0]
"aaba" => [0 - 0, 1 - 0, 0 - 1] = [0, 1, -1]

=head3 Example 5:

Input: @words = ("aceg", "bdfh", "cegi", "azbz")
Output: "azbz"

"aceg" => [2 - 0, 4 - 2, 6 - 4] = [2, 2, 2]
"bdfh" => [3 - 1, 5 - 3, 7 - 5] = [2, 2, 2]
"cegi" => [4 - 2, 6 - 4, 8 - 6] = [2, 2, 2]
"azbz" => [25 - 0, 1 - 25, 25 - 1] = [25, -24, 24]

=end pod

my %ALPHA = 'abcdefghijklmnopqrstuvwxyz'.comb.antipairs;

sub string-difference(@arr --> Str) {
    die "Unexpected input @arr[] - must be at least three strings" unless @arr.elems >= 3;
    die "Unexpected input @arr[] - must be all strings" unless @arr.all ~~ Str:D;
    die "Unexpected input @arr[] - all strings must be the same length" unless [==] @arr.map({ .chars });
    die "Unexpected input @arr[] - all strings must contain only lowercase letters" unless @arr.all ~~ / ^ <[a..z]>+ $ /;

    my @differences = @arr.map({ $_.comb.rotor(2 => -1).map({ %ALPHA{.tail} - %ALPHA{.head} })})
                          .map({ .join(',') });
    my $unique = @differences.Bag.grep({ .value == 1 }).map({ .key });
    die "Unexpected input @arr[] - must have exactly one unique difference" unless $unique.elems == 1;
    my %h = @differences Z=> @arr;
    %h{$unique[0]};
}

#| return word from ARR with different difference array
multi MAIN(*@arr) {
    say string-difference(@arr);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => ("ab", "bc", "cd", "zy"), output => "zy"));
    @tests.push(%( input => ("cba", "fed", "azy"), output => "azy"));
    @tests.push(%( input => ("pop", "ada", "beb", "cfc"), output => "pop"));
    @tests.push(%( input => ("aaaa", "zzzz", "mmmm", "aaba"), output => "aaba"));
    @tests.push(%( input => ("aceg", "bdfh", "cegi", "azbz"), output => "azbz"));
    @tests.push(%( input => ("ab", "ab", "ab", "ba", "ab", "ab", "ab"), output => "ba"));

    my @should-throw;
    @should-throw.push(%( input => ("a", "ab", "cd") ));
    @should-throw.push(%( input => ("ab",) ));           # there needs to be three for one to be different
    @should-throw.push(%( input => ("ab", "ab") ));
    @should-throw.push(%( input => ("a", "a", "a") ));
    @should-throw.push(%( input => ("ab", "ab", "ab") ));
    @should-throw.push(%( input => (1, 2, 3) ));
    @should-throw.push(%( input => ("a", "b", "C") ));   # assuming lowercase only
    @should-throw.push(%( input => ("a", "b", "") ));

    plan @tests + @should-throw + 3;
    for @tests {
        is string-difference(.<input>), .<output>, "{ .<input>.raku }";
    }
    for @should-throw {
        throws-like { string-difference(.<input>) }, Exception, "dies on { .<input>.raku }", message => /Unexpected/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, 'ab', 'bc', 'zy', :out, :err);
    is $proc.out.slurp(:close).trim, 'zy', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
