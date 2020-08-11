#!/usr/bin/env perl6

class Pwc048_1 is Array {
    method iterator {
        class :: does Iterator {
            has $.index is rw = 0;
            has $.array is required;
            method pull-one {
                my $val = $.array.AT-POS($.index++);
                $.index %= $.array.elems;
                $.array.splice($.index, 1);
                if ($.array.elems) {
                    $.index %= $.array.elems;
                    $val;
                } else {
                    IterationEnd;
                }
            }
        }.new(array => self)
    }
}

my $arr = Pwc048_1.new();
$arr.append(1...50);
say "Survivors, in order: ", $arr;
