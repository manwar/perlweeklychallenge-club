use strict;
use warnings;
##
# You are given a score $S.
# You can win basketball points e.g. 1 point, 2 points and 3 points.
# Write a script to find out the different ways you can score $S.  
##    

sub basketball_points{
    my($total) = @_; 
    my %points;
    my @valid_points;
    $points{"1"} = "1";   
    $points{"2"} = "2";   
    $points{"3"} = "3";   
    while((keys %points) > 0){
        my %updated_points = ();
        for my $points (keys %points){
            my @points = split(/,/, $points); 
            for my $point (1 .. 3){
                my $point_sum = unpack("%32I*", pack("I*",  (@points, $point))); 
                push @valid_points, [@points, $point] if $point_sum == $total;  
                $updated_points{join(",", (@points, $point))} = $point_sum if $point_sum < $total;  
            }
        }
        %points = %updated_points;    
    }  
    return @valid_points; 
}


MAIN:{
    my $S;
    $S = 4;  
    print "\$S = $S\n"; 
    my @point_combinations = basketball_points($S); 
    for my $points (basketball_points($S)){  
        print join(" ", @{$points}) . "\n"; 
    } 
    $S = 5;  
    print "\n\$S = $S\n"; 
    my @point_combinations = basketball_points($S); 
    for my $points (basketball_points($S)){  
        print join(" ", @{$points}) . "\n"; 
    } 
}
