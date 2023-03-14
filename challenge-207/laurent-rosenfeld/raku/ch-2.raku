sub h-index (@citations) {
    my @ordered = @citations.sort.reverse;
    for 0..@ordered.end -> $i {
        return $i if $i+1 > @ordered[$i];
    }
    # If we get here, then all papers qualify
    return @ordered.elems;
}
for <10 8 5 4 3>, <25 8 5 3 3>, <12 10 9 5 11> -> @test {
  say "@test[]".fmt("%-15s => "), h-index @test;
}
