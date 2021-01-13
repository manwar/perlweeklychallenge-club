#!/usr/bin/env fish

set all_product 1
set M ()

for x in $argv
    set all_product (math "$all_product x $x")
end

set i 1
for x in $argv
    set M[$i] (math -s0 "$all_product / $x")
    set i (math "$i + 1")
end

echo "[$M]"
