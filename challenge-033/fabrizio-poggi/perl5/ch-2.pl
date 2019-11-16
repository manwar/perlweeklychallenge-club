#!/usr/bin/perl
use strict;
use warnings;

my $i=0;
my $j=0;
my $sep="|";
my $res=0;
my $spa="    ";

print " x |   1   2   3   4   5   6   7   8   9  10  11\n";
print "------------------------------------------------\n";

for ($i=1; $i<12;$i++){
    printf ("%2d %s",$i,$sep);
    for ($j=1; $j<12; $j++) {
      $res=$i*$j;
	  if($j<=$i-1){
           print $spa;
           }else{
           printf (" %3d",$res);
	   }
	 }
print "\n";
}
