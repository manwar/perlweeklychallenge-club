use v6;

sub partition ($k, @list) {
    my @before = grep {$_ < $k}, @list;
    my @after = grep {$_ >= $k}, @list;
    return |@before, |@after;
}

sub MAIN ($k, Str $list-str = "1 4 3 2 5 2") {
    my @list = $list-str.comb(/\d+/);
    my @result = partition $k, @list;
    say @result.join(" → ");
}
