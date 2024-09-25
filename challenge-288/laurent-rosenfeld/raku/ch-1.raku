sub closest-palindrome ($in) {
    for 1..Inf -> $i {
        return $in - $i if ($in - $i).flip eq $in - $i;
        return $in + $i if ($in + $i).flip eq $in + $i;
    }
}

my @tests = 123, 2, 1400, 1001;
for @tests -> $test {
    printf "%-6d => ", $test;
    say closest-palindrome $test;
}
