#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 10702.pl
#
#        USAGE: ./10702.pl Foo.pm
#
#  DESCRIPTION: List the names of subs in the source
#
# REQUIREMENTS: PPI
#        NOTES: The task talks about methods but then just provides
#               empty subs in the sample module. I have therefore assumed
#               that the real requirement is to list all the subs and
#               not just methods as there seems no way to distinguish
#               between them anyway.
#
#               The task also shows BEGIN in its output which is
#               neither a sub nor a method so I've simply assumed that
#               is a mistake.
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 06/04/21
#===============================================================================

use strict;
use warnings;
use PPI;

my $doc  = PPI::Document->new (shift);
my $subs = $doc->find ('PPI::Statement::Sub');
print $_->name . "\n" for @$subs;
