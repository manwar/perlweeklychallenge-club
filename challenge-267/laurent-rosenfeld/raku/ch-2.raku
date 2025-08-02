sub line-count(@in_widths, $in_str) {
    my $i = 0;
    my %widths;
    for 'a'..'z' -> $let {
        %widths{$let} = @in_widths[$i++];
    }
    my $line-count = 1;
    my $line-width = 0;
    for $in_str.comb -> $let {
        my $tmp = $line-width + %widths{$let};
        if $tmp <= 100 {
            $line-width = $tmp;
        } else {
            $line-count++;
            $line-width = %widths{$let};
        }
    }
    return "($line-count, $line-width)";
}

my @tests = (10 xx 26, "abcdefghijklmnopqrstuvwxyz"),
            ([4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,
            10,10,10,10,10,10,10,10,10,10,10], "bbbcccdddaaa");

for @tests -> @test {
    printf "%-28s => ", @test[1];
    say line-count @test[0], @test[1];
}
