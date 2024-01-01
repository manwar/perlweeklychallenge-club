#!/usr/bin/env -S perl -wl

local *alphanumeric_string_value = sub {
    local *alphanumeric_string_value = sub {
        ($_[0] =~ /^[0-9]+$/) ?
        (0+$_[0]) :
        length($_[0]);
    };

    (sort {$b<=>$a}
    (map {&alphanumeric_string_value($_)} @_)) [0];
};

print &alphanumeric_string_value('perl','2','000','python','r4ku');#6
print &alphanumeric_string_value('001','1','000','0001');#1
