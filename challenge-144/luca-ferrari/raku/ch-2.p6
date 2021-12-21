#!raku

# Sums all the couple of numbers
# in only direction, skipping the duplicated
# values
sub do-sum( @array ) {
    my %sums;

    for 0 .. @array.end -> $index-left {
        for $index-left ^.. @array.end -> $index-right {
            next if $index-left == $index-right;

            %sums{ @array[ $index-left ] + @array[ $index-right ] }++;
        }
    }


    my @found;
    @found.push: $_.Int if %sums{ $_ } == 1 for %sums.keys;
    @found;

}


sub MAIN( Int $u where { $u > 0 },
          Int $v where { $v > 0 },
          Int $limit = 10 ) {



    my @ulam = $u, $v, $u + $v;

    while @ulam.elems < $limit {
        @ulam.push: do-sum( @ulam ).grep( { $_ > @ulam[ * - 1 ] } ).min;
    }


    @ulam.join( ',' ).say;

}
