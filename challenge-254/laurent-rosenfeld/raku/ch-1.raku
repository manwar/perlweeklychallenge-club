sub exp-three ($in) {
    return True if $in == 0;
    my $exp = (log $in, 3).Int;
    return (3 ** $exp == $in or 3 ** ($exp + 1) == $in);
}

say "$_ \t=> ", exp-three $_ for <27 26 0 6>;
