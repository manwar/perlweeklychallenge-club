sub check ( $n where { $n ~~ /^\d+$/} ) {
    my $count = 0;
    for 2..$n -> $i {
        $count++ unless $i ~~ /1/;
    }
    say "There are $count integers without a 1 in the 1..$n range.";
}
check @*ARGS[0] // 24;
