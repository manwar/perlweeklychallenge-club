sub replace-digits ($in) {
    my @chars = $in.comb;
    for 1..@chars.end -> $i {
        if @chars[$i] ~~ /\d/ {
            @chars[$i] = chr( @chars[$i-1].ord + @chars[$i]);
        }
    }
    return join "", @chars;
}

my @tests = 'a1c1e1', 'a1b2c3d4', 'b2b', 'a16z';
for @tests -> $test {
    printf "%-10s => ", $test;
    say replace-digits $test;
}
