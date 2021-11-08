use v6;

sub is-ugly (UInt $in is copy where * > 0) {
    for 2, 3, 5 -> $div {
        $in div= $div while $in %% $div;
    }
    return $in == 1;
}
my $ugly-nrs = grep {is-ugly $_}, (1...Inf);
my $n = @*ARGS[0] // 7;
say $ugly-nrs[$n-1];
