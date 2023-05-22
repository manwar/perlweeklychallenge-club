sub infix:<myleg> ($a, $b) {
    return $a leg $b if $a.chars == $b.chars;
    if $a.chars > $b.chars {
        my $c = substr $a, 0, $b.chars;
        return $a leg $b if $c != $b;
        return (substr $a, $b.chars + 1) leg $c ;
    } else {
        my $c = substr $b, 0, $a.chars;
        return $a leg $b if $c != $a;
        return $c leg (substr $b, $a.chars + 1);
    }
}

sub reorder (@in) {
    return @in.sort({$^b myleg $^a}).join: "";
}

for (1, 23), (10, 3, 2), (31, 2, 4, 10),
    (5, 11, 4, 1, 2), (1, 10), (10, 1),
    (1, 10), (1, 100), (100, 1) -> @test {
    say "@test[]".fmt("%-15s => "), reorder @test;
}
