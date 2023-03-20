#!/usr/bin/env raku
use v6.e.PREVIEW;

sub minimum-index-sum (+@lists) {
   @lists
   andthen .map: |*.antipairs
   andthen .classify: *.key, as => *.value
   andthen .grep: *.value.elems == +@lists
   andthen Map($_)
   andthen .nodemap: *.sum
   andthen .minpairs
   andthen .map: *.key
}

multi MAIN (Bool :test($)!) {
    use Test;
    is minimum-index-sum(<Perl Raku Love>,<Raku Perl Love>).sort, <Perl Raku>;
    is minimum-index-sum(<A B C>,<D E F>), Empty;
    is minimum-index-sum(<A B C>,<C A B>), <A>;
    done-testing;
}

multi MAIN (+@lists) {
    say minimum-index-sum +@lists
}
