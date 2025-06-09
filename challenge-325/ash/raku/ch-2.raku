
# Task 2 of the Weekly Challenge 325
# https://theweeklychallenge.org/blog/perl-weekly-challenge-325

say solve 8, 4, 6, 2, 3; # 4, 2, 4, 2, 3
say solve 1, 2, 3, 4, 5; # 1, 2, 3, 4, 5
say solve 7, 1, 1, 5;    # 6, 0, 1, 5

sub solve(*@data) {
    @data.kv.map: -> $index, $price {
        $price - ((@data[$index + 1 .. *].first: * <= $price) // 0);
    }
}
