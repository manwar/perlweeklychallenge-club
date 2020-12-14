#!/usr/bin/env raku

use v6;

#| Given a list of integers print 1 if starting at 0 you can use the values to jump to the end of the list
sub MAIN (
    *@N where $_.all ~~ Int #= List of integers
) {
    my $idx = 0;
    my %seen;
    my $result = 0;
    
    while ( ! %seen{$idx} ) {
        %seen{$idx} = True;
        $idx += @N[$idx];
        if $idx == @N.end { $result = 1; last }
        last if $idx < 0;
        last if $idx > @N.end;
    }
    say $result;
}
   
