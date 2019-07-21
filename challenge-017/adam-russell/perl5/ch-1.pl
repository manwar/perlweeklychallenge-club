use strict;
use warnings;
##
# Create a script to demonstrate Ackermann function.
##

sub A{
    my($m, $n) = @_;
    return $n + 1 if($m == 0);
    return A($m - 1, 1) if($m > 0 && $n == 0);
    return A($m - 1, A($m, $n - 1)) if ($m > 0 && $n > 0); 
}

MAIN:{
    my $ackermann = A(1,2);
    print "$ackermann\n"; 
}  
