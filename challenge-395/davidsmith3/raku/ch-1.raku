#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 395 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Complex Number

You are given two complex numbers as string.

Write a script to return the multiplication of the given complex numbers.

Using the formula: (a + bi) x (c + di) = (ac - bd) + (ad + bc)i

=head3 Example 1:

Input: $num1 = "1+1i", $num2 = "1+1i"
Output: "0+2i"

=head3 Example 2:

Input: $num1 = "1+(-1)i", $num2 = "1+(-1)i"
Output: "0+(-2)i"

=head3 Example 3:

Input: $num1 = "0+3i", $num2 = "0+4i"
Output: "-12+0i"

=head3 Example 4:

Input: $num1 = "3+4i", $num2 = "3+(-4)i"
Output: "25+0i"

=head3 Example 5:

Input: $num1 = "50+(-20)i", $num2 = "-10+30i"
Output: "100+1700i"

=end pod

grammar ComplexNumber {
    token TOP { <real> '+' <imaginary> i}
    token real { <number> }
    token number { <negative> | <zero> | <positive> }
    token imaginary { '(' <negative> ')' | <zero> | <positive> }
    token negative { '-' <positive> }
    token zero { 0 }
    token positive { <[1..9]> <[0..9]>* }
}

class ComplexNumberActions {
    method TOP($/) { make ($<real>.made, $<imaginary>.made) }
    method real($/) { make $<number>.made }
    method number($/) { self.make-number($/) }
    method imaginary($/) { self.make-number($/) }
    method negative($/) { make $<positive>.made * -1 }
    method zero($/) { make 0 }
    method positive($/) { make +$/ }
    method make-number($/) {
        if $<negative> {
            make $<negative>.made;
        } elsif $<zero> {
            make $<zero>.made;
        } else {
            make $<positive>.made;
        }
    }
}

sub complex-number-mult(Str:D $num1, Str:D $num2 --> Str) {
    my $match1 = ComplexNumber.parse($num1, :actions(ComplexNumberActions));
    die "Unexpected input $num1" unless $match1;
    my $match2 = ComplexNumber.parse($num2, :actions(ComplexNumberActions));
    die "Unexpected input $num2" unless $match2;
    my ($a, $b) = $match1.made;
    my ($c, $d) = $match2.made;
    my $re = ($a * $c) - ($b * $d);
    my $im = ($a * $d) + ($b * $c);
    "{$re}+{$im >= 0 ?? $im !! '(' ~ $im ~ ')'}i"
}

#| multiply complex numbers NUM1 and NUM2
multi MAIN(Str:D $num1, Str:D $num2) {
    say complex-number-mult($num1, $num2);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => ("1+1i", "1+1i"), output => "0+2i"));
    @tests.push(%( input => ("1+(-1)i", "1+(-1)i"), output => "0+(-2)i"));
    @tests.push(%( input => ("0+3i", "0+4i"), output => "-12+0i"));
    @tests.push(%( input => ("3+4i", "3+(-4)i"), output => "25+0i"));
    @tests.push(%( input => ("50+(-20)i", "-10+30i"), output => "100+1700i"));
    my @should-throw;
    @should-throw.push(%( input => ("",         "1+1i") ));
    @should-throw.push(%( input => ("1-1i",     "1+1i") ));
    @should-throw.push(%( input => ("1.4+3i",   "1+1i") ));
    @should-throw.push(%( input => ("1+3.4i",   "1+1i") ));
    @should-throw.push(%( input => ("1.4+3i",   "1+1i") ));
    @should-throw.push(%( input => ("1+3.4i",   "1+1i") ));
    @should-throw.push(%( input => ("2e3+1i",   "1+1i") ));
    @should-throw.push(%( input => ("1+2.2e3i", "1+1i") ));
    @should-throw.push(%( input => ("1+1i",     "") ));

    plan @tests + @should-throw + 3;
    for @tests {
        is complex-number-mult(|.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        throws-like { complex-number-mult(|.<input>) }, Exception, "dies on { .<input> }", message => /Unexpected/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, '1+1i', '1+1i', :out, :err);
    is $proc.out.slurp(:close).trim, '0+2i', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
