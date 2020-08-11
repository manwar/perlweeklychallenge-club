#! /opt/local/bin/perl
#
#       dispatches.pl
#
#       PWC 034 - Task #2
#       Write a program that demonstrates a dispatch table.
#
#       in Perl, functions are first-class citizens, which means they can be
#       indirectly referenced and those references assigned to variables just
#       like any other data. These code references can be accessed using the
#       arrow notation similarly to those employed with arrays and
#       hashes, in this case giving the function a list of arguments:
#
#           $function_reference->($arg1, $arg2, ...)
#
#       In a dispatch table, the data is a collection of subroutine actions,
#       gathered in another ubiqitous Perl data type, the hashtable. By
#       looking up a given input against the keys of the the table, we obtain
#       a selected action option as the value and can then execute the coderef.
#
#       In this, the table resembles a C switch statement, selecting an action
#       for the program's execution. With this functionality we can allow input
#       data to alter the the program flow, at least within the possibilities
#       defined in the subroutines.
#
#       To demonstrate this, we'll build a little toy calculator. Inputting a
#       string containing an expression, like
#
#           ./dispatches.pl "2 * 3 + 5 / 4"
#
#       evaluates the expression from left to right, switching the program
#       execution and action on a running talley between mathematical operators
#       as required. Each operator is defined by a subroutine keyed on the
#       operator symbol, shifting its operands off an internal stack, held in
#       the array reference $stack, and pushing the results back on as required.
#
#       The input is given as a string to the program, which is then parsed
#       into lists of operators and operands. The program can handle a string
#       of any number of operations, but as this is a demonstration of a dispatch
#       table for action on the stack array, the standard rules of operator
#       precedence are not implemented and evaluation is strictly left to right
#       without parentheses.
#
#       As can be seen, the actual routines to process the mathematical
#       operators are anonymous subroutines constructed within the hashtable
#       definition itself. Note that division by zero is safe and does not
#       crash the program, it simply returns 'NAN', for 'Not A Number'; the
#       program then terminates without attempting to evaluate further.
#
#       Implementation of an additional action is as simple as adding another
#       key/value pair to the hash, as long as the input is correctly passed through
#       preprocessing to match a key in the dispatch table. In this case a new
#       operator can be most any string of non-word characters (the shell and
#       Perl may cause problems when using '!', '$', and '@' -- be warned, as
#       constructs containing these can produce unexpected results). I have
#       inserted a new 'square of the difference' operator to demonstrate this.
#
#       I have left in verbose code to examine the state of the program as it
#       progresses; this makes it easy to see how the various operator actions
#       change the stack, as the first elements are taken off and the result
#       pushed back on as processing continues. A good example would be
#
#           ./dispatches.pl "20 ** 2 * 0 - 35 *-* 5 / 4"
#
#       which uses all of the possible operations, including the new "square of
#       the difference" operator *-* that I just made up.
#
#       2109 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



#use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

## first let us establish our dispatch table, and a few arrays to handle our lists of operators and operands
my $operator_dispatch = {
    '*'     => sub {    my ($x, $y) = splice $_[0]->@*, 0, 2;               ## multiply
                        unshift $_[0]->@*, ($x * $y)    },
    '+'     => sub {    my ($x, $y) = splice $_[0]->@*, 0, 2;               ## add
                        unshift $_[0]->@*, ($x + $y)    },
    '-'     => sub {    my ($x, $y) = splice $_[0]->@*, 0, 2;               ## subtract
                        unshift $_[0]->@*, ($x - $y)    },
    '/'     => sub {    my ($x, $y, $result) = splice $_[0]->@*, 0, 2;             ## divide (safe version)
                        eval {$result = $x/$y};
                        ($@) and $result = 'NAN';
                        unshift $_[0]->@*, $result},
    '**'    => sub {    my ($x, $y) = splice $_[0]->@*, 0, 2;               ## power
                        unshift $_[0]->@*, ($x ** $y)   },
    '*-*'    => sub {   my ($x, $y) = splice $_[0]->@*, 0, 2;               ## 'square of the difference' new operator
                        unshift $_[0]->@*, (($x - $y)** 2)  },
};

my $stack = [];
my @operators;

## fetch the input string and parse it
my @args = split /\s/, shift @ARGV;
say "   exp: ", , (join " ", @args);

for my $arg ( @args ) {
    $arg =~ /^\d+$/     &&  push $stack->@*, $arg;
    $arg =~ /^\W+$/     &&  push @operators, $arg;
}

## iterate through the list of operators
for my $op ( @operators ) {

    ## we can chose to first check whether the key exists and do something if it doesn't
    if (not exists $operator_dispatch->{$op}) {
        exit { say "operator '$op' not recognized, cannot evaluate further" };
    }

    ## show us what's happening
    say " stack: ", (join " ", $stack->@*);
    say "    op: ", $op;

    ## this one statement does all the heavy lifting for the calculator
    $operator_dispatch->{$op}->($stack);

    ## once we are outside mathematics there is no point to continuing
    last if $stack->[0] eq 'NAN';
}

# The running result will always be the first item on the stack, so when we run
# out of operators that's what we have left
say  "result: $stack->[0]";
