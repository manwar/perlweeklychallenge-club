use strict;
use warnings;
##
# You are given set of co-ordinates @N.
# Write a script to count maximum points 
# on a straight line when given co-ordinates 
# plotted on 2-d plane.
##
sub triangle_area{
    my($i, $j, $k) = @_;
    return ($i->[0] * ($j->[1] - $k->[1])) 
		 + ($j->[0] * ($k->[1] - $i->[1]))
		 + ($k->[0] * ($i->[1] - $j->[1]));
}

sub collinear_points{
    my(@points) = @_;
    my @collinear;
    for my $i (@points){
        for my $j (@points){
            for my $k (@points){
                if(triangle_area($i, $j, $k) == 0){
				    my $i_string = join(",", @{$i});
					my $j_string = join(",", @{$j});
					my $k_string = join(",", @{$k});
					if(($i_string ne $j_string) && ($i_string ne $k_string) && ($j_string ne $k_string)){
					    my $has_i = grep { $i_string eq join(",", @{$_}) } @collinear;
					    push @collinear, $i if !$has_i;
						my $has_j = grep { $j_string eq join(",", @{$_}) } @collinear;
						push @collinear, $j if !$has_j;
						my $has_k = grep { $k_string eq join(",", @{$_}) } @collinear;
						push @collinear, $k if !$has_k;
					}
                }
            }
        }
    }
    return @collinear;
}

MAIN:{
    my @N;
    @N = ([5,3], [1,1], [2,2], [3,1], [1,3]);
    my @collinear = collinear_points(@N);
    print "There are a maximum of " . @collinear . " collinear points.\n"
}
