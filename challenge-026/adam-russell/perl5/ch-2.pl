use strict;
use warnings;
##
# Create a script that prints mean angles of the given list of angles in degrees.
##
use constant PI => atan2(1,1) * 4; 

sub deg2rad {
    my($degrees) = @_;
    return ($degrees / 180) * PI;
}

sub rad2deg {
    my($radians) = @_;
    return ($radians / PI) * 180;
}

sub compute_mean_angle{
    my(@angles) = @_;
    my $sum = 0; 
    map { $sum += $_ } map { sin($_) } @angles;  
    my $sin_mean = $sum / @angles; 
    $sum = 0; 
    map { $sum += $_ } map { cos($_) } @angles;  
    my $cos_mean = $sum / @angles; 
    return atan2($sin_mean, $cos_mean) if $sin_mean > 0 && $cos_mean > 0; 
    return atan2($sin_mean, $cos_mean) + deg2rad(180) if $cos_mean < 0; 
    return atan2($sin_mean, $cos_mean) + deg2rad(360) if $sin_mean < 0 && $cos_mean > 0; 
}


MAIN:{
    my @angles = map { deg2rad($_) } @ARGV[0 .. (@ARGV - 1)]; 
    print rad2deg(compute_mean_angle(@angles)) . "\n";
} 
