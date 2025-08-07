#!/usr/bin/env raku
use Test;

ok  straight-line([2,1], [2,3], [2,5]);
ok  straight-line([1,4], [3,4], [10,4]);
nok straight-line([0,0], [1,1], [2,3]);
ok  straight-line([1,1], [1,1], [1,1]);
ok  straight-line([1000000,1000000], [2000000,2000000], [3000000,3000000]);

# Athanasius 
ok  straight-line([1,2], [1,2],  [2,3], [3,4]),          'Duplicate 1';
nok straight-line([1,2], [1,2],  [2,3], [3,5]),          'Duplicate 2';
ok  straight-line([1,2], [1,2],  [2,3], [1,2]),          'Duplicate 3';
ok  straight-line([4,9]),                                'Singleton';  
ok  straight-line([4,9], [7,6]),                         'Pair';
ok  straight-line([-1.5,0.3], [-2.5,-0.7], [-3.5,-1.7]), 'Reals';

# E Choroba 
ok  straight-line([0,0]),                        'single point';
ok  straight-line([0,1], [1,0]),                 'two points';
ok  straight-line([1,4], [2,6], [3,8], [4,10]),  'Four points';
ok  straight-line([0,1], [2,3], [3,4], [-5,-4]), 'Negative values';
ok  straight-line([1,2], [3,7], [3,7]),          'B=C';
ok  straight-line([1,2], [3,7], [1,2]),          'A=C';
ok  straight-line([1,2], [1,2], [3,7]),          'A=B';
nok straight-line([2,1], [2,3], [3,4]),          'Not y';
nok straight-line([2,1], [3,3], [2,4]),          'Not y';
nok straight-line([3,1], [2,3], [2,4]),          'Not y';
nok straight-line([3,2], [1,3], [1,4]),          'Not x';
nok straight-line([1,2], [3,3], [1,4]),          'Not x';
nok straight-line([1,2], [1,3], [3,4]),          'Not x';

# Peter Campbell Smith
nok straight-line([0,0], [1,1], [99999999,100000000]);
ok  straight-line([8,-5], [3,-2], [-2,1]);
ok  straight-line([8,-5], [3,-2], [-2,1], [-7,4], [-12,7]);
nok straight-line([0,0], [1,0], [2,1], [3,2]);

sub straight-line(+@points)
{
    @points .= unique(with => &[eqv]);
    return True if @points < 3;
    [==] @points.rotor(2 => -1).flat.map(&slope)
}

sub slope(@a, @b) 
{ 
    my $m = (@b[1] - @a[1]) / (@b[0] - @a[0]);
    $m.denominator ?? $m !! Inf
}
