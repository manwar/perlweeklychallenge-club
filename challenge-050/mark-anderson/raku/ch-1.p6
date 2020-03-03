#!/usr/bin/env perl6

my @array = ([2,7], [3,9], [10,12], [15,19], [18,22]);

my @merged = @array.shift;

while @array {
    my @a = @array.shift.flat;
    my @m = @merged.pop.flat;

    if (@m[1] >= @a[0]) {
        @merged.push([@m[0], @a[1]]);
    }

    else {
       @merged.append(@m, @a);
    }
}

say @merged.flat;
