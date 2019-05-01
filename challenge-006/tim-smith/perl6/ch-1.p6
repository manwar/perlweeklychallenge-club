#! /usr/bin/env perl6

# Comb all args for numbers, then flatten them into a single list of
# increasing integers
my @vals = @*ARGS».comb(/\d+/).Seq.flat».Int.sort.unique
    or die "Usage: {$?FILE.IO.basename} 1 2,3 4/5/6 '7 8 9'";

my @groups;

for @vals -> $n {
    # Add a new group unless $n belongs in the current group
    unless @groups and @groups.tail[1] == $n - 1 {
        @groups.push: [$n, Nil];
    }

    # Update the endpoint of the current group
    @groups.tail[1] = $n;
}

# Display the groups
put @groups.map(*.unique.join('-')).join(',');
