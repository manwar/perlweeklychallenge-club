#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 401 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Fractional Addition Subtraction

You are given a string representing an expression of fraction addition and substraction.

Write a script that returns the calculation result of given expression in string
format. If final result is an integer, change it to the format of fraction that has a
denominator 1.

=head3 Example 1:

Input: $expr = "1/2+3/2"
Output: "2/1"

1/2 + 3/2 => 4/2 => 2

As specified by the rules, an integer result must be represented as a fraction with
denominator 1, yielding "2/1".

=head3 Example 2:

Input: $expr = "-5/2-3/2"
Output: "-4/1"

-5/2 - 3/2 => -8/2 => -4 => "-4/1".

=head3 Example 3:

Input: $expr = "5/3-5/3"
Output: "0/1"

5/3 - 5/3 => 0/3
Zero divided by any valid non-zero denominator reduces to "0/1".

=head3 Example 4:

Input: $expr = "10/10-1/10+2/5"
Output: "13/10"

10/10 - 1/10 + 2/5 => 9/10 + 4/10 => 13/10.
13/10 is already irreducible, so the output is "13/10".

=head3 Example 5:

Input: $expr = "1/6+1/6+1/6"
Output: "1/2"

1/6 + 1/6 + 1/6 => 3/6 => 1/2

=end pod

grammar Arithmetic {
    token TOP { <fraction>+ % <operator> }
    token operator { '+' | '-' }
    token fraction { <uminus>? <nonnegative> '/' <nonnegative> }
    token uminus { '-' }
    token nonnegative { [<[1..9]> <[0..9]>*] | 0 }
}

class ArithmeticActions {
    method TOP($/) {
        my @operands =  $<fraction>.map({ .made });
        my @operators = $<operator>.map({ .made });
        for @operators -> &op {
            my $left = @operands.shift();
            my $right = @operands.shift();
            @operands.unshift(&op($left, $right));
        }
        make @operands[0];
    };
    method operator($/) { make ~$/ eq '+' ?? &[+] !! &[-] }
    method fraction($/) {
        my @nums = $<nonnegative>.map({ .made });
        die "Attempt to divide by zero" if @nums.tail == 0;
        my $rat = Rat.new(@nums.head, @nums.tail);
        make $<uminus> ?? $rat * -1 !! $rat;
    }
    method nonnegative($/) { make +$/ }
}

sub fractional-addition-subtraction(Str:D $expr --> Str) {
    my $parsed = Arithmetic.parse($expr, :actions(ArithmeticActions));
    die "Unexpected input $expr" unless $parsed;
    my $result = $parsed.made;
    $result.nude.join('/');
}

#| compute the arithmetic EXPR and return result as a fraction
multi MAIN(Str:D $expr) {
    say fractional-addition-subtraction($expr);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => "1/2+3/2", output => "2/1"));
    @tests.push(%( input => "-5/2-3/2", output => "-4/1"));
    @tests.push(%( input => "5/3-5/3", output => "0/1"));
    @tests.push(%( input => "10/10-1/10+2/5", output => "13/10"));
    @tests.push(%( input => "1/6+1/6+1/6", output => "1/2"));
    @tests.push(%( input => "0/1", output => "0/1"));
    @tests.push(%( input => "-0/1", output => "0/1"));
    @tests.push(%( input => "1/1", output => "1/1"));
    @tests.push(%( input => "2/2", output => "1/1"));
    @tests.push(%( input => "1/2", output => "1/2"));
    @tests.push(%( input => "-1/1+-1/1", output => "-2/1"));
    @tests.push(%( input => "-1/1--1/1", output => "0/1"));
    @tests.push(%( input => "321/4321+1/1", output => "4642/4321"));

    my @should-throw;
    @should-throw.push(%( input => "", msg => /Unexpected/ ));
    @should-throw.push(%( input => "01/2", msg => /Unexpected/  ));
    @should-throw.push(%( input => "one divided by two", msg => /Unexpected/  ));
    @should-throw.push(%( input => "0/0", msg => /'Attempt to divide'/ ));
    @should-throw.push(%( input => "1/0", msg => /'Attempt to divide'/ ));

    plan @tests + @should-throw + 3;
    for @tests {
        is fractional-addition-subtraction(.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        throws-like { fractional-addition-subtraction(.<input>) },
                    Exception,
                    "dies on { .<input> }",
                    message => .<msg>;
    }
    my $proc = run($*EXECUTABLE, $?FILE, '1/8+0/1+1/8', :out, :err);
    is $proc.out.slurp(:close).trim, '1/4', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
