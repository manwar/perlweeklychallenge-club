#!/usr/bin/env perl
# The is  a solution to Challenge 165, that actually does both challenges

# Challenge one reads data either points (two numbers separated by commas)
# or lines 4 numbers separated by commas, one item per line to generate
# an SVG file.  The data input is from a file specified by using an option -i
# or from the __DATA__
# line of best fit is disabled by -l 0
# e.g. ch-1or2.pl -i in.dat -l 0
 
# Challenge two does the same but also draws the best fit straight line
# using least squares method.  this is the default operation and uses data
# provided. Note if lines are included, they are drawn but not added to the data
# for line of best fit

# Usage:  ch-1or2.pl   Default...just does challenge 2 using data in __DATA__
#         ch-1or2.pl <-i inputFile> <-o outputfile> specify input and output files
#         ch-1or2.pl -l 0   Disables line of best fit

use strict;
use warnings;

my %params=@ARGV; # read command line params as hash 
# input data
my $infilename= ((exists $params{"-i"}) && ( -e $params{"-i"} ))?$params{"-i"}:"";

# experimental "title"
my $title= $params{"-t"}?$params{"-t"}:($infilename?$infilename:"__DATA__");

#initialise
my @data;
my ($maxX,$minX,$maxY,$minY,$sumX,$sumY, $sumX2, $sumXY, $number)=(-1000,1000,-1000,1000,0,0,0,0,0);

#read data
if ($infilename){
  open (my $infile,"<",$infilename) or die $!;
  @data=<$infile>;
  close $infile;
  }
else{
  @data=<DATA>;
}

my $svg=""; # the svg file content
foreach (@data) {
   # find and genrate lines 
   $svg.= "  <line x1=\"$2\" y1=\"$3\" x2=\"$4\" y2=\"$5\" stroke=\"red\"\/>\n"
       while (/(^|\s)([\-\=]?[\d]+\.?[\d]*),([\-\=]?[\d]+\.?[\d]*),([\-\=]?[\d]+\.?[\d]*),([\-\=]?[\d]+\.?[\d]*)($|\s)/g); 
   # find and generate points adding to analysis if needed
   while (/(^|\s)([\-\=]?[\d]+\.?[\d]*),([\-\=]?[\d]+\.?[\d]*)($|\s)/g){
	     addPoint($2,$3);
		 $svg.= "  <circle cx=\"$2\" cy=\"$3\" r=\"2\" stroke=\"blue\" \/>\n"
	   };

}
 $svg.= bestFitLine();
# top and tailthe svg contents, and flip the data so that the SVG coordinate system becomes cartesian
$svg="<svg  viewBox=\"".($minX-8)." ".($minY-8)." ".($maxX-$minX+16)." ".($maxY-$minY+16)."\" style=\"background-color:green\" xmlns=\"http://www.w3.org/2000/svg\">\n".
     "<g  transform=\"scale(1,-1) translate(0,".(-$maxY-$minY).")\">\n". # flips the points for a cartesian chart
	  "  <rect x=\"".($minX-5)."\" y=\"".($minY-5)."\" width=\"".($maxX-$minX+10)."\" height=\"".($maxY-$minY+10)."\" stroke=\"blue\"  fill=\"#D5DBDB\" \/>\n".
	 $svg.
	 "\n</g>\n".
	   "<text x=\"".(($minX+$maxX)/2)."\" y=\"".($minY+20)."\" fill=\"red\">$title</text>\n".
	 "</svg>";

# save the svg file
open (my $file,">",$params{"-o"}//"out.svg") or die $!;
print $file $svg;
close $file;

# each point found is added to the stats
sub addPoint{
  my ($x,$y)=@_;
  $maxX= $x if ($x>$maxX);
  $maxY= $y if ($y>$maxY);
  $minX= $x if ($x<$minX);
  $minY= $y if ($y<$minY);
  $sumX+=$x;
  $sumY+=$y;
  $sumX2+=$x*$x;
  $sumXY+=$x*$y;
  $number++;
  return 1;
} 

## genrating best fit line using least squares method
sub bestFitLine{
   return "" if ((exists $params{"-l"}) && ($params{"-l"}=~/0|off/i)); # dont bother if option -l is 0
   my $gradient= ($number*$sumXY-$sumX*$sumY)/($number*$sumX2-$sumX*$sumX);
   my $intercept=($sumY-$gradient*$sumX)/$number;
   my $x1=$minX; my $y1=$gradient*$minX+$intercept;#$maxY;
   my $x2=$maxX; my $y2=$gradient*$maxX+$intercept;#$minY;
   return "  <line x1=\"$x1\" y1=\"$y1\" x2=\"$x2\" y2=\"$y2\" stroke=\"green\"\/>\n"
}

# notice data can be spearted by spaces or new lines
# lines are ignored for data for line of best fit
__DATA__
333,129 39,189 140,156 292,134 393,52  160,166 362,122  13,193
341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89
