use v6;

my @A = 1, 2, 7, 7, 7, 2, 3, 2, 4, 2, 7, 7, 7, 8, 1;
my @B = 1, 7, 7, 7, 8, 1, 7, 7, 7;
for (@A, @B) -> $c {
    my Bag $b = $c.Bag;
    my $item = $b.kv.max({$b{$_}});
    my $count = $b{$item};
    say "Majority element for $c:";
    say $count > $c.elems div 2 ?? $item !! -1;
}
