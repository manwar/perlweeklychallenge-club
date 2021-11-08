my $bag = (2, 5, 4, 4, 5, 5, 2).Bag;
say grep { $bag{$_} % 2 }, $bag.keys;
