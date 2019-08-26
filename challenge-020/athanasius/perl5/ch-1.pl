#!perl

################################################################################
=comment

Perl Weekly Challenge 020
=========================

Task #1
-------
Write a script to accept a string from command line and split it on change of
character. For example, if the string is *"ABBCDEEF"*, then it should split like
*"A"*, *"BB"*, *"C"*, *"D"*, *"EE"*, *"F"*.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;

const my $DEFAULT => 'ABBCDEEF';

MAIN:
{
    my $string  = $ARGV[0] // $DEFAULT;
    my @matches = $string =~ / ( (.) \g{-1}* ) /gx;
    my $select  = 0;
       @matches = grep { $select = !$select } @matches;

    print "\n",
          "Original string:      \"$string\"\n",
          "After splitting on\n",
          "changes of character: ",
           join(', ', map { "\"$_\"" } @matches),
          "\n";
}

################################################################################
