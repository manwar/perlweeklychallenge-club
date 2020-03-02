#!/usr/bin/env perl6

my @array = ([2,7], [3,9], [10,12], [15,19], [18,22]);

my @head;
my @tail;

loop {
    my $a1 = shift @array;
    my $a2 = shift @array;

    @head.push([$a1[0], $a2[1]]);

    last unless @array.elems > 1;

    $a2 = pop @array;
    $a1 = pop @array;

    @tail.push([$a1[0], $a2[1]]);

    last unless @array.elems > 1;
}

say (@head, @array, @tail).flat;
