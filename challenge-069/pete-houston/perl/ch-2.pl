#!/usr/bin/env perl
#===============================================================================
#
#        FILE: 6902.pl
#
#        USAGE: ./6902.pl [ num ]
#
#  DESCRIPTION: Use switch and reverse to find the nth iteration as per
#              https://perlweeklychallenge.org/blog/perl-weekly-challenge-069/
#              Uses the supplied argument as n or defaults to 30
#
#        NOTES: Caveat haxxor: the output for n = 30 is extremely long.
#      AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      CREATED: 13/07/20 22:43:12
#===============================================================================

use strict;
use warnings;

my $str = '';
my $n  = shift @ARGV // 30;
$str    = $str . '0' . switch (scalar reverse $str) for 1 .. $n;

print "String $n is $str\n";

sub switch {
    (my $x = shift) =~ y/01/10/;
    return $x;
}
