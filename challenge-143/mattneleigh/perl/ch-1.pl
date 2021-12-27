#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @expressions = (
    "10 + 20 - 5",
    "(10 + 20 - 5) * 2"
);
my $expression;

foreach $expression (@expressions){
    printf("Input: \$s = \"%s\"\n", $expression);
    printf("Output: %0.4f\n\n", Evaluator::evaluate_expression($expression));
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################




################################################################################
# A package for evaluating mathematical expressions (and providing a separate
# namespace for same)
################################################################################
package Evaluator;

BEGIN{

    # The regular expression used to define
    # some of the non-numerical tokens
    # processed in this program
    $Evaluator::token_regex = "[+\*\/\(\)-]";

    # Define the operators accepted by the
    # expression evaluator, including their
    # associativity, precedence, and the
    # way they interact with a stack when
    # used in RPN
    %Evaluator::op_table = (
        # Add
        "+" => {
            prec => 2,
            assoc => 'L',
            rpn_exec => sub{
                my $stack = shift();

                push(@{$stack}, pop(@{$stack}) + pop(@{$stack}));

            }
        },

        # Subtract
        "-" => {
            prec => 2,
            assoc => 'L',
            rpn_exec => sub{
                my $stack = shift();

                push(@{$stack}, -pop(@{$stack}) + pop(@{$stack}));

            }
        },

        # Multiply
        "*" => {
            prec => 3,
            assoc => 'L',
            rpn_exec => sub{
                my $stack = shift();

                push(@{$stack}, pop(@{$stack}) * pop(@{$stack}));

            }
        },

        # Divide
        "/" => {
            prec => 3,
            assoc => 'L',
            rpn_exec => sub{
                my $stack = shift();

                push(@{$stack}, (1 / pop(@{$stack})) * pop(@{$stack}));

            }
        }

    );

} # end BEGIN



################################################################################
# Evaluate a simple mathematical expression consisting solely of numbers,
# parentheses, and a selection of mathematical operators
# Takes one argument:
# * A string containing the expression to evaluate
# Returns:
# * The result of the evaluation of the expression
################################################################################
sub evaluate_expression{
    my $expression = shift;
    my @tokens;

    # Massage the data a little by adding
    # spaces around known tokens, then
    # simply split the string on whitespace
    $expression =~ s/($Evaluator::token_regex)/ $1 /g;
    @tokens = split(" ", $expression);

    # Evaluate the expression by first
    # converting the tokens to their RPN
    # equivalent, then evaluating that
    evaluate_rpn(tokens_to_rpn(\@tokens));

    # Return the top of the stack produced
    # by the RPN evaluator
    return($tokens[$#tokens]);

}



################################################################################
# Convert a list of tokens from a mathematical expression in infix notation to
# a list of tokens in Reverse Polish Notation
# Takes one argument:
# * A ref to a list of tokens that make up a mathematical expression in infix
#   notation (e.g. [ 4, "*", "(", 5, "+", 3, ")" ])
# Returns:
# * The same ref passed as the argument, which now points to a list of tokens
#   that make up an equivalent expression in RPN (e.g. [ 4, 5, 3, "+", "*" ])
# NOTE: This function modifies the original list
# Adapted from the algorithm described at:
# https://en.wikipedia.org/wiki/Shunting-yard_algorithm
################################################################################
sub tokens_to_rpn{
    my $tokens = shift();

    my $token;
    my @out_queue;
    my @op_stack;

    # Assignment in condition is
    # deliberate; loop until we run out of
    # tokens to process
    while($token = shift(@{$tokens})){
        if($token eq '('){
            # Left paren- push it onto the op stack
            push(@op_stack, $token);
        } elsif($token eq ')'){
            # Right paren- pop the op stack and add
            # to the output queue until we find a
            # left paren
            while($op_stack[$#op_stack] && ($op_stack[$#op_stack] ne '(')){
                push(@out_queue, pop(@op_stack));
            }
            # Discard the left paren
            pop(@op_stack);
        } elsif($Evaluator::op_table{$token}){
            # Math operator
            while(
                # While there is an operator on the op
                # stack...
                $op_stack[$#op_stack]
                # AND...
                &&
                # The operator is not a left paren...
                ($op_stack[$#op_stack] ne '(')
                # AND...
                &&
                (
                    # The new operator is left-associative
                    # and has a precedence less than or
                    # equal to what's on top of the op
                    # stack...
                    (
                        ($Evaluator::op_table{$token}{assoc} eq 'L')
                        &&
                        (
                            $Evaluator::op_table{$token}{prec}
                            <= 
                            $Evaluator::op_table{$op_stack[$#op_stack]}{prec}
                        )
                    )
                    # OR...
                    ||
                    # The new operator is right-associative
                    # and has a precedence less than what's
                    # what's on top of the op stack...
                    (
                        ($Evaluator::op_table{$token}{assoc} eq 'R')
                        &&
                        (
                            $Evaluator::op_table{$token}{prec}
                            < 
                            $Evaluator::op_table{$op_stack[$#op_stack]}{prec}
                        )
                    )
                )
            ){
                # Pop an operator from the op stack and
                # push it into the output queue
                push(@out_queue, pop(@op_stack));
            }
            # Push the new operator onto the op
            # stack
            push(@op_stack, $token);
        } else{
            # Presumably a number... add it to the
            # output queue
            push(@out_queue, $token);
        }
    }

    # Pop all remaining operators and push
    # them into the output queue
    while(@op_stack){
        push(@out_queue, pop(@op_stack));
    }

    # Transfer all contents of the output
    # queue back to the original token
    # list
    while(@out_queue){
        push(@{$tokens}, shift(@out_queue));
    }

    return($tokens);

}



################################################################################
# Evaluate an expression defined by a list of tokens in Reverse Polish Notation
# Takes one argument:
# * A ref to a list of tokens that make up a mathematical expression in RPN
#   (e.g. [ 4, 5, 3, "+", "*" ])
# Returns:
# * The same ref passed as the argument, which now points to the contents of
#   the RPN data stack after the expression is evaluated; if the expression is
#   well-formed, this will consist of a single value (e.g. [ 32 ])
# NOTE: This function modifies the original list
################################################################################
sub evaluate_rpn{
    my $tokens = shift();

    my $token;
    my @stack;

    # Assignment in condition is
    # deliberate; loop until we run out of
    # tokens to process
    while($token = shift(@{$tokens})){
        if($Evaluator::op_table{$token}){
            # This token is an operator; run its
            # associated function on the contents
            # of the stack
            &{$Evaluator::op_table{$token}{rpn_exec}}(\@stack);
        } else{
            # This token is not an operator; push
            # it onto the stack
            push(@stack, $token);
        }
    }

    # Populate the original token list with
    # the contents of the stack
    while(@stack){
        push(@{$tokens}, shift(@stack));
    }

    return($tokens);

}



