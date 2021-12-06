#!/usr/bin/env raku

await (^10).pick(*).map(-> \n { Promise.in(0.005 * n).then({ say n }) });
