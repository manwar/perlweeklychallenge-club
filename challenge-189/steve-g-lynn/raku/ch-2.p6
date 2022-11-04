#!/usr/bin/env perl6

#real	0m0.460s
#user	0m0.657s
#sys	0m0.061s

use Stats;

say &smallest-slice((1,3,3,2)); #[(3 3)]
say &smallest-slice((1,2,1,3)); #[(1 2 1)]
say &smallest-slice((1,3,2,1,2)); #[(2 1 2)]
say &smallest-slice((1,1,2,3,2)); #[(1 1)]
say &smallest-slice((2,1,2,1,1)); #[(1 2 1 1)]
say &smallest-slice((1,3,3,2,2,1)); #[(2 2) (3 3))]

sub smallest-slice (@arry) {
    my (%first, %last, @max, $min_length,@retval);
    
    for (0 .. @arry-1) -> $i {
        (%first{@arry[$i]}) // (%first{@arry[$i]}=$i);
        %last{@arry[$i]} = $i;
    }   

    $min_length = mode(@arry).map({%last{$_}-%first{$_}}).min;
    
    @max=mode(@arry).grep({%last{$_}-%first{$_}==$min_length});
    # elements of arry with maximum frequency 
    # and with smallest slice-length of such elements
    
    @max.map({push @retval, @arry[%first{$_} .. %last{$_}]});
    
    return @retval;
}
