#!/usr/bin/env perl
use strict;
use warnings;
use v5.26;

my $URI=$ARGV[0]//'HTTP://a.uri/with/strange%65characters{}?query=true#frag<>';

print "Original URI:\t$URI\n";
#%Encode any character outside of restriced and unrestricted set except %
$URI=~s/([^0-9a-zA-Z-_.~%!*'();:@&=+\$,\/?#\[\]])/{sprintf("%%%2X",ord $1)}/ge;

#Normalize decode any encoded unresreved characters. Normalize encoding to upper case
$URI=~s/\%([a-fA-F0-9]{2,2})/{decode($1)}/ge;
sub decode {
	my $h=shift;
	my $c=chr hex $h;
	$c=~/[0-9a-zA-Z-_.~]/ ? $c:uc "%$h";
}

#Scheme to lower case
$URI=~s/^([a-zA-Z][a-zA-Z\-\.\+]+)/{lc $1}/e;

print "Normalized URI:\t$URI\n";
