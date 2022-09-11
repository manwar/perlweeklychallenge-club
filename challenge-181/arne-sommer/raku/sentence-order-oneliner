#! /usr/bin/env raku

(slurp @*ARGS[0] || "paragraph.txt").split(".")>>.words>>.sort({ $^a.lc cmp $^b.lc })>>.join(" ").join(". ").say;

