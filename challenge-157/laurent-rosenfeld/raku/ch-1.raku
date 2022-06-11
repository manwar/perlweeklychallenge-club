for (1,3,5,6,9), (2,4,6,8,10), (1,2,3,4,5) -> @in {
    my $n = @in.elems;
    my $am = ([+] @in)/ $n;
    my $gm = ([*] @in)** (1/$n);
    my $hm = $n / ([+] map { 1/$_}, @in);
    printf  "%-10s -> AM: %0.1f, GM: %0.1f, HM: %0.1f\n", "@in[]", $am, $gm, $hm;
}
