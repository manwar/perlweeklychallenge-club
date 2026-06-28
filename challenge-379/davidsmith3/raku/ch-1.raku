#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 379 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Reverse String

You are given a string.

Write a script to reverse the given string without using standard reverse function.

=head3 Example 1:

Input: $str = ""
Output: ""

=head3 Example 2:

Input: $str = "reverse the given string"
Output: "gnirts nevig eht esrever"

=head3 Example 3:

Input: $str = "Perl is Awesome"
Output: "emosewA si lreP"

=head3 Example 4:

Input: $str = "v1.0.0-Beta!"
Output: "!ateB-0.0.1v"

=head3 Example 5:

Input: $str = "racecar"
Output: "racecar"

=end pod

sub reverse-string(Str:D $str --> Str) {
    ($str.chars...0).map({ $str.substr($_, 1) }).join;
}

#| print the reverse of str
multi MAIN(Str:D $str) {
    say reverse-string($str);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => "", output => "" ));
    @tests.push(%( input => "reverse the given string", output => "gnirts nevig eht esrever" ));
    @tests.push(%( input => "Perl is Awesome", output => "emosewA si lreP" ));
    @tests.push(%( input => "v1.0.0-Beta!", output => "!ateB-0.0.1v" ));
    @tests.push(%( input => "racecar", output => "racecar" ));
    @tests.push(%( input => "a", output => "a" ));

    plan @tests + 3;
    for @tests {
        is reverse-string(.<input>), .<output>, "{ .<input> }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, 'abc', :out, :err);
    is $proc.out.slurp(:close).trim, 'cba', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
