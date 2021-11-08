#!/usr/bin/env raku

#
# This program will ouput the same SVG as Bruce Gray's solution.
#

use SVG;

say SVG.serialize(
    :svg[

        width => 300, height => 400,

        :g[ 

            :id<female_sign>, :fill<none>, :stroke<black>, :stroke-width<10>

            :circle[ :cx<150>, :cy<150>, :r<100> ]

            :line[ :x1<150>, :y1<250>, :x2<150>, :y2<350> ] 

            :line[ :x1<100>, :y1<300>, :x2<200>, :y2<300> ] 

        ]
    ]
);
