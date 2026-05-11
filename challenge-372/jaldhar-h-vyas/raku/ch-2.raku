#!/usr/bin/raku

sub MAIN($str) {
    my %positions;
    
    # Store all positions of each character
    for $str.comb.kv -> $index, $char {
        %positions{$char}.push($index);
    }
    
    my $max = -1;
    
    # For each character that appears more than once,
    # calculate the distance between first and last occurrence
    for %positions.values -> @indices {
        if @indices.elems > 1 {
            # Distance between first and last occurrence minus 1
            # (excluding the two equal characters)
            my $distance = @indices[*-1] - @indices[0] - 1;
            if $distance > $max {
                $max = $distance;
            }
        }
    }
    
    say $max;
}
