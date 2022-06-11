use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 149
=========================

TASK #1
-------
*Fibonacci Digit Sum*

Submitted by: Roger Bell_West

Given an input $N, generate the first $N numbers for which the sum of their
digits is a Fibonacci number.

Example

 f(20)=[0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41,
        44]

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
The natural numbers are searched sequentially. For each number $i, the digits
are summed and the sum is tested to discover whether it is a Fibonacci number.
If it is, it is printed and the count is incremented. The search stops when the
required number of solutions have been found.

The is-fib() function, which determines whether a given number is a Fibonacci
number, keeps track of known Fibonacci numbers in a hash. (A hash is used for
ease of look-up.) Whenever the input number is greater than the largest known
Fibonacci number, new Fibonacci numbers are generated and stored. This step
proceeds in increments of $FIB-INC new Fibonacci numbers at a time. The value
of the constant $FIB-INC may be adjusted according to the expected size(s) of
the command-line input $N: for larger values of $N, larger values of $FIB-INC
may be expected to produce more efficient results.

=end comment
#==============================================================================

my UInt constant $FIB-INC = 10;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 149, Task #1: Fibonacci Digit Sum (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $N where { $N > 0 }         #= Natural number: required output count
)
#==============================================================================
{
    "f($N) = [0".print;

    my UInt $count = 1;

    for 1 .. Inf -> UInt $i
    {
        last if $count >= $N;

        my UInt $sum = [+] $i.split: '', :skip-empty;

        if is-fib( $sum )
        {
            ", $i".print;

            ++$count;
        }
    }

    ']'.put;
}

#------------------------------------------------------------------------------
sub is-fib( UInt:D $n --> Bool:D )
#------------------------------------------------------------------------------
{
    state UInt  %fib = 0 => Nil, 1 => Nil;
    state UInt ($max, $f2, $f1) = 1, 0, 1;

    while $max < $n
    {
        for 1 .. $FIB-INC
        {
            ($f2, $f1)  = $f1, $f2 + $f1;

            %fib{ $f1 } = Nil;
        }

        $max += $FIB-INC;
    }

    return %fib{ $n }:exists;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################
