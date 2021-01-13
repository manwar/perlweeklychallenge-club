use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 091
=========================

Task #2
-------
*Jump Game*

Submitted by: Mohammad S Anwar

You are given an array of positive numbers @N, where value at each index deter-
mines how far you are allowed to jump further.

Write a script to decide if you can jump to the last index. Print 1 if you are
able to reach the last index otherwise 0.

Example 1:

 Input: @N = (1, 2, 1, 2)
 Output: 1

 as we jump one place from index 0 and then two places from index 1 to reach
 the last index.

Example 2:

 Input: @N = (2,1,1,0,2)
 Output: 0

 it is impossible to reach the last index. as we jump two places from index 0
 to reach index 2, followed by one place jump from index 2 to reach the index
 3. once you reached the index 3, you can't go any further because you can only
 jump 0 position further.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

The Task description "...value at each index determines how far you are allowed
to jump further" can be interpreted in two ways. Suppose the index is $i and
the value is $n; then, arriving at index $i, one is allowed to jump either:

(1) exactly $n indices forward; or
(2) any number of indices between 1 and $n forward, at the jumper's discretion.

As (2) is the more interesting case, I've made it the default. For (1), enter

    --exact

on the command line. I've also included a

    --verbose

command-line option, which displays each step of the search. For case (2),
which is solved via backtracking (implemented using recursion), the verbose
output is useful because it shows which moves failed and why, and which move
(if any) was the first to succeed.

=end comment
#==============================================================================

my Bool $Verbose;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 091, Task #2: Jump Game (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    *@N where { .elems > 0 && .all ~~ UInt:D },     #= 1+ non-negative integers
    Bool:D :$exact   = False,                       #= Allow exact moves only
    Bool:D :$verbose = False,                       #= Show the steps followed
)
#==============================================================================
{
    $Verbose = $verbose;

    "Input:  @N = (%s)\n".printf: @N.join: ', ';

    my Bool $result;

    if $exact
    {
        "\nOnly *exact* jumps are allowed\n".put                   if $Verbose;
        $result = jump-exact(@N);
    }
    else
    {
        "\nThe value at each index is the *maximum* jump allowed\n".put
                                                                   if $Verbose;
        $result = jump-up-to(@N, 0);
    }

    ''.put                                                         if $Verbose;
    "Output: %d\n".printf: $result ?? 1 !! 0;
}

#------------------------------------------------------------------------------
sub jump-exact
(
    Array:D[UInt:D] $N,
--> Bool:D
)
#------------------------------------------------------------------------------
{
    my Bool $result = True;
    my UInt $index  = 0;

    until $index == $N.end
    {
        my UInt $jump = $N[$index];

        if $jump == 0
        {
            _log('Failure: jump at index %d is 0', $index);
            $result = False;
            last;
        }

        _log('At index %d, jumping %d', $index, $jump);
        $index += $jump;

        if $index > $N.end
        {
            _log('Failure: reached index %d', $index);
            $result = False;
            last;
        }
    }

    _log('Success: reached index %d', $index) if $result;

    return $result;
}

#------------------------------------------------------------------------------
sub jump-up-to                                           # Recursive subroutine
(
    Array:D[UInt:D] $N,
    UInt:D          $index,
--> Bool:D
)
#------------------------------------------------------------------------------
{
    my Bool $result = False;

    if    $index == $N.end              # Base case 1: Success (target reached)
    {
        _log('Success: reached index %d', $index);
        $result = True;
    }
    elsif $index >  $N.end              # Base case 2: Failure (jumped too far)
    {
        _log('Failure: reached index %d, backtracking...', $index);
    }
    elsif $N[$index] == 0               # Base case 3: Failure (zero jump)
    {
        _log('Failure: jump at index %d is 0, ' ~
             ($index ?? 'backtracking...' !! 'search ended'), $index);
    }
    else
    {
        for $N[$index] ... 1 -> UInt $i                   # Prefer longer jumps
        {
            _log('At index %d, jumping %d', $index, $i);

            last if $result = jump-up-to($N, $index + $i);  # Recursive case 1:
        }                                                   #           Success

        unless $result        # Recursive case 2: Failure (all jumps exhausted)
        {
            _log('Failure: all jumps failed at index %d, ' ~
                 ($index ?? 'backtracking...' !! 'search ended'), $index);
        }
    }

    return $result;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

#------------------------------------------------------------------------------
sub _log( Str:D $format, *@args )
#------------------------------------------------------------------------------
{
    "--$format\n".printf: @args if $Verbose;
}

##############################################################################
