#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

# line1
for(0..$#ARGV){
if($ARGV[$_] == 1
or $ARGV[$_] == 4){&space7;if($_<$#ARGV){&space};if($_==$#ARGV){print "\n"}};

if($ARGV[$_] == 2 
or $ARGV[$_] == 3
or $ARGV[$_] == 5 
or $ARGV[$_] == 6
or $ARGV[$_] == 7
or $ARGV[$_] == 8
or $ARGV[$_] == 9
or $ARGV[$_] == 0){&draw_147;if($_<$#ARGV){&space};if($_==$#ARGV){print "\n"}};
}

# line23
for(1..2){
for(0..$#ARGV){
if($ARGV[$_] == 5
or $ARGV[$_] == 6){&draw_2356_l;if($_<$#ARGV){&space};if($_==$#ARGV){print "\n"}};

if($ARGV[$_] == 1
or $ARGV[$_] == 2
or $ARGV[$_] == 3
or $ARGV[$_] == 7){&draw_2356_r;if($_<$#ARGV){&space};if($_==$#ARGV){print "\n"}};	

if($ARGV[$_] == 4
or $ARGV[$_] == 8
or $ARGV[$_] == 9
or $ARGV[$_] == 0){&draw_2356_b;if($_<$#ARGV){&space};if($_==$#ARGV){print "\n"}};	
}
}

# line4
for(0..$#ARGV){
if($ARGV[$_] == 2
or $ARGV[$_] == 3
or $ARGV[$_] == 4
or $ARGV[$_] == 5
or $ARGV[$_] == 6
or $ARGV[$_] == 8
or $ARGV[$_] == 9){&draw_147;if($_<$#ARGV){&space};if($_==$#ARGV){print "\n"}};

if($ARGV[$_] == 1
or $ARGV[$_] == 7
or $ARGV[$_] == 0){&space7;if($_<$#ARGV){&space};if($_==$#ARGV){print "\n"}};	
}
# line56
for(1..2){
for(0..$#ARGV){
if($ARGV[$_] == 2){&draw_2356_l;if($_<$#ARGV){&space};if($_==$#ARGV){print "\n"}};

if($ARGV[$_] == 1
or $ARGV[$_] == 3
or $ARGV[$_] == 4
or $ARGV[$_] == 5
or $ARGV[$_] == 7
or $ARGV[$_] == 9){&draw_2356_r;if($_<$#ARGV){&space};if($_==$#ARGV){print "\n"}};

if($ARGV[$_] == 6
or $ARGV[$_] == 8
or $ARGV[$_] == 0){&draw_2356_b;if($_<$#ARGV){&space};if($_==$#ARGV){print "\n"}};
}
}

# line7
for(0..$#ARGV){
if($ARGV[$_] == 1
or $ARGV[$_] == 4
or $ARGV[$_] == 7){&space7;if($_<$#ARGV){&space};if($_==$#ARGV){print "\n"}};	
	
if($ARGV[$_] == 2
or $ARGV[$_] == 3
or $ARGV[$_] == 5
or $ARGV[$_] == 6
or $ARGV[$_] == 8
or $ARGV[$_] == 9
or $ARGV[$_] == 0){&draw_147;if($_<$#ARGV){&space};if($_==$#ARGV){print "\n"}};
}

# line1 - (2,3,5,6,7,8,9,0) - (-------)
# line2,3 -left - (5,6) - (|) 
# line2,3 -right- (1,2,3,7) - (|)
# line2,3 -both-(4,8,9,0) (|      |)
# line4 - (2,3,4,5,6,8,9) - (-------)
# line5,6 -left - (2) - (|)
# line5,6 -right - (1,3,4,5,7,9) (|)
# line5,5 -both-(6,8,0) (|     |)
# line7 - (2,3,5,6,8,9,0) - (-------)

sub draw_147{print "-"x7};
sub draw_2356_l{printf"%-7s","|"};
sub draw_2356_r{printf"%7s","|"};
sub draw_2356_b{printf"%s","|     |"};
sub space{print "  "};
sub space7{print " "x7};

