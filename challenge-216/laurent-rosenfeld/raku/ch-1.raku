sub included (@words, $reg) {
    my $letters = $reg.lc.comb.grep({ /<[a..z]>/ }).Set;
    my @result;
    for @words -> $wd {
        push @result, $wd if $letters ⊆ $wd.lc.comb.Set;
    }
    return @result;
}
my @tests =
    {words => ('abc', 'abcd', 'bcd'), reg => 'AB1 2CD'},
    {words => ('job', 'james', 'bjorg'), reg => '007 JB'},
    {words => ('crack', 'road', 'rac'), reg => 'C7 RA2'};
for @tests -> %test {
    printf "%-30s", "%test<words> - %test<reg> => ";
    say included %test<words>, %test<reg>;
}
