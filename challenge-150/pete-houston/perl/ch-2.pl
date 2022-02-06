#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 15002.pl
#
#        USAGE: ./15002.pl  
#
#  DESCRIPTION: Output all square-free integers less than 501
#
# REQUIREMENTS: Math::Prime::Util
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 31/01/22
#===============================================================================

use strict;
use warnings;
use Math::Prime::Util qw/forsquarefree/;

my @sf;
forsquarefree { push @sf, $_ } 500;
print 'The smallest positive square-free integers are: ' .
	join (', ', @sf) . "\n";
