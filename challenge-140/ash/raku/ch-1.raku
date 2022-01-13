class Binary {
    has Str $.value;

    method gist() returns Str {
        return $.value;
    }
}

# Do not forget "multi" here as otherwise it will overload too much, including the built-in infix:<+>(Int, Int).
multi sub infix:<+>(Binary $a, Binary $b) returns Binary {
    my Int $sum = "0b{$a.value}".Int + "0b{$b.value}".Int;

    return Binary.new(value => $sum.base(2));
}

sub MAIN(IntStr $a, IntStr $b) {
    my $x = Binary.new(value => $a);
    my $y = Binary.new(value => $b);

    say $x + $y;
}
