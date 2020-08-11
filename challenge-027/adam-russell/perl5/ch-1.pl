use strict;
use warnings;
##
# Write a script to find the intersection of two straight lines.
# The co-ordinates of the two lines should be provided as command line parameters.
##
MAIN:{
    my @endpoints_line_0 = @ARGV[0, 1]; 
    my @endpoints_line_1 = @ARGV[2, 3]; 
    @endpoints_line_0 = map { $_=~tr/()//d; [split(/,/, $_)];} @endpoints_line_0;  
    @endpoints_line_1 = map { $_=~tr/()//d; [split(/,/, $_)];} @endpoints_line_1;  
    my($a, $b, $c, $d, $p, $q, $r, $s) = (
        $endpoints_line_0[0]->[0],
        $endpoints_line_0[0]->[1],
        $endpoints_line_0[1]->[0],
        $endpoints_line_0[1]->[1],
        $endpoints_line_1[0]->[0],
        $endpoints_line_1[0]->[1],
        $endpoints_line_1[1]->[0],
        $endpoints_line_1[1]->[1]
    ); 
    my $denominator = ($c - $a) * ($s - $q) - ($r - $p) * ($c - $b);  
    
    my $x0 = ($c * $b - $a * $d) * ($r - $p) - ($r * $q - $p * $s) * ($c - $a);  
    my $y0 = ($c * $b - $a * $d) * ($s - $q) - ($r * $q - $p * $s) * ($d - $b);  

    my $x = $x0/$denominator;
    my $y = $y0/$denominator;

    print "($a, $b)--($c, $d) and ($p, $q)--($r, $s) intersect at ($x, $y)\n";
} 
