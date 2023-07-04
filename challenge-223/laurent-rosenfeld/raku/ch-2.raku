sub collect (@box is copy) {
    my $collected = 0;
    while @box.elems > 3 {
        my $min = min (0..@box.end), :by( {@box[$_]});
        $collected += ((@box[$min-1 ] // 1) * @box[$min] * (@box[$min+1 ] // 1));
        @box = (@box[0..^$min, $min^.. @box.end]).flat;
    }
    $collected += [*] @box;
    $collected += ((@box[0] ) * (@box[2] // 1)) if @box.elems == 3;
    $collected +=  max @box;
    return $collected;
}
my @tests = (3, 1, 5, 8), (1, 5);
for @tests -> @test {
    print "@test[]".fmt("%-10s => ");
    say collect @test;
}
