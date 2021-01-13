use strict;
use warnings;
##
# You are given array @A containing positive numbers 
# and @B containing one or more indices from the array @A.
# Write a script to left rotate @A so that the number at 
# the first index of @B becomes the first element in the 
# array. Similary, left rotate @A again so that the number 
# at the second index of @B becomes the first element in 
# the array.
##
sub rotate{
    my($a, $r) = @_;
    my @rotated;
    for(0 .. ($r - 1)){
        my $temp = shift @{$a};
        push @{$a}, $temp;
    }
    return $a;
}

MAIN:{
    my(@A, @B);
    @A = (10, 20, 30, 40, 50);
    @B = (3, 4);
    my @rotations;
    for my $b (@B){
        my @temp = @A;
        push @rotations, rotate(\@temp, $b);
    }
    print "\@A = (" . join(",", @A) . ")\n";
    print "\@B = (" . join(",", @B) . ")\n";
    print "Rotations:\n";
    for my $rotation (@rotations){
        print "\t[" . join(",", @{$rotation}) . "]\n";
    }
    @rotations = ();
    @A = (7, 4, 2, 6, 3);
    @B = (1, 3, 4);
    for my $b (@B){
        my @temp = @A;
        push @rotations, rotate(\@temp, $b);
    }
    print "\@A = (" . join(",", @A) . ")\n";
    print "\@B = (" . join(",", @B) . ")\n";
    print "Rotations:\n";
    for my $rotation (@rotations){
        print "\t[" . join(",", @{$rotation}) . "]\n";
    }
}
