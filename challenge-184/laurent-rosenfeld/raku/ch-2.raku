for ('a 1 2 b 0', '3 c 4 d'), ('1 2', 'p q r', 's 3', '4 5 t') -> @test {
    my (@letters, @digits);
    for @test -> $item {
        append @letters, grep {  /<alpha>+/ }, $item.split(/\s+/);
        append @digits, grep { /\d+/ }, $item.split(/\s+/);
    }
    .say for @letters, @digits;
}
