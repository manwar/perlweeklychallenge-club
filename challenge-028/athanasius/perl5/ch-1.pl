#!perl

################################################################################
=comment

Perl Weekly Challenge 028
=========================

Task #1
-------
Write a script to check the file content without actually reading the content.
It should accept file name with path as command line argument and print *"The
file content is binary."* or else *"The file content is ascii."* accordingly.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;

const my $USAGE => "USAGE: perl $0 <Path>\n";

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    @ARGV == 0 and die $USAGE;
    @ARGV >  1 and die "Too many command line arguments\n$USAGE";

    $_ = $ARGV[0];

    # See https://perldoc.perl.org/5.30.0/functions/-X.html

    my $description = ! -e ? 'This does not exist'      :
                        -d ? 'This is a directory'      :
                      ! -f ? 'This is not a plain file' :
                        -z ? 'The file is empty'        :
                        -T ? 'The file content is text' :
                             'The file content is binary';

    print qq{"$_": $description\n};
}

################################################################################
