#!/usr/bin/env raku
use v6;

# run <script> <space-separated set entries, with a '-' separating the two sets>

my ($a,$b) = @*ARGS.join(" ").split(/\s+'-'\s+/).map(*.split(/\s+/).map(*.trim.Int));
say 1-($a (&) $b).elems;
