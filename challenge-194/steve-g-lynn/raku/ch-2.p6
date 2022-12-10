#!/usr/bin/env perl6

say frequency-equalizer('abbc'); #1
say frequency-equalizer('xyzyyxz'); #1 
say frequency-equalizer('xzxz'); #0
say frequency-equalizer('abcde'); #1
say frequency-equalizer('abbbccc'); #1

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
    
    ( ( @s.elems <= 2 ) && ( @s.min==1 || (@s.min==(@s.max-1))) ) &&
        (return 1);
    
    return 0; 
}

