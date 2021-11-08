#!/usr/bin/env raku

constant @next-candidates :=
    (( 1, 2, 2),(-2,-1,-2),(2,2,3)),
    (( 1, 2, 2),( 2, 1, 2),(2,2,3)),
    ((-1,-2,-2),( 2, 1, 2),(2,2,3)),
;

sub next-level (@a,:$n) {
    @a
    andthen @next-candidates.map: $_ «*« *
    andthen .map: { [Z+] $_ }\
    andthen .map: *.cache
    andthen |.grep: { .any ≤ $n }
}

sub pythagorean-triples ($n) {     # only primitive
    ((3,4,5),), { .map: &next-level.assuming(:$n) } ... :!elems
    andthen .map: |*.grep: $n == *.any    # by  `$n %% *.any` you could have generators for all Pythagorean-triples
}

multi MAIN (Bool :test($)!) {
    use Test;
    is pythagorean-triples( 5),  ((3,4,5),(5,12,13));
    is pythagorean-triples(13),  ((5,12,13),(13,84,85));
    is pythagorean-triples( 1),  ();
    is pythagorean-triples(65),  ((33,56,65),(65,72,97),(63,16,65),(65,2112,2113));
    done-testing;
}

multi MAIN ($n=420) {
    say pythagorean-triples($n) || -1
}
