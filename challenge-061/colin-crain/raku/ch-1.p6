multi MAIN () {
    say "Usage: produce_market.raku array[0] array[1] array[2] ...";
}

multi MAIN(*@array) {
    my $product = [*] @array;
    my $max_sublists = [];        ## we need to load up as an array of arrays
    $max_sublists.push: @array;

    if $product <= 0 {
        ($product, $max_sublists) = find_max_product( make_all_sublists( @array ) );
    }
    print_output( $product, $max_sublists );
}

sub make_all_sublists (@array) {
    my @sublists.append( [\,] $_ .. @array.end ) for ^@array;
    return @sublists.deepmap( { @array[$_] } );
}

sub find_max_product (@output) {
    ## iterate through array of array refs,
    ## calc products and keeps track of maximums
    my $max_product = -Inf;
    my $max_sublists;

    for @output -> $list {
        my $product = [*] |$list;
        if $product > $max_product {
            $max_product = $product;
            $max_sublists = [$list];
        }
        elsif $product == $max_product {
            $max_sublists.append: $list;
        }
    }
    return( $max_product, $max_sublists );
}

sub print_output ($max_product, @max_sublists) {
    ## given list ref and product
    ## prints output
    say "product : ", $max_product;
    say "sublist(s): ";
    .say for @max_sublists;
}
