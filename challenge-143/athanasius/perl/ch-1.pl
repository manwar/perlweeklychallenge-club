#!perl

###############################################################################
=comment

Perl Weekly Challenge 143
=========================

TASK #1
-------
*Calculator*

Submitted by: Mohammad S Anwar

You are given a string, $s, containing mathematical expression.

Write a script to print the result of the mathematical expression. To keep it
simple, please only accept + - * ().

Example 1:

     Input: $s = "10 + 20 - 5"
     Output: 25

Example 2:

     Input: $s = "(10 + 20 - 5) * 2"
     Output: 50

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
Evaluation of the given expression is performed in 3 stages:

1. Tokenize the input string
   -------------------------
   Tokenization is implemented using the CPAN module HOP::Lexer, which is based
   on code from the book "Higher-Order Perl" (2005) by Mark Jason Dominus [1].

2. Parse the token stream
   ----------------------
   The expression is converted from infix notation to Reverse Polish notation
   (RPN) using the Shunting-yard algorithm invented by Edsger W Dijkstra, as
   detailed in [2]. Note that parentheses in the token stream determine the
   order of evaluation in the RPN queue; they do not appear explicitly in the
   latter.

3. Evaluate the RPN queue
   ----------------------
   Create an empty stack
   FOR each item in the queue
       IF the item is a number THEN
           push it onto the stack
       ELSE {the item is a binary operator}
           pop 2 (numerical) operands off the stack
           perform the given operation on the 2 operands
           push the result onto the stack
       ENDIF
   END FOR
   There should now be exactly one number on the stack, viz., the result of
   evaluating the mathematical expression $s.

Caveat
------
From [2]: "The shunting yard algorithm will correctly parse all valid infix
expressions, but does not reject all invalid expressions. For example, "1 2 +"
is not a valid infix expression, but would be parsed as "1 + 2". The algorithm
can however reject expressions with mismatched parentheses."

References
----------
[1] https://hop.perl.plover.com/
[2] https://en.wikipedia.org/wiki/Shunting-yard_algorithm

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use HOP::Lexer     qw( string_lexer );
use Regexp::Common qw( number );

const my %PREC =>       # Operator precedence
(
    '+' => 1,
    '-' => 1,
    '*' => 2,
);

const my $USAGE =>
"Usage:
  perl $0 <s>

    <s>    String: a mathematical expression with numbers and + - * ()\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 143, Task #1: Calculator (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args   = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $s      = $ARGV[ 0 ];
    my $tokens = tokenize( $s );

    print qq[Input:  \$s = "$s"\n];

    my $queue  = parse   ( $tokens );
    my $result = evaluate( $queue  );

    print "Output: $result\n";
}

#------------------------------------------------------------------------------
sub tokenize
#------------------------------------------------------------------------------
{
    my ($s) = @_;
  
    my @input_tokens =
    (
        [ NUMBER   => qr/ $RE{num}{real} /x             ],
        [ OPERATOR => qr/ [+\-*]         /x             ],
        [ L_PAREN  => qr/ \(             /x             ],
        [ R_PAREN  => qr/ \)             /x             ],
        [ SPACE    => qr/ \s*            /x, sub { () } ],
    );
  
    my $lexer = string_lexer( $s, @input_tokens );
    my @tokens;

    while (my $token = $lexer->())
    {
        ref $token eq 'ARRAY' or error( qq[Unrecognized token "$token"] );
        push @tokens, $token;
    }

    return \@tokens;
}

#------------------------------------------------------------------------------
# See https://en.wikipedia.org/wiki/Shunting-yard_algorithm
#
sub parse
#------------------------------------------------------------------------------
{
    my ($tokens) = @_;
    my  @output_queue;
    my  @op_stack;

    for my $token (@$tokens)
    {
        if    ($token->[ 0 ] eq 'NUMBER')
        {
            push @output_queue, $token->[ 1 ];
        }
        elsif ($token->[ 0 ] eq 'OPERATOR')
        {
            push @output_queue, pop @op_stack
                while exists $op_stack[ -1 ]               &&
                             $op_stack[ -1 ] eq 'OPERATOR' &&
                      $PREC{ $op_stack[ -1 ] } >= $PREC{ $token->[ 1 ] };

            push @op_stack, $token->[ 1 ];
        }
        elsif ($token->[ 0 ] eq 'L_PAREN')
        {
            push @op_stack, $token->[ 0 ];
        }
        elsif ($token->[ 0 ] eq 'R_PAREN')
        {
            scalar @op_stack > 0
                or die 'ERROR: Mismatched parentheses';

            while ($op_stack[ -1 ] ne 'L_PAREN')
            {
                push @output_queue, pop @op_stack;

                scalar @op_stack > 0
                    or die "ERROR: Mismatched parentheses";
            }                 

            $op_stack[ -1 ] eq 'L_PAREN'
                or die 'ERROR: Left parenthesis missing';

            pop @op_stack;    # Discard left parenthesis
        }
        else
        {
            die qq[ERROR: Unrecognized token "$token"];
        }
    }

    while (scalar @op_stack > 0)
    {
        $op_stack[ 0 ] eq 'L_PAREN'
            and die 'ERROR: Mismatched parentheses';

        push @output_queue, pop @op_stack;
    }

    return \@output_queue;
}

#------------------------------------------------------------------------------
sub evaluate
#------------------------------------------------------------------------------
{
    my ($queue) = @_;
    my  @stack;

    for my $item (@$queue)
    {
        if    ($item eq '*')
        {
            my $n2 = pop @stack;
            my $n1 = pop @stack;

            push @stack, $n1 * $n2;
        }
        elsif ($item eq '+')
        {
            my $n2 = pop @stack;
            my $n1 = pop @stack;

            push @stack, $n1 + $n2;
        }
        elsif ($item eq '-')
        {
            my $n2 = pop @stack;
            my $n1 = pop @stack;

            push @stack, $n1 - $n2;
        }
        else    # $item is a number
        {
            push @stack, $item;
        }
    }

    scalar @stack == 1
        or die sprintf 'ERROR: %d items on stack', scalar @stack;

    return $stack[ 0 ];
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
