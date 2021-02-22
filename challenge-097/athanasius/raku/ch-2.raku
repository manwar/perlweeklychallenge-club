use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 097
=========================

Task #2
-------
*Binary Substrings*

Submitted by: Mohammad S Anwar

You are given a binary string $B and an integer $S.

Write a script to split the binary string $B of size $S and then find the
minimum number of flips required to make it all the same.

Example 1:

 Input: $B = "101100101", $S = 3
 Output: 1

 Binary Substrings:
     "101": 0 flip
     "100": 1 flip to make it "101"
     "101": 0 flip

Example 2:

 Input $B = "10110111", $S = 4
 Output: 2

 Binary Substrings:
     "1011": 0 flip
     "0111": 2 flips to make it "1011"

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interpretation
--------------

The Task is to take a binary string $B, split it into substrings each of length
$S, and then find the minimum number of one-digit flips required to make the
substrings identical.

In Example 2, the second substring is flipped to match the first substring. Let
the first substring in this case be called the target. Then the Task may be re-
stated in this way: to identify the target substring to which all the other
substrings may be converted with an overall minimum number of flips.

Although both Examples show the *first* substring as the target, this need not
be the case. It is therefore necessary to try each substring as a potential
target.

How should the script handle the case where the number of characters in $B is
not evenly divisible by $S? Two strategies are possible:

(1) Reject $S unless it is a a divisor (i.e., a factor) of length($B)
(2) Extend $B by adding characters until length($B) is an exact multiple of $S

The solution adopted here is to implement strategy (2) by left-padding $B with
zero digits, thereby preserving $B's numerical value. Whenever zeroes are added
in this way, the user is notified and the newly-padded string is displayed.

Implementation
--------------

The count-flips() routine counts the number of single-digit flips required to
convert one binary string into another. First, the two strings are XOR'd
together to produce $xor, in which a 1 digit appears in only those positions
where the corresponding digits in the two strings differ from each other.
These 1 digits represent places where a flip is required to convert the first
binary string into the second (or vice versa).

Next, any remaining 0 digits are removed from $xor using Raku's transliteration
operator. Finally, the length of $xor -- which is now equal to the number of 1
digits which resulted from the XOR operation -- is returned.

Verbose output
--------------

If the constant $VERBOSE is set to True, each binary substring is displayed,
along with the number of flips required to convert it to the target substring.

=end comment
#==============================================================================

my Bool constant $VERBOSE = True;

subset BinStr of Str where * ~~ / ^ <[ 0 1 ]>* $ /;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 097, Task #2: Binary Substrings (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    BinStr:D $B where { $B.chars > 0 },          #= Non-empty binary string
    UInt:D   $S where { 0 < $S <= $B.chars }     #= Substring length: integer
                                                 #= in the range 1 .. length(B)
)
#==============================================================================
{
    qq[Input:  \$B = "%s", \$S = %d\n].printf: $B, $S;

    my (UInt          $min-flips,
        Array[BinStr] $substrings,
        UInt          $best-i) = find-min-flips( $B, $S );

    qq[Output: %d\n].printf: $min-flips;

    if $VERBOSE
    {
        "\nBinary Substrings:".put;

        "    $_".put for list-flips( $substrings, $best-i );
    }
}

#------------------------------------------------------------------------------
sub find-min-flips
(
    BinStr:D $B,                    #= Binary string
    UInt:D   $S,                    #= Substring length
--> List:D[ 
             UInt:D,                #= Minimum number of flips required to make
                                    #=   all of the substrings the same
             Array:D[BinStr:D],     #= The substrings
             UInt:D                 #= Index of the target substring (i.e., the
                                    #=   substring to which all the others are
          ]                         #=   to be converted)
)
#------------------------------------------------------------------------------
{
    my BinStr $bin = $B;

    if $B.chars % $S > 0
    {
        my $zeroes = $S - ($B.chars % $S);

        $bin = ('0' x $zeroes) ~ $B;

        qq[NOTE:   Left-padding \$B with %d zero%s:\n        \$B = "%s"\n].\
            printf: $zeroes, ($zeroes == 1) ?? '' !! 's', $bin;
    }

    my BinStr @substrings = map { .Str }, $bin ~~ m:g/ . ** {$S} /;
    my UInt   $min-flips  = $S * @substrings.elems;
    my UInt   $best-i     = 0;

    OUTER-FOR: for 0 .. @substrings.end -> UInt $i
    {
        my BinStr $target = @substrings[ $i ];
        my UInt   $count  = 0;

        for 0 .. @substrings.end -> UInt $j
        {
            next if $i == $j;

            $count += count-flips( @substrings[ $j ], $target );

            next OUTER-FOR if $count >= $min-flips;
        }

        $best-i    = $i;
        $min-flips = $count;
    }

    return $min-flips, @substrings, $best-i;
}

#------------------------------------------------------------------------------
sub list-flips
(
    Array:D[BinStr:D] $substrs,     #= The substrings
    UInt:D            $best-i,      #= Index of the target substring (i.e., the
                                    #=   substring to which all the others are
                                    #=   to be converted)
--> Array:D[Str:D]                  #= Descriptions of the required flips
)
#------------------------------------------------------------------------------
{
    my BinStr $target = $substrs[ $best-i ];
    my UInt   $S      = $target.chars;
    my Str    @flips;

    for 0 .. $substrs.end -> UInt $j
    {
        if $j == $best-i
        {
            @flips.push: qq["$target": 0 flips (target)];
        }
        else
        {
            my UInt $count  = count-flips( $substrs[ $j ], $target );
            my Str  $plural = ($count == 1) ?? ' ' !! 's';

            @flips.push: qq["%s": %d flip%s to make "%s"].sprintf:
                            $substrs[ $j ], $count, $plural, $target;
        }
    }

    return @flips;
}

#------------------------------------------------------------------------------
sub count-flips
(
    BinStr:D $str1,    #= First  binary string
    BinStr:D $str2,    #= Second binary string
--> UInt:D             #= Number of flips required to convert the second binary
                       #=   string into the first
)
#------------------------------------------------------------------------------
{
    my BinStr $xor = ( :2($str1) +^ :2($str2) ).base(2);
              $xor ~~ tr/0//;

    return $xor.chars;
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
