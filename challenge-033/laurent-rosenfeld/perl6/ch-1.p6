use v6;

sub MAIN (*@files) {
    my $histo = (map {.IO.comb».lc}, @files).Bag;
    say "$_ : ", $histo{$_} for 'a'..'z';
}
