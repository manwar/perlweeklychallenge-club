use 5.036;

my @prices = map int, @ARGV;

my @sale_prices;
my @seen_prices;

for my $price (reverse @prices) {
    # find the index where all the seen prices are lower or equal to this price
    my ($seen_price_index) = grep $seen_prices[$_] > $price, 0..$#seen_prices;
    $seen_price_index //= @seen_prices;
    my $discount = $seen_price_index > 0 ? $seen_prices[$seen_price_index - 1] : 0;
    if ($seen_price_index == 0 || $seen_prices[$seen_price_index-1] != $price) {
        splice @seen_prices, $seen_price_index, @seen_prices-$seen_price_index, $price;
    }
    unshift @sale_prices, $price - $discount;
}

say 'prices: ', join ', ', @prices;
say 'sale prices: ', join ', ', @sale_prices;
