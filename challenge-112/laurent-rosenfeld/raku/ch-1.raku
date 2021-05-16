use v6

my @tests = </a/ /a/b//c/ /a/b/c/../.. /a/../../b/>;
for @tests <-> $path {
    my $p = $path;
    $path ~~ s:g|'//'+|/|;
    $path ~~ s:g!^'/' | '/'$!!;
    my @path-items;
    for split /'/'+/, $path -> $item {
        next if $item eq '.';
        if $item eq '..' {
            die "Invalid path $p" unless @path-items;
            pop @path-items;
        } else {
            push @path-items, $item;
        }
    };
    say "$p => /", @path-items.join('/');
}
