sub reverse-vowels ($in) {
    my $str = $in.lc;
    my @vowels = map { .Str }, $str ~~ m:g/<[aeiou]>/;
    $str ~~ s:g/<[aeiou]>/{pop @vowels}/;
    return $str.tc;
}

for <Raku Perl Julia Uiua> -> $test {
    say "$test \t => ", reverse-vowels $test;
}
