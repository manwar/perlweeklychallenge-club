#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 387 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Rearrange Binary String

Write a script to re-arrange the given binary string that all occurrences of “01” are simultaneously replaced with “10” until no occurrences of “01” exist. Finally return the total steps needed.

=head3 Example 1:

Input: $str = "111000"
Output: 0

The string already has all 1s on the left and 0s on the right.
There are no occurrences of "01", so zero step needed.

=head3 Example 2:

Input: $str = "00011"
Output: 4

Step 1: "00101"
Step 2: "01010"
Step 3: "10100"
Step 4: "11000"

=head3 Example 3:

Input: $str = "01011"
Output: 3

Step 1: "10101"
Step 2: "11010"
Step 3: "11100"

=head3 Example 4:

Input: $str = "010101"
Output: 3

Step 1: "101010"
Step 2: "110100"
Step 3: "111000"

=head3 Example 5:

Input: $str = "00001"
Output: 4

Step 1: "00010"
Step 2: "00100"
Step 3: "01000"
Step 4: "10000"

=end pod

sub rearrange-binary-string(Str:D $str where / ^ <[01]>* $ /--> Int) {
    my $curr = $str;
    my $count = 0;
    while $curr ~~ / 01 / {
        $curr .= subst(:g, / 01 /, "10");
        $count++;
    }
    $count;
}

#| Replace '01' with '10' in binary string STR until no occurrence of '01' exists.  Return number of steps required for the transformation.
multi MAIN(Str:D $str) {
    say rearrange-binary-string($str);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => "111000", output => 0));
    @tests.push(%( input => "00011", output => 4));
    @tests.push(%( input => "01011", output => 3));
    @tests.push(%( input => "010101", output => 3));
    @tests.push(%( input => "00001", output => 4));
    @tests.push(%( input => "", output => 0));
    @tests.push(%( input => "0", output => 0));
    @tests.push(%( input => "1", output => 0));
    @tests.push(%( input => "01", output => 1));
    @tests.push(%( input => "10", output => 0));
    @tests.push(%( input => "11", output => 0));
    @tests.push(%( input => "0110", output => 2));

    my @should-throw;
    @should-throw.push(%( input => "a1" ));
    @should-throw.push(%( input => "0!" ));

    plan @tests + @should-throw + 3;
    for @tests {
        is rearrange-binary-string(.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        throws-like { rearrange-binary-string(.<input>) }, Exception, "dies on { .<input> }", message => / constraint /;
    }
    my $proc = run($*EXECUTABLE, $?FILE, '00011', :out, :err);
    is $proc.out.slurp(:close).trim, '4', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
