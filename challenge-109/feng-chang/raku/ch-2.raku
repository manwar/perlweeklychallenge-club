#!/bin/env raku

sub tell-the-answer(@*a) {
    my %h;
    for 'a'..'g' Z ^7 -> ($c, $n) {
        %h{$c} = @*a[$n];
        put "$c = { %h{$c} }";
    }

    put "Box 1: a + b = {%h<a>} + {%h<b>} = { %h<a> + %h<b> }";
    put "Box 2: b + c + d = {%h<b>} + {%h<c>} + {%h<d>} = { %h<b> + %h<c> + %h<d> }";
    put "Box 3: d + e + f = {%h<d>} + {%h<e>} + {%h<f>} = { %h<d> + %h<e> + %h<f> }";
    put "Box 4: f + g = {%h<f>} + {%h<g>} = { %h<f> + %h<g> }";

    put ' - ' x 11;
}

(1..7).permutations.grep({ .&tell-the-answer if .[0]+.[1] == .[1]+.[2]+.[3] == .[3]+.[4]+.[5] == .[5]+.[6] });
