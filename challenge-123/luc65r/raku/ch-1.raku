#!/usr/bin/env raku

multi ugly(1 --> True) { }
multi ugly(UInt:D $n --> Bool) {
    return ugly($n div $_) if $n %% $_ for 2, 3, 5;
    False
}

unit sub MAIN(UInt:D $n);

say (1..∞).grep({ .&ugly })[$n - 1];
