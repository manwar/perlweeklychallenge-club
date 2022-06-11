#! /usr/bin/perl6

my @b;
for lines() {
    .chomp;
    my @a = $_.comb;
    my $u = True;
    for @a.rotor(2 => -1) -> @i {
        if (@i[0] gt @i[1]) {
            $u = False;
            last;
        }
    }
    if ($u) {
        @b.push($_);
    }
}

for @b.sort({$^b.chars <=> $^a.chars}) -> $l {
    say $l;
}
