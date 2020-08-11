#!perl

################################################################################
=comment

Perl Weekly Challenge 031
=========================

Task #2
-------
Create a script to demonstrate creating *dynamic variable name*, assign a value
to the variable and finally print the variable. The *variable name* would be
passed as command line argument.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;

const my $USAGE => "USAGE: perl $0 <Str>\n";
const my $VALUE =>  42;

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    scalar @ARGV == 1 or die $USAGE;

    my $variable_name = $ARGV[0];

    {
        no strict qw( refs );

        $$variable_name = $VALUE;

        print "\$$variable_name = $$variable_name\n";
    }
}

################################################################################
