use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my @array = @ARGV;

my $product = product( @array );

my $zeros = grep { $_ == 0 } @array;
my $negs  = grep { $_ < 0 }  @array;
my $max_products;

## case 1, no zeros, even or no negatives, whole array result
if ($product > 0) {
    $max_products = \@array;
}
## case 2, odd number of negatives no 0s or single 0 no negs
if ($product < 0 or ($zeros == 1 and $negs == 0)) {
    ($max_products, $product) = divide_left_right( @array );
}
## case 3 we need to do it the hard way and compute all subarrays
else {
    ($max_products, $product) = find_max_product(make_all_sublists(@array));
}

print_output($max_products, $product );




## ## ## ## ## SUBS:

sub product {
## calculate the reduction product
## given a null list returns - inf (defined, but any value is greater)
    my @list = @_;
    return( - inf ) if scalar @list == 0;
    my $product = 1;
    $product *= $_ for @list;
    return $product;
}

sub divide_left_right {
## divides list into left and right sections
## shifting off first negative from either side and
## calculate product of remaining elements
## solves for either odd count of negative numbers or single 0,
## but not both together
    my @array = @_;
    my @max_sublists;
    my $val = "inf";

    my @left = @array;
    $val = pop @left until $val <= 0;
    my $left = product(@left);
    my @right = @array;
    do {$val = shift @right; } until $val <= 0;
    my $right = product(@right);

    if ($right > $left) {
        @max_sublists = \@right;
        $product      = $right;
    }
    elsif ($right == $left) {
        @max_sublists = (\@right, \@left);
        $product      = $right;
    }
    else {
        @max_sublists = \@left;
        $product      = $left;
    }
    return (\@max_sublists, $product);
}

sub make_all_sublists {
## constructs all sublists as an array of array refs:
## ex: [ [1], [1,2], [1,2,3], [2], [2,3], [3] ]
    my @array = @_;
    my @sublists;
    my $end = scalar @array - 1;
    for my $start ( 0..$end ) {
        my @subset = ();
        for my $idx ($start..$end) {
            push @subset, $array[$idx];
            my @copy = @subset;
            push @sublists, \@copy;
        }
    }
    return @sublists;
}

sub find_max_product {
## iterate through array of array refs,
## calc products and keeps track of maximums
    my @output = @_;
    my $max_product = - inf;
    my @max_sublists;

    for my $list ( @output){
        my $product = product( @$list );
        if ($product > $max_product) {
            $max_product  = $product;
            @max_sublists = ($list);
        }
        elsif ($product == $max_product) {
            push @max_sublists, $list
        }
    }
    return (\@max_sublists, $max_product);
}

sub print_output {
## given list ref and product
## prints output
    my ($max_sublists, $product) = @_;

    say "product  : ", $product;
    say "subset(s): ";
    say join ", ", $_->@* for $max_sublists->@*;
}
