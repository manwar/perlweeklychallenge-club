#!/usr/bin/perl6
use v6;

use Test;

=begin pod

Write a script to demonstrate Reverse Polish notation(RPN).

https://en.wikipedia.org/wiki/Reverse_Polish_notation

example given

The infix expression ((15 ÷ (7 − (1 + 1))) × 3) − (2 + (1 + 1)) can be written like this in reverse Polish notation:

15 7 1 1 + − ÷ 3 × 2 1 1 + + −

gives 5


=end pod

is evaluateRPN("15 7 1 1 + − ÷ 3 × 2 1 1 + + −"),5,"Wikipedia example";

# parses and evaluates a space separated postfix expression in RPN (add,sub,div,mult and pos. integers supported)
sub evaluateRPN($input) {
    say "Postfix expression to evaluate: [$input]";
    my @stack;
    my @in=$input.split: /\s+/;
    for @in -> $token {
    #         for each token in the postfix expression:
        given $token {
            #   if token is an operator:
            #     operand_2 ← pop from the stack
            #     operand_1 ← pop from the stack
            #     result ← evaluate token with operand_1 and operand_2
            #     push result back onto the stack
            when / (<[+−÷×]>) / {
                say "! found token operator";
                my $op2 = @stack.pop;
                say " popped $op2";
                my $op1 = @stack.pop;
                say " popped $op1";

                print "  evaluating $op1 and $op2 with $/";
                my $result = 0;
                $result = $op1 + $op2 if $/ eq '+';
                $result = $op1 - $op2 if $/ eq '−';
                $result = $op1 / $op2 if $/ eq '÷';
                $result = $op1 * $op2 if $/ eq '×';
                @stack.push: $result;
                say " result = $result";
                say " pushed $result into stack [{@stack}]";
            }
            #   else if token is an operand:
            #     push token onto the stack
            when /\d+/ {
                say "! found token operand";
                @stack.push: $token;
                say " pushed $token into stack [{@stack}]";
            };
        }
    }
    # result ← pop from the stack
    say "! end of input";
    say " popping {@stack[0]} and returning...\n";
    @stack.pop;
}

