#!/usr/bin/env perl6

my @c = zip([1,2,3],['a','b','c']);
say @c;

@c = zip(['a','b','c'],[1,2,3]);
say @c;


sub zip (@a, @b) {    
    (@a.elems == @b.elems) || die "ERROR: Inputs unequal in length.\n";  
    my @c;    
    @c.append(@a[$_], @b[$_]) for (0 .. @a-1);    
    return @c;     
}
