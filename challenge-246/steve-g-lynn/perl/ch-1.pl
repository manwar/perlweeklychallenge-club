#!/usr/bin/env -S perl -wl


local *six_out_of_49 = sub {
    local @six_out_of_49 = map {rand} 0 .. 48;
    return (sort {$six_out_of_49[$a-1] <=> $six_out_of_49[$b-1]} 1 .. 49) [0 .. 5];
};

local @six_out_of_49=&six_out_of_49;
print "@six_out_of_49";

1;
