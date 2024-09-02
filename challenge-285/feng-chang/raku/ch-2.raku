#!/bin/env raku

unit sub MAIN(UInt:D \amount);

proto changes(UInt:D \amount, UInt:D \limit --> UInt:D) {*}
multi changes(0, $_)  { 1 }
multi changes(\a, 1)  { 1 }
multi changes(\a, 50) { (0..a div 50).map({ changes(a - $_ * 50, 25) }).sum }
multi changes(\a, 25) { (0..a div 25).map({ changes(a - $_ * 25, 10) }).sum }
multi changes(\a, 10) { (0..a div 10).map({ changes(a - $_ * 10,  5) }).sum }
multi changes(\a, 5)  { (0..a div  5).map({ changes(a - $_ *  5,  1) }).sum } 

put changes(amount, 50);
