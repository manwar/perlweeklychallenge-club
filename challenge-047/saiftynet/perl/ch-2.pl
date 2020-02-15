#!/usr/env perl
# Write a script to print first 20 Gapful Numbers greater
# than or equal to 100. Please check out the page for more
# information about Gapful Numbers.
#
# Pre-increment and post-increment in testing, and an empty loop 

my $test=99;  my $found=0;                  
while ($found++<20){
  while( ++$test % (substr($test,0,1).substr($test,-1,1))){}
  print $found," ",$test,"\n";
}
