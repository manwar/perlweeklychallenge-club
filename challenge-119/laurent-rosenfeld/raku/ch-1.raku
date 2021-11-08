use v6;

for 254, 101, 18 -> $n {
    my $b4 = $n.base(4).fmt("%04s");
    # say $n.base(2).fmt("%08s");
    $b4 ~~ s/(\d**2)(\d**2)/$1$0/;
    # say $b4.parse-base(4).base(2).fmt("%08s");
    say "$n -> ", $b4.parse-base(4);
}
