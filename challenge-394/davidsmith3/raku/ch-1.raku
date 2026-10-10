#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 394 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Alternate Case

You are given a string containing an equal number of uppercase and lowercase English letters.

Write a script to the minimum number of adjacent character swaps needed to turn the given string into an alternate case string.

=head3 Example 1:

Input: $str = "aAbB"
Output: 0

=head3 Example 2:

Input: $str = "AAbb"
Output: 1

Swap 1: "AbAb"

=head3 Example 3:

Input: $str = "AAAbbb"
Output: 3

Swap 1: "AAbAbb"
Swap 2: "AbAAbb"
Swap 3: "AbAbAb"

=head3 Example 4:

Input: $str = "aABb"
Output: 1

Swap 1: "aAbB"

=head3 Example 5:

Input: $str = "bBBAaa"
Output: 2

Swap 1: "BbBAaa"
Swap 2: "BbBaAa"

=end pod

sub bubble-left(Str:D $s, Int:D $i, Int:D $j --> Str) {
    $s.substr(0, $i) ~ $s.substr($j, 1) ~ $s.substr($i, $j-$i) ~ $s.substr($j+1);
}

sub count-swaps(Str:D $str, &flip-target --> Int) {
    my $s = $str;
    my $swaps = 0;
    for 0..^$s.chars -> $i {
        for $i..^$s.chars -> $j {
            my $target = $s.substr($j, 1).match(/ <[A..Z]> /).so;
            $target = !$target if flip-target($i);
            $s = bubble-left($s, $i, $j) if $target && $j > $i;
            $swaps += $j - $i if $target;
            last if $target;
        }
    }
    $swaps;
}

sub alternate-case(Str:D $str --> Int) {
    die "Unexpected character in $str" if $str !~~ / ^ <[a..zA..Z]>* $ /;
    die "Unexpected casing imbalance in $str" if $str.chars !%% 2 || $str.comb(/ <[A..Z]> /).elems != $str.chars div 2;
    min(count-swaps($str, { $_ %% 2 }), count-swaps($str, { $_ !%% 2 }));
}

#| return number of swaps needed to turn STR into an alternate case string.
multi MAIN(Str:D $str) {
    say alternate-case($str);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => "aAbB", output => 0));
    @tests.push(%( input => "AAbb", output => 1));
    @tests.push(%( input => "AAAbbb", output => 3));
    @tests.push(%( input => "aABb", output => 1));
    @tests.push(%( input => "bBBAaa", output => 2));
    @tests.push(%( input => "", output => 0));
    @tests.push(%( input => "aA", output => 0));
    @tests.push(%( input => "Aa", output => 0));
    @tests.push(%( input => "aaAA", output => 1));
    @tests.push(%( input => "aAaA", output => 0));
    @tests.push(%( input => "aAAa", output => 1));
    @tests.push(%( input => "AaaA", output => 1));
    @tests.push(%( input => "AaAa", output => 0));
    @tests.push(%( input => "AAaa", output => 1));
    @tests.push(%( input => "aaaBBB", output => 3));

    my @should-throw;
    @should-throw.push(%( input => "a" ));
    @should-throw.push(%( input => "A" ));
    @should-throw.push(%( input => "aAa" ));
    @should-throw.push(%( input => "AaA" ));
    @should-throw.push(%( input => "aA3" ));
    @should-throw.push(%( input => "aA!" ));
    @should-throw.push(%( input => "aa" ));
    @should-throw.push(%( input => "AA" ));

    plan @tests + @should-throw + 3;
    for @tests {
        is alternate-case(.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        throws-like { alternate-case(.<input>) }, Exception, "dies on { .<input> }", message => /Unexpected/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, 'aA', :out, :err);
    is $proc.out.slurp(:close).trim, '0', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
