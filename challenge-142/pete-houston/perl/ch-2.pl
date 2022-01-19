#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 14202.pl
#
#        USAGE: ./14202.pl N N [ N ] ... 
#
#  DESCRIPTION: Sleep sort array of positive integers from @ARGV
#
# REQUIREMENTS: Threaded perl
#        NOTES: Not to be used for any important purpose. YHBW.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 06/12/21
#===============================================================================

use strict;
use warnings;
use threads;

# Safety cut-out
die "Whoa, cowboy! That's far too many threads.\n" if $#ARGV > 4095;

sub ss {
	my $n = shift;
	sleep $n;
	print $n . ', ';
}

threads->create ('ss', $_) for grep { /^[1-9][0-9]*$/ } @ARGV;
$_->join for threads->list;

print "\n";
