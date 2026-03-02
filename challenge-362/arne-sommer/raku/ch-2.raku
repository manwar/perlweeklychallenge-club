#! /usr/bin/env raku

use Lingua::EN::Numbers;

unit sub MAIN (*@integers where all(@integers) ~~ Int && @integers.elems > 0);

@integers.sort({ cardinal($^a) cmp cardinal($^b) }).join(", ").say;
