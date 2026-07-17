#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 382 Task 2

Submitted by: Simon Green
=head2 Replace Question Mark

You are given a string that contains only 0, 1 and ? characters.

Write a script to generate all possible combinations when replacing the question marks with a zero or one.

=head3 Example 1:

Input: $str = "01??0"
Output: ("01000", "01010", "01100", "01110")

=head3 Example 2:

Input: $str = "101"
Output: ("101")

=head3 Example 3:

Input: $str = "???"
Output: ("000", "001", "010", "011", "100", "101", "110", "111")

=head3 Example 4:

Input: $str = "1?10"
Output: ("1010", "1110")

=head3 Example 5:

Input: $str = "1?1?0"
Output: ("10100", "10110", "11100", "11110")

=end pod

sub replace-question-mark(Str:D $str where /^ <[?01]>* $/ --> List) {
    my $num-marks = $str.indices("?").elems;
    return ($str,) if $num-marks == 0;
    my @chars = $str.comb;
    my @result;
    for ^(2**$num-marks) -> $i {
        my @replacements = sprintf('%0*b', $num-marks, $i).comb;
        @result.push(@chars.map({ $_ eq '?' ?? @replacements.shift !! $_ }).join);
    };
    @result.List;
}

#| replace all occurrances of ? in str with all combinations of 0 and 1
multi MAIN(Str:D $str) {
    say replace-question-mark($str);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => "01??0",
                   output => ("01000", "01010", "01100", "01110") ));
    @tests.push(%( input => "101",
                   output => ("101",) ));
    @tests.push(%( input => "???",
                   output => ("000", "001", "010", "011", "100", "101", "110", "111") ));
    @tests.push(%( input => "1?10",
                   output => ("1010", "1110") ));
    @tests.push(%( input => "1?1?0",
                   output => ("10100", "10110", "11100", "11110") ));
    @tests.push(%( input => "",
                   output => ("",) ));
    @tests.push(%( input => "?",
                   output => ("0", "1") ));
    my @should-throw;
    @should-throw.push(%( input => "abc" ));
    @should-throw.push(%( input => "1%" ));

    plan @tests + @should-throw + 3;
    for @tests {
        is-deeply replace-question-mark(.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        dies-ok { replace-question-mark(.<input>) }, "dies on { .<input> }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, '101', :out, :err);
    is $proc.out.slurp(:close).trim, '(101)', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
