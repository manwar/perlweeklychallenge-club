die 'Requires one argument, a list of numbers ie: "1 2 3 4 5 6"' unless @*ARGS.elems;
say 0 && die if @*ARGS[0].split(/\s/).elems <= 2;

my @vals = @*ARGS[0].split(/\s/).map(*.Int);
my $max-dist = -1;
my @pairs;
loop (my $i = 0; $i < @vals.elems - 1; $i++) {
    next if @vals[$i] > @vals[$i+1];
    $max-dist = max($max-dist, @vals[$i+1]- @vals[$i]);
    if (@vals[$i+1] - @vals[$i]) == $max-dist {
        @pairs.push: (@vals[$i], @vals[$i+1]);
    }
}

say @pairs.raku;

# vim: expandtab shiftwidth=4
