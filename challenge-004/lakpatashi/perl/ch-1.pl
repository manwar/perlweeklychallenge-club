#!/usr/bin/perl

use strict;
use warnings;

# PART 1
use Math::BigFloat qw(bpi);
my $size = -s $0;
print "Script size:: $size\n";
print"PI value:: ", bpi($size),"\n" ;
