#!perl

###############################################################################
=comment

Perl Weekly Challenge 098
=========================

Task #1
-------
*Read N-characters*

Submitted by: Mohammad S Anwar

You are given file $FILE.

Create subroutine readN($FILE, $number) returns the first n-characters and
moves the pointer to the (n+1)th character.

Example:

 Input: Suppose the file (input.txt) contains "1234567890"
 Output:
     print readN("input.txt", 4); # returns "1234"
     print readN("input.txt", 4); # returns "5678"
     print readN("input.txt", 4); # returns "90"

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

The subroutine readN()'s parameter $FILE is a file *name*. In Perl, a file
*handle* contains an in-built pointer to the next character. So, the implemen-
tation of readN() given below uses a local but persistent hash to match file
names to their corresponding handles; the remaining bookkeeping for the file
pointer is then performed "under the hood" by Perl itself.

The MAIN code demonstrates readN()'s functionality using two small files:
'digit.txt' contains the digits 1 to 9 and 0 as in the Example, and 'alpha.txt'
contains the lowercase letters a to z. MAIN calls readN() ten times with alter-
nating filenames and assorted values of $number to show that:
  -- calls with different filenames are handled independently of each other
  -- readN() "remembers" the position of the next character from one call to
     another
  -- once the file is exhausted, calls to readN() return the empty string.

To be useful in practice, the readN() subroutine should also have a reset
facility. This is provided via a third, optional parameter to readN().

=cut
#==============================================================================

use strict;
use warnings;
use feature        qw( state );
use Const::Fast;
use Fcntl          qw( :seek );
use Regexp::Common qw( number );

const my $DIGIT => 'digit.txt';
const my $ALPHA => 'alpha.txt';

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 098, Task #1: Read N-characters (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0
            or die sprintf 'ERROR: Found %d command-line argument%s, ' .
                           "expected none\n", $args, ($args == 1) ? '' : 's';

    open( my $digit_fh, '<', $DIGIT )
        or die qq[Can't open file "$DIGIT" for reading, stopped];

    open( my $alpha_fh, '<', $ALPHA )
        or die qq[Can't open file "$ALPHA" for reading, stopped];

    print    "Input:\n";
    printf qq[  File "%s" contains "%s"\n], $DIGIT, <$digit_fh>;
    printf qq[  File "%s" contains "%s"\n], $ALPHA, <$alpha_fh>;
    print  "\nOutput:\n";

    for ( [$DIGIT => 4], [$ALPHA => 5], [$DIGIT => 3], [$ALPHA => 3],
          [$DIGIT => 1], [$ALPHA => 4], [$DIGIT => 7], [$ALPHA => 4],
          [$DIGIT => 2], [$DIGIT => 2, 1] )
    {
        my ($FILE, $number) = @$_;
        my  $string = readN( $FILE, $number );

        printf qq[  Read %d character%s from %s: "%s"\n],
                  $number, ($number == 1) ? ' ' : 's', $FILE, $string;
    }

    printf qq[  Reset and\n  read 3 characters from $DIGIT: "%s"\n],
              readN( $DIGIT, 3, 1 );
}

#------------------------------------------------------------------------------
sub readN
#------------------------------------------------------------------------------
{
    state %pointers;

    my ($FILE, $number, $reset) = @_;

    $number =~ / ^ $RE{num}{int} $ /x && $number > 0
        or die "Invalid \$number($number): must be an integer > 0\n";

    if (exists $pointers{ $FILE })
    {
        seek( $pointers{ $FILE }, 0, SEEK_SET ) if $reset;
    }
    else
    {
        open( my $fh, '<', $FILE )
            or die qq[Can't open file "$FILE" for reading, stopped];

        $pointers{ $FILE } = $fh;
    }

    my $fh   = $pointers{ $FILE };
    my $text = '';

    for (1 .. $number)
    {
        if (defined( my $char = getc $fh ))
        {
            $text .= $char;
        }
        else
        {
            last;
        }
    }

    return $text;
}

###############################################################################
