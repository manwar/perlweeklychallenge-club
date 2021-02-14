use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 099
=========================

Task #2
-------
*Unique Subsequence*

Submitted by: Mohammad S Anwar

You are given two strings $S and $T.

Write a script to find out count of different unique subsequences matching $T
without changing the position of characters.

*UPDATE: 2021-02-08 09:00AM (UK TIME) suggested by Jonas Berlin, missing entry
[5].*

Example 1:

 Input: $S = "littleit', $T = 'lit'
 Output: 5

     1: [lit] tleit
     2: [li] t [t] leit
     3: [li] ttlei [t]
     4: litt [l] e [it]
     5: [l] ittle [it]

Example 2:

 Input: $S = "london', $T = 'lon'
 Output: 3

     1: [lon] don
     2: [lo] ndo [n]
     3: [l] ond [on]

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm: Recursive search. The subroutine fine-subseqs() searches $S for the
first character in $T, and then recursively searches the remainder of $S for
the remainder of $T. The recursion ends when either $S or $T is exhausted. (In
the first case, no match was found; in the second case, a match has been found
and is recorded in the @subseqs array.)

Note: If $VERBOSE is set to True, details of all the different subsequences
found are displayed after the Output, as in the Examples. This is done using
the subroutine partition(), which inserts square brackets around those charac-
ters in $S which form a given subsequence.

=end comment
#==============================================================================

my Bool constant $VERBOSE = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 099, Task #2: Unique Subsequence (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Str:D $S where { $S.chars > 0 },  #= Non-empty string to be searched
    Str:D $T where { $S.chars > 0 }   #= Non-empty substring to search for in S
)
#==============================================================================
{
    qq[Input:  \$S = "$S", \$T = "$T"].put;

    my Array[UInt] @subseqs;
    my UInt        $subseqs = 0;

    if $T.chars <= $S.chars      # No match is possible if $T is longer than $S
    {
        find-subseqs( $S, 0, $T, @subseqs );
        $subseqs = @subseqs.elems;
    }

    "Output: $subseqs".put;

    if $VERBOSE && $subseqs > 0
    {
        my UInt $count = 0;

        "\n".print;
        "    %d: %s\n".printf: ++$count, partition( $S, $_ ) for @subseqs;
    }
}

#------------------------------------------------------------------------------
sub find-subseqs                                     #  Recursive subroutine
(
    Str:D                    $s,                     #= String to be searched
    UInt:D                   $i,                     #= Start index for search
    Str:D                    $t,                     #= Substring to search for
    Array:D[Array:D[UInt:D]] $subseqs                #= Subsequences found
)
#------------------------------------------------------------------------------
{
    state UInt @seq;

    # (1) Separate the search substring into $t0, its first character, and
    #     $t-rem, the remaining characters (if any)

    $t ~~ / ^ (.) (.*) $ /;
    my Str ($t0, $t-rem) = $/.map: { .Str };

    # (2) Beginning with the character at index $i, check each remaining
    #     character in $s as a possible match for $t0: if it matches, add the
    #     character's index ($j) to the array @seq and recursively search the
    #     remainder of $s for the substring $t-rem

    for $i .. $s.chars - 1 -> UInt $j
    {
        if $t0 eq $s.substr: $j, 1
        {
            @seq.push: $j;                  # Add index $j to the sequence

            if $t-rem.chars == 0
            {
                $subseqs.push: @seq.clone;  # Copy the sequence and record it
            }
            else
            {
                find-subseqs( $s, $j + 1, $t-rem, $subseqs );  # Recursive call
            }

            @seq.pop;                       # Remove index $j from the sequence
        }
    }
}

#------------------------------------------------------------------------------
sub partition( Str:D $S, Array:D[UInt:D] $seq --> Str:D )
#------------------------------------------------------------------------------
{
    my Str @partition = $S.split: '', :skip-empty;

    # (1) Add square brackets around each character in the subsequence

    for @$seq -> UInt $i
    {
        @partition[ $i ] = ' [' ~ @partition[ $i ] ~ '] ';
    }

    # (2) Remove initial and trailing spaces, and brackets and spaces internal
    #     to a sequence of contiguous characters. E.g., " [l]  [i]  [t] tleit"
    #     becomes  "[lit] tleit"

    my Str $partition = @partition.join: '';

    $partition ~~ s :g / \] \s ** 2 \[ //;  # Remove internal brackets & spaces
    $partition ~~ s    /  ^ \s         //;  # Remove initial  space
    $partition ~~ s    /    \s $       //;  # Remove trailing space

    return $partition;
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
