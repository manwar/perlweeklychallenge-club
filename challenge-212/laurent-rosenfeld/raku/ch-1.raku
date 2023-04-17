sub jump-letter ($letter, $val) {
    my $new_ascii = $letter.ord + $val;
    return ($new_ascii - 26).chr if $new_ascii > 'z'.ord;
    return ($new_ascii - 26).chr if $letter le 'Z'
        and $new_ascii > 'Z'.ord;
    return $new_ascii.chr;
}
my @test = "Perl", <2 22 19 9>;
for ("Perl", <2 22 19 9>), ("Raku", <24 4 7 17>) -> @test {
    printf "%-10s => ", "@test[0]";
    for @test[0].comb Z @test[1].Array -> $a {
        print jump-letter $a[0], $a[1];
    }
    say " ";
}
