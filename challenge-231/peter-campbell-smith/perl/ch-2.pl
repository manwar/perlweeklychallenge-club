#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-08-21
use utf8;     # Week 231 task 2 - Senior citizens
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

senior_citizens('7868190130M7522','5303914400F9211','9273338290F4010');
senior_citizens('1313579440F2036','2921522980M5644');
senior_citizens('0000000000M5900', '0000000000M6000', '0000000000M6100', '0000000000M6200');

sub senior_citizens {
	
	say qq[\nInput: (] . join(', ', @_) . ')';
	say qq[Output: ] . grep(/^.{11}[6789]/, @_);
}