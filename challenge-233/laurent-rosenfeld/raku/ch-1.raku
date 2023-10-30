sub similar (@in) {
    my %words;
    %words{$_}++ for map { $_.comb.sort.squish.join("")}, @in;
    %words = map { $_ => %words{$_}}, grep {%words{$_} > 1}, %words.keys;
    my $count = 0;
    $count += ([*] 1..%words{$_})/2 for %words.keys;
    return $count;
}

for <aba aabb abcd bac aabc>, <aabb ab ba>,
    <nba cba dba> -> @test {
    printf "%-30s => ", "@test[]";
    say similar @test;
}
