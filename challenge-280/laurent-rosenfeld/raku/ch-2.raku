sub count-asterisks ($in is copy) {
    $in ~~ s:g/'|'.*?'|'//;
    return +($in ~~ tr/*//);
}

my @tests = "p|*e*rl|w**e|*ekly|", "perl",
            "th|ewe|e**|k|l***ych|alleng|e";
for @tests -> $test {
    printf "%-30s => ", $test;
    say count-asterisks $test;
}
