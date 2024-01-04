#! /usr/bin/env raku

unit sub MAIN (*@alphanumstr where @alphanumstr.elems > 0, :v(:$verbose));

my @values = @alphanumstr.map({ /^<[0..9]>+$/ ?? $_.Int !! $_.chars });

say ":Values: { @values.join(",") }" if $verbose;

say @values.max;
