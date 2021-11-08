#!/usr/bin/env raku

sub next-paths ($path) {
    slip (
        'LH' ~ $path,
        $path ~ 'LH',
        'L' ~ $path ~'H',
        'R' ~ $path,
        $path ~ 'R',
    )
}

constant @find-possible-paths = '', {  .map( *.&next-paths ).unique.cache  } ... * ;

multi MAIN ($n) {
    put @find-possible-paths[$n]
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply next-paths('LH').Set, ('LHLH','LHLH','LLHH','RLH','LHR').Set;
    is-deeply @find-possible-paths[1].Set, <R LH>.Set;
    is-deeply @find-possible-paths[2].Set, <RR LHR LHLH LLHH RLH LRH>.Set;
    is @find-possible-paths.[10].elems, 349526;
    is @find-possible-paths.[120].head(4), ('LH' x 120, 'L' ~ 'LH' x 119 ~ 'H', 'R' ~ 'LH' x 119, 'LH' x 119 ~ 'R');
    done-testing;
}
