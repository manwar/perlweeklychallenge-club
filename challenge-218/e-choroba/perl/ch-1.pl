#! /usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

# Optimisation: Select the 3 least and 3 greatest numbers and build
# the maximum product from them by trying all the possibilities. The
# least numbers are needed as they might introduce negative numbers.
sub maximum_product (@list) {
    return maximum_product_simple(@list) if @list <= 6;
    return maximum_product_simple((sort { $a <=> $b } @list)[0, 1, 2, -3, -2, -1])
}

sub maximum_product_simple (@list) {
    return product(@list) if 3 == @list;

    my $max_product = product(@list[0, 1, 2]);
    for my $i (0 .. $#list - 2) {
        for my $j ($i + 1 .. $#list - 1) {
            my $p_ij = product(@list[$i, $j]);
            for my $k ($j + 1 .. $#list) {
                my $prod = $p_ij * $list[$k];
                $max_product = $prod if $prod > $max_product;
            }
        }
    }
    return $max_product
}

sub product {
    my $p = 1;
    $p *= $_ for @_;
    $p
}

use Test::More tests => 2 * 4 + 1;

for my $maximum_product (*maximum_product{CODE},
                         *maximum_product_simple{CODE}
) {
    is $maximum_product->(3, 1, 2), 6, 'Example 1';
    is $maximum_product->(4, 1, 3, 2), 24, 'Example 2';
    is $maximum_product->(-1, 0, 1, 3, 1), 3, 'Example 3';
    is $maximum_product->(-8, 2, -9, 0, -4, 3), 216, 'Example 4';
}

my @long = map int(rand 100) - 50, 1 .. 20;
is maximum_product(@long), maximum_product_simple(@long), "same @long";

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    simple    => sub { maximum_product_simple(@long) },
    preselect => sub { maximum_product(@long) },
});

__END__
              Rate    simple preselect
simple      8665/s        --      -94%
preselect 140390/s     1520%        --
