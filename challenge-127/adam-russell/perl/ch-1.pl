use strict;
use warnings;
##
# You are given two sets with unique numbers.
# Write a script to figure out if they are disjoint.
##
use boolean;

sub disjoint{
    my($list1, $list2) = @_;
    my @a = map { my $n = $_; grep  $n == $_ , @{$list2} }  @{$list1}; 
    return boolean(@a == 0);#boolean() used for better stringification    
}


MAIN:{
    my(@S1, @S2);
    @S1 = (1, 2, 5, 3, 4);
    @S2 = (4, 6, 7, 8, 9);
    print disjoint(\@S1, \@S2) . "\n";  
    @S1 = (1, 3, 5, 7, 9);
    @S2 = (0, 2, 4, 6, 8);
    print disjoint(\@S1, \@S2) . "\n";  
}
