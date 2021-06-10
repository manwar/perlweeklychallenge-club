#!perl

###############################################################################
=comment

Perl Weekly Challenge 108
=========================

TASK #1
-------
*Locate Memory*

Submitted by: Mohammad S Anwar

Write a script to declare a variable or constant and print it's location in the
memory.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Note: "location in the memory" is rather a vague expression. As I understand
it, the solution below gives the memory location *relative to* the memory
segment allocated by the OS to this instance of the perl interpreter; this is
not the *absolute* address.

The scalar's "head" contains meta-information about the variable. Its actual
value (42 in this case) is stored in the "body".

=cut
#==============================================================================

use strict;
use warnings;
use Capture::Tiny qw( capture_stderr );
use Const::Fast;
use Devel::Peek;

const my $USAGE => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 108, Task #1: Locate Memory (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";

    my $var  = 42;
    my $dump = capture_stderr { Dump $var };

    my ($body, $head) =
        $dump =~ / IV \( 0x ([0-9a-f]+) \) \s at \s 0x ([0-9a-f]+) /x;

    print 'Memory location of $var following the statement ',
        qq["my \$var = 42;"\n],
          "- The scalar's head is allocated at address 0x$head\n",
          "- The scalar's body is allocated at address 0x$body\n";
}

###############################################################################
