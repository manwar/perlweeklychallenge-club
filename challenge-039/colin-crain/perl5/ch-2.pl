#! /opt/local/bin/perl
#
#       ch-2.pl
#
#       PWC 39 - TASK #2
#       Write a script to demonstrate Reverse Polish notation(RPN). Checkout
#           the wiki page for more information about RPN.
#
#       method: the cited wiki article provides two algorithms, one reading the
#           expression left to right the other right to left. I implemented them
#           both, but found the former more attractive and extensible. The right
#           to left version is included for examination as a subroutine at the
#           end. The operations themselves harken back to PWC #34, and here
#           again we use a dispatch table of subroutine references to choose the
#           different courses of action.
#
#           The first algorithm as written handles only binary operations, but
#           is easily expanded to include unitary postfix operators, and so I
#           did and added a few of those to the dispatch table. In the spirit of
#           keeping the specific operator data, code and attributes, together,
#           an additional level of indirection is added to the table entries as
#           a hash, specifying the number of operands the operator requires in
#           addition to the original code reference. This in turn led me to
#           considering including operators that don't take any operands at all,
#           which is one way to think about constants. Adding pi and e did
#           require a slight patch to the splice code, as handing splice 0
#           offset removes the the whole stack and delivers it to the dispatched
#           function, which is certainly not what we want, rather than removing
#           0 items from the stack. Oh well. It's rather pathological to bring
#           up a function and then ask it to do nothing so this behavior does
#           make sense, it's just not what we want. Simply not splicing on 0
#           fixes this nicely. Constants are probably best substituted out
#           before we start anyway, like macros, instead of being bits of
#           operator code that returns only one thing no matter what, but we're
#           getting further afield from the implementation of Reverse Polish
#           Notation so we'll just stop here.
#
#           running bash here so the factorial ! needs an escape on the
#           command line, so we match that as well as the unescaped version.
#           It seems easier than making social cases for the shell, which doesn't
#           have much to do with demonstrating RPN either.
#
#       2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN
#
# for each token in the postfix expression:
#     if token is an operator:
#         operand_2 ← pop from the stack
#         operand_1 ← pop from the stack
#         result ← evaluate token with operand_1 and operand_2
#         push result back onto the stack
#     else if token is an operand:
#         push token onto the stack
# result ← pop from the stack

my $expression = shift @ARGV //      "2 7 2 3 4 + * ^ -";
my @exp = split /\s+/, $expression;

my @stack;

my $dispatch = {
    '+'     => { ops  => 2,
                 code => sub { $_[0] + $_[1] } },
    '-'     => { ops  => 2,
                 code => sub { $_[0] - $_[1] } },
    '*'     => { ops  => 2,
                 code => sub { $_[0] * $_[1] } },
    '/'     => { ops  => 2,
                 code => sub { $_[0] / $_[1] } },
    '^'     => { ops  => 2,
                 code => sub { $_[0] ** $_[1] } },
    'sin'   => { ops  => 1,
                 code => sub { sin($_[0]) } },
    'cos'   => { ops  => 1,
                 code => sub { cos($_[0]) } },
    'tan'   => { ops  => 1,
                 code => sub { sin($_[0]) / cos($_[0]) } },
    'sqrt'  => { ops  => 1,
                 code => sub { sqrt($_[0]) } },
    '\!'    => { ops  => 1,
                 code => \&factorial },
    'pi'    => { ops  => 0,
                 code => sub { 3.14159265359 } },
    'e'     => { ops  => 0,
                 code => sub { 2.71828182846 } },
};

while (scalar @exp) {
    my $token = shift @exp;

    ## token is operand
    if ($token =~ /^[\d.]+$/) {
        push @stack, $token;
    }
    ## is operator
    elsif ( exists $dispatch->{$token} ) {
        my @operands = $dispatch->{$token}->{ops} ? splice @stack, -( $dispatch->{$token}->{ops} ) : ();
        push @stack, $dispatch->{$token}->{code}->(@operands);
    }
    ## is unrecognized
    else {
        say "ERROR: operator $token not recognized.";
        exit;
    }
}

say "$expression = $stack[0]\n\n";

## uncomment to see the other algorithm
#
#
# r2l_rpn( $expression );


## ## ## ## ## SUBS

sub factorial {
    my $num = shift;
    return undef if $num < 0;
    return 1 if $num <= 1;
    my $out = $num;
    while ( --$num > 1) {
        $out *= $num;
    }
    return $out;
}

sub r2l_rpn {
## implementation of a different algoritm that read the expression
## right-to-left, or really prefix Polish Notation read left-to-right on a
## reversal of the input token array
##
## This algorithm has not been extended to accept unitary operators and constants

# for each token in the reversed postfix expression:
#     if token is an operator:
#         push token onto the operator stack
#         pending_operand ← False
#     else if token is an operand:
#         operand ← token
#         if pending_operand is True:
#             while the operand stack is not empty:
#                 operand_1 ← pop from the operand stack
#                 operator ← pop from the operator stack
#                 operand ← evaluate operator with operand_1 and operand
#         push operand onto the operand stack
#         pending_operand ← True
# result ← pop from the operand stack

    my $expression = shift;
    my @exp = reverse( split /\s+/, $expression);

    my @operators       = ();
    my @stack           = ();
    my $pending_operand = 0;

    while (scalar @exp) {
        my $token = shift @exp;
        my ($op1, $op2);

        if ( $token =~ /^[+\-*\/^]$/) {     ## token is operator
            push @operators, $token;
            $pending_operand = 0;
        }
        elsif ($token =~ /^[\d.]+$/) {      ## token is operand
            $op1 = $token;
            if ($pending_operand) {
                while (scalar @stack) {
                    $op2 = pop @stack;
                    my $operator  = pop @operators;
                    $op1  = $dispatch->{$operator}->{code}->($op1, $op2);
                }
            }
            push @stack, $op1;
            $pending_operand = 1;

        }
    }

    say "output from right-to-left algorithm: $expression = ", pop @stack;

}
