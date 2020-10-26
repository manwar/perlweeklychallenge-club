#!/usr/bin/env perl
#
#
# I prefer the one  liner:
# perl -ne's/^\W*\w+(.*)\b\w+\W*$/$1/;s/\s//g;print length;print qq(\n);'

use strict;
use warnings;
use 5.010;

if (@ARGV != 1 ) {
	say "You need to provide a quoted string";
	exit
}
my $S = $ARGV[0];

if ($S =~ /^\W*\w+(.*)\b\w+\W*/) {
	$_ = $1;
	if (/\w/){
	       s/\s//g;
	       say length ;
	       exit;
       }
}
say "The string sould contain 3 or more words";






