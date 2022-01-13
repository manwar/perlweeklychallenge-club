use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 141
=========================

TASK #2
-------
*Like Numbers*

Submitted by: Mohammad S Anwar

You are given positive integers, $m and $n.

Write a script to find total count of integers created using the digits of $m
which is also divisible by $n.

Repeating of digits are not allowed. Order/Sequence of digits can’t be altered.
You are only allowed to use (n-1) digits at the most. For example, 432 is not
acceptable integer created using the digits of 1234. Also for 1234, you can
only have integers having no more than three digits.

Example 1:

 Input: $m = 1234, $n = 2
 Output: 9

 Possible integers created using the digits of 1234 are:
 1, 2, 3, 4, 12, 13, 14, 23, 24, 34, 123, 124, 134 and 234.

 There are 9 integers divisible by 2 such as:
 2, 4, 12, 14, 24, 34, 124, 134 and 234.

Example 2:

 Input: $m = 768, $n = 4
 Output: 3

 Possible integers created using the digits of 768 are:
 7, 6, 8, 76, 78 and 68.

 There are 3 integers divisible by 4 such as:
 8, 76 and 68.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumptions
-----------
- "You are only allowed to use (n-1) digits at the most." From the examples, I
  assume the "n" here is unrelated to $n, and is a shorthand for the following:
  If $m has n digits, then each created integer may contain between 1 and n-1
  digits.
- "Repeating of digits are not allowed." I assume this means that a digit which
  occurs once in $m cannot occur twice in a created integer. But I assume that
  repeated digits are allowed within $m, and that these repeated digits may
  also occur in created integers (provided they occur in the correct order).
- I assume that the desired output is a count of *unique* solutions.

Configuration
-------------
- If the digit 0 occurs in $m, then the number zero will be a possible created
  integer; and since 0 is evenly divisible by any (non-zero) integer, 0 will
  then always appear in the solution set. It is not clear from the Task Des-
  cription whether this is the desired result; so the constant $ALLOW_0 is pro-
  vided. When it is set to True (the default), 0 may appear in the solution
  set; when it is set to False, the number 0 will be excluded from the solution
  set.
- When the constant $VERBOSE is set to True (the default), the output will be
  followed by a list of possible integers and a list of the integers in the
  solution set, as shown in the Task Description.

Algorithm
---------
Determining whether a created integer is evenly divisible by $n is trivial. But
the construction of possible integers which precedes this step is more inter-
esting:

    [Array] pool := the empty string
    FOR each digit d in $m (most to least significant digit)
        FOR each entry p in pool (as it is populated on *entering* this loop)
            concatenate p with d and store the result ("pd") in pool
        ENDFOR
    ENDFOR
    Remove the empty string and the string representing $m from pool
    Remove any strings beginning with an initial '0'
    Optionally restore the number zero itself
    Remove duplicates from pool
    Convert the strings in pool to integers
    Sort the integers in pool in ascending numerical order

The above algorithm could also be performed in reverse:

    FOR each digit d in $m (least to most significant digit)
        FOR each entry p in pool (as it is populated on *entering* this loop)
            concatenate d with p and store the result ("dp") in pool
        ENDFOR
    ENDFOR

=end comment
#==============================================================================

my Bool constant $VERBOSE = True;
my Bool constant $ALLOW_0 = True;

subset Positive of Int where * > 0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 141, Task #2: Like Numbers (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Positive:D $m,            #= Positive integer: source of digits
    Positive:D $n             #= Positive integer: divisor
)
#==============================================================================
{
    "Input:  \$m = $m, \$n = $n".put;

    my UInt @ints = find-all-integers( $m );
    my UInt @like;

    for @ints -> UInt $i
    {
        @like.push: $i if $i % $n == 0;
    }

    "Output: %d\n".printf: @like.elems;

    explain( $m, $n, @ints, @like ) if $VERBOSE;
}

#------------------------------------------------------------------------------
sub find-all-integers( Positive:D $m --> Seq:D[UInt:D] )
#------------------------------------------------------------------------------
{
    my Str @pool = '';

    for $m.split( '', :skip-empty ) -> Str $digit
    {
        @pool.push: @pool[ $_ ] ~ $digit for 0 .. @pool.end;
    }

    @pool.shift;                       # Remove the empty string
    @pool.pop;                         # Remove $m
    @pool.=grep: { !/ ^ 0 / };         # Remove all strings beginning with zero

    @pool.push: '0' if $ALLOW_0 && $m ~~ / 0 /;           # Restore zero itself

    my UInt %uniq;                     # Remove duplicates
          ++%uniq{ $_ } for @pool;

    return %uniq.keys.map( { .Int } ).sort;
}

#------------------------------------------------------------------------------
sub explain
(
    Positive:D      $m,
    Positive:D      $n,
    Array:D[UInt:D] $ints,
    Array:D[UInt:D] $like
)
#------------------------------------------------------------------------------
{
    my UInt $possibles = @$ints.elems;
    my UInt $solutions = @$like.elems;

    "\n%d integer%s can be created using the digits of %d".printf:
        $possibles, ($possibles == 1 ?? ''   !! 's'  ), $m;

    (($possibles == 0) ?? '' !! ":\n" ~ @$ints.join( ', ' )).put;

    "\nof which %d %s evenly divisible by %d".printf:
        $solutions, ($solutions == 1 ?? 'is' !! 'are'), $n;

    (($solutions == 0) ?? '' !! ":\n" ~ @$like.join( ', ' )).put;
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
