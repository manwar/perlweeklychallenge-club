#! /usr/bin/env raku

use Math::Libgsl::Function :ALL;

unit sub MAIN (Int :u(:$upto) where $upto > 0 = 10);

say "$_ -> { gamma($_).Int }" for 1 .. $upto;
