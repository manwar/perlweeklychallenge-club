use strict;
use warnings;
##
# You are given a positive integer $N.
# Write a script to find if it can be expressed
# as a ^ b where a > 0 and b > 1. 
# Print 1 if you succeed otherwise 0.
##
use boolean;

sub log_a{
    my($a, $n) = @_;
    return log($n)/log($a);
}

MAIN:{
    my $N = $ARGV[0];
    my $found = false;                  
    for my $a (2 .. $N){ 
        my $b = log_a($a, $N);
        if($b =~ /^[-]?\d+$/ && $b > 1){ 
            print "1\n";
            $found = true;
            last;
        }
    }
    print "0\n" if(!$found);
}