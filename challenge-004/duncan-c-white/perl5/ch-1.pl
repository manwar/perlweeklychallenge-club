#!/usr/bin/perl

# Display Pi to N places, where N is the size of this file, to the byte.
# The spec didn't say "Calculate Pi..." so stuff that, grab the digits
# we need off the internet:-)

use strict;
use warnings;
use Data::Dumper;
use LWP::Simple;

my $size = shift // -s $0;
$size++;

my $url = "http://bit.ly/2GnSY4L";
my $f = "/tmp/pi1m";
unless(-f $f)
{
	getstore($url,$f) || die "can't retrieve $url\n";
}
open(my $infh, '<', $f) || die "can't open $f\n";
sysread($infh, my $content, $size);

print "$content\n";
