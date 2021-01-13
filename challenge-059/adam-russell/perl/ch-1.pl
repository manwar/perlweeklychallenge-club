use strict;
use warnings;
##
# Write a script to partition a linked list such that 
# all nodes less than k come before nodes greater than or equal to k.
##
use LinkedList;

MAIN:{
    my $ll = new LinkedList();
    my $next = $ll->insert(1, undef);
    $next = $ll->insert(4, $next);
    $next = $ll->insert(3, $next);
    $next = $ll->insert(2, $next);
    $next = $ll->insert(5, $next);
    $next = $ll->insert(2, $next);
    print "Original: "; 
    print $ll->stringify();
    $ll->partition(3);
    print "Partitioned: "; 
    print $ll->stringify();
}
