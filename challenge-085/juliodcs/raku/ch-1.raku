#! /usr/bin/raku

multi triplet(*@R where *.elems < 3)               { 0 }
multi triplet(*@R where 1 < @R.sort[0..2].sum < 2) { 1 }
multi triplet(*@R)                                 { 0 }

if @*ARGS.elems > 0 {
    say triplet @*ARGS>>.FatRat;
}

use Test;

ok !triplet(), 'Empty array cannot make triplet';
ok !triplet(1), 'One element cannot make triplet';
ok !triplet(1, 2), 'Two elements cannot make triplet';
ok  triplet(1.5, 0, 0), 'Simple triplet';
ok  triplet(0, 2, 3, 4, 5, 6, 7, 8, 9, 1.5, 0), 'Simple triplet with many numbers';
ok  triplet(1.2, 0.4, 0.1, 2.5), 'Test case 1';
ok !triplet(0.2, 1.5, 0.9, 1.1), 'Test case 2';
ok  triplet(0.5, 1.1, 0.3, 0.7), 'Test case 3';

done-testing;
