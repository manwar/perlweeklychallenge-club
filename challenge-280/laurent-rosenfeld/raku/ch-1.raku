sub twice ($in) {
    my %seen;
    for $in.comb -> $let {
        return $let if %seen{$let}:exists;
        %seen{$let} = 1;
    }
}

my @tests = "acbddbca", "abccd", "abcdabbb";
for @tests -> $test {
    printf "%-10s => ", $test;
    say twice $test;
}
