#!/bin/env raku

unit sub MAIN(*@ints);

@ints = +«@ints;
put +@ints.combinations(3).grep({ .all == .one });
