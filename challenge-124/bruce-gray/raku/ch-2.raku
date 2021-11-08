sub tug-of-war ( @s ) {
    my $size   = +@s     div 2;
    my $target =  @s.sum /   2;
    my $cost   = { abs .sum - $target };
    my $best   = @s.combinations($size).min($cost).Bag;

    return $best, @s.Bag (-) $best;
}

my @tests =
    (10, 20, 30, 40, 50, 60, 70, 80, 90, 100),
    (10, -15, 20, 30, -25, 0, 5, 40, -5),

    # Needed tests with duplicate numbers
    (10, 20, 30, 40, 50, 60, 70, 80, 90, 100,  99,99,99,99,99,99),
    (10, -15, 20, 30, -25, 0, 5, 40, -5,       99,99,99,99,99,99),
;

say .&tug-of-war».kxxv».sort for @tests;

