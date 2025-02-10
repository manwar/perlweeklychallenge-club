#!/bin/fish
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

function count_common_sorted
    set -f sorted1 (string join \n $str1 | sort | string split \n)
    set -f sorted2 (string join \n $str2 | sort | string split \n)
    set -f count1 (count $sorted1)
    set -f count2 (count $sorted2)
    set -f idx1 1
    set -f idx2 1
    set -f result 0

    while test $idx1 -le $count1; and test $idx2 -le $count2
        set -l val1 $sorted1[$idx1]
        set -l val2 $sorted2[$idx2]
        if test $val1 = $val2
            set result (math $result + 1)
            set idx1 (math $idx1 + 1)
            set idx2 (math $idx2 + 1)
        else if test (printf '%s\n%s\n' $val1 $val2 | sort | head -n1) = $val1
            set idx1 (math $idx1 + 1)
        else
            set idx2 (math $idx2 + 1)
        end
    end

    echo $result
end

set str1 perl weekly challenge
set str2 raku weekly challenge
count_common_sorted

set str1 perl raku python
set str2 python java
count_common_sorted

set str1 guest contribution
set str2 fun weekly challenge
count_common_sorted
