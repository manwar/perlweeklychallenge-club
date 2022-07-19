sub is-disarium($num) {
    my @digits = $num.comb;
    my $sum = [+] map { $^b ** ($^a + 1) }, @digits.kv;
    return $num == $sum;
}
my $count = 0;
my $i = 0;
while $count < 19 {
    ++$count and say $i if is-disarium($i);
    $i++;
    # say "i: $i";
}
