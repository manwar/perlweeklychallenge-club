#!perl

###############################################################################
=comment

Perl Weekly Challenge 173
=========================

TASK #2
-------
*Sylvester’s sequence*

Submitted by: Mohammad S Anwar

Write a script to generate first 10 members of Sylvester's sequence. For more
informations, please refer to the [ https://en.wikipedia.org/wiki/Sylvester
%27s_sequence |wikipedia page].

Output

  2
  3
  7
  43
  1807
  3263443
  10650056950807
  113423713055421844361000443
  12864938683278671740537145998360961546653259485195807
  165506647324519964198468195444439180017513152706377497841851388766535868639
     572406808911988131737645185443

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
Since numbers in Sylvester's sequence quickly become very large, they may be
easier to read with their digits separated into groups of 3. To do this, set
the constant $SEP to the value of the separator required (e.g., a comma or a
space).

Algorithm
---------
Large numbers are accommodated via the "use bigint;" pragma.

Successive elements of Sylvester's sequence are calculated using the recurrence
relation:

    a(n+1) = a(n)² - a(n) + 1

from [1]. This is re-arranged to the equivalent:

    a(n+1) = a(n) × (a(n) - 1) + 1.

References
----------
[1] "A000058 Sylvester's sequence: a(n+1) = a(n)^2 - a(n) + 1, with a(0) = 2.",
     OEIS, https://oeis.org/A000058
[2] "Sylvester's sequence", Wikipedia,
     https://en.wikipedia.org/wiki/Sylvester%27s_sequence

=cut
#==============================================================================

use strict;
use warnings;
use bigint;
use Const::Fast;

const my $SEP    => '';
const my $TARGET => 10;
const my $USAGE  => "Usage:\n  perl $0\n";
const my $WRAP   => 72;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 173, Task #2: Sylvester's sequence (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";

    print "The first $TARGET numbers of Sylvester's sequence:\n";

    my $sylvester = 2;

    printf "%2d:  %d\n", 1, $sylvester;

    for my $i (2 .. $TARGET)
    {
        $sylvester *= $sylvester - 1;
      ++$sylvester;

        my $string = $SEP ? add_separators( $sylvester, $SEP ) : $sylvester;
           $string = substr( $string, 0, $WRAP ) . "\n     " .
                     substr( $string, $WRAP    ) if length $string > $WRAP;

        printf "%2d:  %s\n", $i, $string;
    }
}

#-------------------------------------------------------------------------------
sub add_separators
#-------------------------------------------------------------------------------
{
    my ($num, $sep) = @_;

    # Regex from perlfaq5: "How can I output my numbers with commas added?"

    return $num =~ s/(^\d+?(?=(?>(?:\d{3})+)(?!\d))|\G\d{3}(?=\d))/$1$sep/gr;
}

###############################################################################
