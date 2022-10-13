#!/usr/bin/env perl

my @c = zip([1,2,3],['a','b','c']);
print "@c\n";

@c = zip(['a','b','c'],[1,2,3]);
print "@c\n";


sub zip {
    my ($ra_a, $ra_b) = @_;    
    (@$ra_a == @$ra_b) || die "ERROR: Inputs unequal in length.\n";    
    my @c;    
    push @c, ($$ra_a[$_], $$ra_b[$_]) for (0 .. @$ra_a-1);    
    return @c;     
}
