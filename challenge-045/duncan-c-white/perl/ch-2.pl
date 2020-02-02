#!/usr/bin/perl
#
# Task #2: "Source Dumper:
# 
# Write a script that dumps its own source code. For example, say, the
# script name is ch-2.pl then the following command should returns nothing.
# 
# $ perl ch-2.pl | diff - ch-2.pl
# "
# 
# My notes: trivial if we're allowed to use $0.
# 

use feature 'say';
use strict;
use warnings;


open( my $fh, '<', $0 ) || die "can't read $0\n";
while( <$fh> )
{
	chomp;
	say;
}
