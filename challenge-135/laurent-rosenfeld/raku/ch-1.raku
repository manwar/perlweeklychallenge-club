sub mid-three (Int $in is copy) {
    $in = abs($in);
    my $length = $in.chars;
    return "Even number of digits" if $length %% 2;
    return "Too short" if $length < 3;
    my $mid-point = ($length - 1) /2;
    return substr($in, $mid-point - 1, 3);
}
for <1234567 -123 1 10 -54321> -> $n {
    say "$n -> ", mid-three $n;
}
