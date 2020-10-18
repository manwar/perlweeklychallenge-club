use strict;
use warnings;
##
# You are given 3 strings; $A, $B and $C.
# Write a script to check if $C is created by interleave $A and $B.
# Print 1 if check is success otherwise 0.
##
sub find_remove{
    my($s, $x) = @_;
    my $i = index($s, $x);
    if($i != -1){
        substr $s, $i, length($x), "";
        return $s;
    }
    return undef;
}
MAIN:{
    my $A = "XY";
    my $B = "X";
    my $C = "XXY";
    my $s = find_remove($C, $A);
    if($s && $s eq $B){
        print "1\n";
        exit;
    }
    else{
        $s = find_remove($C, $B);
        if($s && $s eq $A){
            print "1\n";
            exit;
        }
    }
    print "0\n";
}