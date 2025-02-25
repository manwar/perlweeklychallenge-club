#!/bin/env raku

unit sub MAIN(*@bins where .all == 0|1);

put ([\~] @bins).map({ .parse-base(2).is-prime });
