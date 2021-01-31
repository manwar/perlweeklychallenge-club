#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

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

The count_flips() routine counts the number of single-digit flips required to
convert one binary string into another. First, the two strings are XOR'd
together to produce $xor, in which a 1 digit appears in only those positions
where the corresponding digits in the two strings differ from each other.
These 1 digits represent places where a flip is required to convert the first
binary string into the second (or vice versa).

Next, any remaining 0 digits are removed from $xor using transliteration with
the /d option. Finally, the length of $xor -- which is now equal to the number
of 1 digits which resulted from the XOR operation -- is returned.

Verbose output
--------------

If the constant $VERBOSE is set to a true value, each binary substring is dis-
played, along with the number of flips required to convert it to the target
substring.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 <B> <S>

    <B>    Non-empty binary string
    <S>    Substring length: integer in the range 1 .. length(B)\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 097, Task #2: Binary Substrings (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($B, $S) = parse_command_line();

    print qq[Input:  \$B = "$B", \$S = $S\n];

    my ($min_flips, $substrings, $best_i) = find_min_flips( $B, $S );

    print "Output: $min_flips\n";

    if ($VERBOSE)
    {
        print "\nBinary Substrings:\n";

        print "    $_\n" for list_flips( $substrings, $best_i, $S );
    }
}

#------------------------------------------------------------------------------
sub find_min_flips
#------------------------------------------------------------------------------
{
    my ($B, $S) = @_;

    if (length($B) % $S > 0)
    {
        my $zeroes = $S - (length($B) % $S);

        $B = ('0' x $zeroes) . $B;

        printf qq[NOTE:   Left-padding \$B with %d zero%s:\n] .
               qq[        \$B = "%s"\n],
               $zeroes, ($zeroes == 1) ? '' : 's', $B;
    }

    my @substrings = map { oct '0b' . $_ } $B =~ / .{$S} /gx;
    my $min_flips  = $S * scalar @substrings;
    my $best_i     = 0;

    OUTER: for my $i (0 .. $#substrings)
    {
        my $target = $substrings[ $i ];
        my $count  = 0;

        for my $j (0 .. $#substrings)
        {
            next if $i == $j;

            $count += count_flips( $substrings[ $j ], $target );

            next OUTER if $count >= $min_flips;
        }

        $best_i    = $i;
        $min_flips = $count;
    }

    return ($min_flips, \@substrings, $best_i);
}

#------------------------------------------------------------------------------
sub list_flips
#------------------------------------------------------------------------------
{
    my ($substrs, $best_i, $S) = @_;

    my  $target = $substrs->[ $best_i ];
    my  @flips;

    for my $j (0 .. $#$substrs)
    {
        if ($j == $best_i)
        {
            push @flips, sprintf qq["%0*b": 0 flips (target)], $S, $target;
        }
        else
        {
            my $count  = count_flips( $substrs->[ $j ], $target );
            my $plural = ($count == 1) ? ' ' : 's';

            push @flips, sprintf qq["%0*b": %d flip%s to make "%0*b"],
                            $S, $substrs->[ $j ], $count, $plural, $S, $target;
        }
    }

    return @flips;
}

#------------------------------------------------------------------------------
sub count_flips
#------------------------------------------------------------------------------
{
    my ($substr_1, $substr_2) = @_;

    my  $xor =  $substr_1 ^ $substr_2;      # Bitwise exclusive OR
        $xor =~ tr/0//d;                    # Remove 0 digits

    return length $xor;                     # Return count of 1 digits
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;

       $args == 2   or error("Expected 2 command-line arguments, found $args");

    my $B =  $ARGV[ 0 ];
       length($B) > 0                 or  error('B is empty');
       $B =~ / ( [^01] ) /x           and error("Invalid character '$1' in B");

    my $S =  $ARGV[ 1 ];
       $S =~ / ^ $RE{num}{int} $ /x   or  error('Invalid integer S');
       $S >= 1                        or  error('S must be at least 1');
       $S <= length($B)               or  error('S cannot be longer than B');

    return ($B, $S);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
