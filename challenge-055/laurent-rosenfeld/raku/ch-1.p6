use v6;

sub flip ($bin-nr) {
    my @chars = $bin-nr.comb;
    my @result;
    for 0..@chars.end -> $left {
        for $left..@chars.end -> $right {
            my @tmp-chars = @chars;
            for $left..$right -> $i {
                @tmp-chars[$i] = @chars[$i] == 1  ?? 0 !! 1;
            }
            my $count = [+] @tmp-chars;
            @result[$count] ~= "$left-$right: @tmp-chars[]\n";
        }
    }
    return @result[*-1];
}
sub MAIN (Str $in where $in ~~ /^ <[01]>+ $/ = "01011") {
    say flip $in;
}
