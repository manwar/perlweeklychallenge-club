#!/usr/bin/env perl6

my @living = 1 .. 50;
my @temp;

while (@living > 1) {
    loop (my $i = 0; $i < @living; $i += 2) {
        push @temp, @living[$i];
    }
    
    shift @temp if @temp[*-1] == @living[*-1]; 
    @living = @temp;
    @temp   = [];
}

say @living.pop;
