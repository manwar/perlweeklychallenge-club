sub defang-ip ($in is copy) {
    $in ~~ s:g/\./[.]/;
    return ~$in;
}

my @tests = "1.1.1.1", "255.101.1.0", "255.255.255.255";
for @tests -> $test {
    printf "%-16s => ", $test;
    say defang-ip $test;
}
