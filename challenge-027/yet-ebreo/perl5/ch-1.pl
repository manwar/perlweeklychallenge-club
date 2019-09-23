# Write a script to find the intersection of two straight lines. The co-ordinates 
# of the two lines should be provided as command line parameter. For example:
# The two ends of Line 1 are represented as co-ordinates (a,b) and (c,d).
# The two ends of Line 2 are represented as co-ordinates (p,q) and (r,s).
# The script should print the co-ordinates of point of intersection of the above two lines.
use strict;
use warnings;
use v5.10;

die "Usage:\n\tch-1.pl <X11> <Y11> <X12> <Y12> <X21> <Y21> <X22> <Y22>\n\n" if @ARGV != 8;

# one intersection point
my @line1 = ([$ARGV[0],$ARGV[1]],[$ARGV[2],$ARGV[3]]);
my @line2 = ([$ARGV[4],$ARGV[5]],[$ARGV[6],$ARGV[7]]);
my $y_intercept1 = 0;
my $y_intercept2 = 0;
my $slope1 = 1e9;
my $slope2 = 1e9;

#Get X delta for line1 and 2
#ΔX = X2 - X1
my $x_delta1 = $line1[1][0] - $line1[0][0];
my $x_delta2 = $line2[1][0] - $line2[0][0];

#Get Y delta for line1 and 2
#ΔY = Y2 - Y1
my $y_delta1 = $line1[1][1] - $line1[0][1];
my $y_delta2 = $line2[1][1] - $line2[0][1];

#Get slope and y-intercept for line1 if X delta is not zero
if ($x_delta1) {
    #If delta x is not 0 then the line is sloped / non vertical
    #And can be calculated as follows:
    $slope1 = $y_delta1/$x_delta1;

    # In order to complete the equation of the line in
    # y = mx + b. The b which is the Y-intercept is needed
    # This can be calculated by substituting any of the given points for (x and y)
    # Where m = the slope
    $y_intercept1 = $line1[0][1] - $slope1*$line1[0][0];
}

#Do the same for line2
if ($x_delta2) {
    $slope2 = $y_delta2/$x_delta2;
    $y_intercept2 = $line2[0][1] - $slope2*$line2[0][0];
}

#Lines are parallel if slopes are equal
if ($slope1 == $slope2)  {
    say "Two given lines are parallel"
} else {
    #Solve the linear equation using determinants
    # | x1 y1 | 
    # | x2 y2 | 
    my $D  = $slope2-$slope1;

    # | b1 y1 | 
    # | b2 y2 |
    my $DX = $y_intercept1-$y_intercept2;

    # | x1 b1 | 
    # | x2 b2 |
    my $DY = $slope2*$y_intercept1-$slope1*$y_intercept2;
    say( ($DX/$D).",".($DY/$D) );
}
# perl .\ch-1.pl 20 3 -40 3 40 120 -80 0
# -77,3
# perl .\ch-1.pl 20 60 -40 0 40 120 -80 0
# Two given lines are parallel