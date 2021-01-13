#!/usr/bin/env raku

my @matrix = [ 1, 2, 3 ],
             [ 4, 5, 6 ],
             [ 7, 8, 9 ];

my $width = @matrix[0].elems;
my $height = @matrix.elems;
my $max-steps = $width-1 + $height-1;

my @array = next-step([ ${ x => 0, y => 0, path => [@matrix[0;0]] } ]);

my %sum;
%sum{.<path>} = .<path>.sum for @array;
.say for %sum.minpairs;

sub next-step(@array) {
    my @new;
    state $steps++;

    for @array -> %hash {
        if %hash<x>+1 < $width { # go right
            @new.push: { x    => %hash<x>+1, 
                         y    => %hash<y>, 
                         path => [|%hash<path>, @matrix[%hash<y>;%hash<x>+1]] };
        }

        if %hash<y>+1 < $height { #go down 
            @new.push: { x    => %hash<x>, 
                         y    => %hash<y>+1, 
                         path => [|%hash<path>, @matrix[%hash<y>+1;%hash<x>]] };
        }
    }

    return @new if $steps == $max-steps;
    
    next-step(@new);
}
