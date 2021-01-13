use strict;
use warnings;
##
# You are given an array @A of positive numbers.
# Write a script to flip the sign of some members 
# of the given array so that the sum of the all 
# members is minimum non-negative.
##
sub try_all_flips{
    my(@a) = @_;
    my @minimum = (undef, undef, []); 
    for my $i (0 .. (2**(@a) - 1)){
        my $b = sprintf("%0" . @a . "b", $i); 
        my @b = split(//, $b);
        my $flip_count = 0;
        map {$flip_count++ if $_ == 1} @b;
        my @f;
        for my $i (0 .. (@b - 1)){
            if($b[$i] == 1){
                push @f, (-1) * $a[$i];
            }
            else{
                push @f, $a[$i];
            }
        }
        my $sum = unpack("%32I*", pack("I*", @f)); 
        if(!defined($minimum[0]) || ($sum <= $minimum[0] && $sum >= 0)){
            if(defined($minimum[0]) && $sum == $minimum[0] && $flip_count < $minimum[1]){
                $minimum[0] = $sum;
                $minimum[1] = $flip_count;
                $minimum[2] = \@f;
            }
            elsif(!defined($minimum[0])){
                $minimum[0] = $sum;
                $minimum[1] = $flip_count;
                $minimum[2] = \@f;
            }
            elsif($sum < $minimum[0]){
                $minimum[0] = $sum;
                $minimum[1] = $flip_count;
                $minimum[2] = \@f;
            }
        }
    }
    return @minimum;
}

MAIN:{
    my @A;
    my @minimum;
    @A = (3, 10, 8);
    @minimum = try_all_flips(@A);
    print "[". join(", ", @A) . "] --> ";
    print  " [". join(", ", @{$minimum[2]}) . "] = " . $minimum[0] ."\n";
    @A = (12, 2, 10);
    @minimum = try_all_flips(@A);
    print "[". join(", ", @A) . "] --> ";
    print  " [". join(", ", @{$minimum[2]}) . "] = " . $minimum[0] ."\n";
}