use strict;
use warnings;

#------------------------------------------------------------------------------

sub array_of_product {
    my @result;
    for( my $i=0; $i<@_; $i++ ) {
        my $product = 1;
        for( my $j=0; $j<@_; $j++ ) {
            next if $i == $j;
            $product *= $_[$j];
        }
        push @result, $product;
    }
    return @result;
}

#------------------------------------------------------------------------------

1970;
