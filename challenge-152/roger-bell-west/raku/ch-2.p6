#! /usr/bin/perl6

use Test;

plan 2;

class Rect {
    has @.xy1 is rw;
    has @.xy2 is rw;

    submethod BUILD(:@xy1,:@xy2) {
        @!xy1=[min(@xy1[0],@xy2[0]),min(@xy1[1],@xy2[1])];
        @!xy2=[max(@xy1[0],@xy2[0]),max(@xy1[1],@xy2[1])];
    }

    method area() {
        my $area=1;
        for (0,1) -> $axis {
            $area *= @.xy2[$axis]-@.xy1[$axis];
        }
        return $area;
    }
    
    method overlap($other) {
        my $area=1;
        for (0,1) -> $axis {
            $area *= max(0,
                         min(@.xy2[$axis],$other.xy2[$axis])-
                            max(@.xy1[$axis],$other.xy1[$axis])
                        );
        }
        return $area;
    }
    
    method fullarea($other) {
        return self.area()+$other.area()-self.overlap($other);
    }
}

is(Rect.new(xy1 => [-1,0],xy2 => [2,2]).fullarea(Rect.new(xy1 => [0,-1],xy2 => [4,4])),22,'example 1');

is(Rect.new(xy1 => [-3,-1],xy2 => [1,3]).fullarea(Rect.new(xy1 => [-1,-3],xy2 => [2,2])),25,'example 2');
