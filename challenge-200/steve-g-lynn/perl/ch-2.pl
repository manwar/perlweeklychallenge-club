#!/usr/bin/env -S perl -w

use strict;

use constant {
    'hl' => ('-' x 7),
    'v_' => ('|' . (' ' x 6) ),
    '_v' => ((' ' x 6) . '|'),
    'v_v' => ('|' . (' ' x 5) . '|')
};

my @encoded = (
    [hl, v_v, v_v, v_v, v_v, v_v, hl], #0
    [_v,_v,_v,_v,_v,_v,_v], #1
    [hl, _v,_v,hl,v_,v_,hl], #2
    [hl, _v,_v,hl,_v,_v,hl], #3
    [v_v,v_v,v_v,hl,_v,_v,_v], #4
    [hl,v_,v_,hl,_v,_v,hl], #5
    [hl,v_,v_,hl,v_v,v_v,hl], #6
    [hl,_v,_v,_v,_v,_v,_v], #7
    [hl,v_v,v_v,hl,v_v,v_v,hl], #8
    [hl,v_v,v_v,hl,_v,_v,_v], #9
);
# $encoded[x] is the representation of digit x

&draw_integer(200);

#   ------- ------- ------- 
#         | |     | |     | 
#         | |     | |     | 
#   ------- |     | |     | 
#   |       |     | |     | 
#   |       |     | |     | 
#   ------- ------- ------- 


sub draw_integer {
    my ($n) = @_;
    my @n=split //, $n;
    
    for my $i (0 .. 6) {
        for my $j (@n) {
            print $encoded[$j]->[$i]," ";
        }
        print "\n";
    }
    return 1;   
}


