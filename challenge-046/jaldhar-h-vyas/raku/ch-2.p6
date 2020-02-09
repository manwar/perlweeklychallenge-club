#!/usr/bin/perl6

constant $end = 500;
my Bool @rooms[$end];

for 0 ..^ $end -> $i {
    for 0 ..^ $end -> $j {
        if ($j + 1) %% ($i + 1) {
            @rooms[$j] = !@rooms[$j];
        }
    }
}

for 0 ..^ $end -> $i {
    if @rooms[$i] {
        print $i + 1, q{ };
    }
}
print "\n";