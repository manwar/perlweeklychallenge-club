use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 112
=========================

TASK #2
-------
*Climb Stairs*

Submitted by: Mohammad S Anwar

You are given $n steps to climb

Write a script to find out the distinct ways to climb to the top. You are
allowed to climb either 1 or 2 steps at a time.

Example

 Input: $n = 3
 Output: 3

     Option 1: 1 step + 1 step + 1 step
     Option 2: 1 step + 2 steps
     Option 3: 2 steps + 1 step

 Input: $n = 4
 Output: 5

     Option 1: 1 step + 1 step + 1 step + 1 step
     Option 2: 1 step + 1 step + 2 steps
     Option 3: 2 steps + 1 step + 1 step
     Option 4: 1 step + 2 steps + 1 step
     Option 5: 2 steps + 2 steps

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

It is not clear from the Task description whether the requirement is for

    (1) details of all the distinct ways to climb to the top,
or just
    (2) the total number of these distinct ways.

I have therefore provided both solutions, defaulting to (2) unless the option "--show-steps" is provided on the command line.

Algorithms
----------
(1) The number of distinct solutions for n is simply the (n + 1)th Fibonacci
    number. A straightforward calculation is provided for this.

(2) Display of the distinct solutions is performed in 3 stages:

    (a) Strings are constructed representing the possible combinations of '1'
        and '2' digits in each solution. For example, for n = 4, the strings
        are '1111', '112', and '22'.

    (b) Each string constructed in (a) is permuted into all of its possible
        digit arrangements. For example, the string '112' is permuted to '112',
        '121', and '211'.

    (c) Each permutation calculated in (b) is decoded and displayed as a
        sequence of steps. For example, '211' is displayed as:
            "Option 4: 2 steps + 1 step  + 1 step"

Note that the permutations in (b) are calculated using the algorithm from the
NextPermute() subroutine in the CPAN module Algorithm::Loops. As that module
produced errors when invoked with

    use Algorithm::Loops:from<Perl5> <NextPermute>;

I have ported the Perl code to Raku and included it as a subroutine here.

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 112, Task #2: Climb Stairs (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D  $n where { $n > 0 },     #= The number of steps to climb
    Bool:D :$show-steps = False      #= Display all the distinct ways to climb?
)
#==============================================================================
{
    "Input:  \$n = $n".put;

    if $show-steps
    {
        show-steps( $n );
    }
    else
    {
        "Output: %d\n".printf: fibonacci( $n + 1 );
    }
}

#------------------------------------------------------------------------------
sub show-steps( UInt:D $n )
#------------------------------------------------------------------------------
{
    # (a) Construct strings to represent the possible combinations of '1' and
    #     '2' digits in a solution

    my Str @steps;

    @steps.push: ('1' x ($n - 2 * $_)) ~ ('2' x $_) for 0 .. ( $n / 2 ).floor;

    # (b) Permute each string constructed in (a) into all the possible distinct
    #     arrangements of its digits

    my Str @options;

    for @steps -> Str $step
    {
        my Array[Str] $list = Array[Str].new: $step.split: '', :skip-empty;

        repeat
        {
            @options.push: $list.join: '';

        } while NextPermute( $list );
    }

    # (c) Decode each permutation calculated in (b) and display it as a
    #     sequence of steps

    "Output: %d\n\n".printf: @options.elems;

    my UInt $count = 0;
    my UInt $width = @options.elems.Str.chars;

    for @options -> Str $option
    {
        '    Option %*d: '.printf: $width, ++$count;

        my Str $step = $option.substr: 0, 1;

        '%d step%s'.printf: $step, $step == 1 ?? ' ' !! 's';

        for 1 .. $option.chars - 1 -> UInt $i
        {
            $step = $option.substr: $i, 1;

            ' + %s step%s'.printf: $step, $step eq '1' ?? ' ' !! 's';
        }

        ''.put;
    }
}

#------------------------------------------------------------------------------
sub NextPermute( Array:D[Str:D] $vals is rw --> Bool:D )
#------------------------------------------------------------------------------
{
    my UInt $last = $vals.end;

    return False if $last < 1;

    # Find last item not in reverse-sorted order:

    my Int $i = $last - 1;
           $i-- while 0 <= $i && $vals[ $i ] ge $vals[ $i + 1 ];

    # If complete reverse sort, we are done!

    if -1 == $i
    {
        # Reset to starting/sorted order:

        $vals = Array[Str].new( $vals.reverse );

        return False;
    }

    # Re-sort the reversely-sorted tail of the list:

    $vals[ $i + 1 .. $last ] = $vals[ $i + 1 .. $last ].reverse
        if  $vals[ $i + 1 ] gt $vals[ $last ];

    # Find next item that will make us "greater":

    my UInt $j = $i + 1;
            $j++ while $vals[ $i ] ge $vals[ $j ];

    # Swap:

    $vals[ $i, $j ] = $vals[ $j, $i ];

    return True;
}

#------------------------------------------------------------------------------
# Return the nth Fibonacci number:
#         n   0, 1, 2, 3, 4, 5, 6,  7,  8,  9, 10, 11,  12, ...
#     fib(n)  0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, ...
#
sub fibonacci( UInt:D $n --> UInt:D )
#------------------------------------------------------------------------------
{
    return 0 if $n == 0;
    return 1 if $n == 1 || $n == 2;

    my UInt ($p, $q) = 1, 1;
    my UInt  $fib;

    for 1 .. $n - 2
    {
        $fib = $p + $q;
        $p   = $q;
        $q   = $fib;
    }

    return $fib;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
