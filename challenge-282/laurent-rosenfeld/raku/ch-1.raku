sub good-integer ($in) {
    return -1 if $in ~~ / (\d) $0 ** 3 /;    # 4 digits
    return  ~$/ if $in ~~ / (\d) $0 ** 2 /;  # 3 digits
}

my @tests = 12344456, 123444456, 1233334, 10020003;
for @tests -> $test {
    printf "%-10s => ", $test;
    say good-integer $test;
}
