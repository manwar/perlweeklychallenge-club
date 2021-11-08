use v6;

sub swap-bits (UInt $n where * <=255) {
    my $bin = $n.fmt("%08b");
    $bin ~~ s:g/(\d)(\d)/$1$0/;
    return $bin.parse-base: 2;
}
say "$_ : ", swap-bits $_ for 101, 154, 33, 18;
