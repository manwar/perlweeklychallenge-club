#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 385 Task 2

Submitted by: Mohammad Sajid Anwar
=head2 Outermost Parentheses

You are given a valid parentheses string.

Write a script to return the string after removing the outermost parentheses of every primitive string in the primitive decomposition of the given string.

=head3 Example 1:

Input: $str = "()()()"
Output: ""

Primitive Decomposition: "()" + "()" + "()"

=head3 Example 2:

Input: $str = "(((())))"
Output: "((()))"

Primitive Decomposition: "(((())))"

=head3 Example 3:

Input: $str = "(()())(())"
Output: "()()()"

Primitive Decomposition: "(()())" + "(())"

=head3 Example 4:

Input: $str = "()((()))()"
Output: "(())"

Primitive Decomposition: "()" + "((()))" + "()"

=head3 Example 5:

Input: $str = "(()(()))(()())"
Output: "()(())()()"

Primitive Decomposition: "(()(()))" + "(()())"

=end pod

sub outermost-parentheses(Str:D $str, --> Str) {               # input is a known-good parentheses string
    my @keep-indexes;
    my $depth = 0;
    for $str.comb.kv -> $i, $looking-at {                      # scan left to right and remember the indexes of all non-outermost pairs
        if $looking-at eq "(" {                                # str:    ( )      ( ( ) )       ( ) ( )
            @keep-indexes.push($i) unless $depth == 0;         # depth: 0 1 0    0 1 2 1 0     0 1 0 1 0
            $depth++;
        } else { # looking at )
            @keep-indexes.push($i) unless $depth == 1;
            $depth--;
        }
    }
    $str.comb[@keep-indexes].join;                             # splice all remembered characters into result
}

#| remove outermost parentheses from str
multi MAIN(Str:D $str) {
    say outermost-parentheses($str);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => "()()()", output => "" ));
    @tests.push(%( input => "(((())))", output => "((()))" ));
    @tests.push(%( input => "(()())(())", output => "()()()" ));
    @tests.push(%( input => "()((()))()", output => "(())" ));
    @tests.push(%( input => "(()(()))(()())", output => "()(())()()" ));
    @tests.push(%( input => "", output => "" ));
    @tests.push(%( input => "()", output => "" ));
    @tests.push(%( input => "()()", output => "" ));
    @tests.push(%( input => "(())", output => "()" ));
    @tests.push(%( input => "(())()", output => "()" ));
    @tests.push(%( input => "(())(())", output => "()()" ));

    plan @tests + 3;
    for @tests {
        is outermost-parentheses(.<input>), .<output>, "{ .<input> }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, '(())', :out, :err);
    is $proc.out.slurp(:close).trim, '()', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
