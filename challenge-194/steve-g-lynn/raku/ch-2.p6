#!/usr/bin/env perl6

say frequency-equalizer('abbc'); #1
say frequency-equalizer('xyzyyxz'); #1 
say frequency-equalizer('xzxz'); #0

sub frequency-equalizer( Str $s ) {
    
    my @s = $s.comb;
    
    my (%s, %uniq);
    
    for (@s) -> $i {
        %s{$i}++;
    }

    for (%s.values) -> $i {
        %uniq{$i} = $i;
    }
    
    @s = %uniq.keys.sort;
    
    ( ( @s.elems == 2 ) && (@s.min==(@s.max-1)) ) &&
        (return 1);
    
    return 0; 
}

