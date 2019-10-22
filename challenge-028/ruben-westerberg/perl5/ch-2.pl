#!/usr/bin/env perl
use strict;
use warnings;
use  Time::HiRes qw<usleep>;
use POSIX qw<strftime>;
use v5.26;
$|=1;
while (1) {
	state $c=0;
	if  (($c++ % 10) == 0) {
		print "\x1b[2K";
		 print "\x1b[1000D";
		print strftime "%H:%M:%S", localtime;
	}
	usleep 100000;;
	print "=";
	
}


