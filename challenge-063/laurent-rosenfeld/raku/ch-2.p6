sub rotate-once (Str $str, Int $num) {
    $str.substr($num, $str.chars - $num) ~ $str.substr(0, $num);
}
sub rotate-str (Str $origin-str) {
    my $tmp = $origin-str;
    my $len = $origin-str.chars;
    my $i = 1;
    loop {
        $tmp = rotate-once $tmp, $i % $len;
        # say $tmp;
        return $i if $tmp eq $origin-str;
        $i++;
    }
}
for <xyxx xxyyy abcdefgh> {
    say "Got original string $_ after {rotate-str($_)} rotations.";
}
