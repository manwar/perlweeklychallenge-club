#! /usr/bin/env perl

use strict;
use warnings;

$ARGV[0] =~ /^(\d\d)\:(\d\d)\s?(am|pm)?$/ && length($3)
   ? ($3 eq "pm"
       ? print $1 eq '12' ? '12' : $1 + 12, ":$2\n"
       : print $1 eq '12' ? '00' : $1, ":$2\n"
     )
   : ($1 >= 12 && $1 < 24
       ? print $1 eq '12' ? '12' : sprintf('%02d', $1 - 12), ":$2 pm\n" 
       : print $1 eq '00'|| $1 eq '24' ? '12' : $1, ":$2 am\n"
     );

