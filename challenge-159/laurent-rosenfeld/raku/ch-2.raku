sub möbius ($n is copy) {
    my %factors;
    for 2..$n -> $i {
        while  $n %% $i {
            %factors{$i}++;
            $n /= $i;
        }
    }
    return 0 if %factors.values.any > 1;
    return 1 if (%factors.keys.elems %% 2);
    return -1;
}
say "$_: ", möbius $_ for 1..20;
