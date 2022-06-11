#!/usr/bin/env raku

use Test;

is-deeply farey-seq(5), (0/1, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1),                                         'example 1';

is-deeply farey-seq(7), (0/1, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 2/5, 3/7, 1/2, 4/7, 3/5, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 1/1), 'example 2';

is-deeply farey-seq(4), (0/1, 1/4, 1/3, 1/2, 2/3, 3/4, 1/1),                                                             'example 3'; 

is farey-seq(100).elems, 3045, 'https://oeis.org/A005728/b005728.txt';

sub farey-seq(\n)
{
    return 0/1, 1/n, { next-term($^f, $^s) } ... 1/1;
    
    sub next-term(\f, \s)
    {
        my (\a, \b) = f.nude;
        my (\c, \d) = s.nude;
        my \k = (n + b) div d;
        (k * c - a) / (k * d - b)
    }
}
