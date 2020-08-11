use v6;

sub switch (Str $num) {
    [~] $num.comb.map({$_ eq "0" ?? 1 !! 0});
}

my $prev = '001';
for 3..8 -> $i {
    $prev = $prev ~ "0" ~ switch $prev.flip;
    say "$i $prev";
}
