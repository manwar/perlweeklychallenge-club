sub bit-w($in) {
    # bit weight function: returns number of 1s in the
    # binary representation of the input integer
    return [+] $in.base(2).comb;
}
sub bit-sort (@test) {
    sort { bit-w($^a) cmp bit-w($^b) or $^a cmp $^b }, @test;
}

my @tests = (0, 1, 2, 3, 4, 5, 6, 7, 8),
            (1024, 512, 256, 128, 64),
            (7, 23, 512, 256, 128, 64);
for @tests -> @test {
    printf "%-20s => ", "@test[]";
    say bit-sort @test;
}
