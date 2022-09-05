#! /usr/bin/perl6

my %t;

for "temperature.txt".IO.lines() {
    .chomp;
    my @l = $_.split(/\,\s*/);
    %t{@l[0]} = @l[1];
}

my $lt = 999;
for %t.keys.sort -> $k {
    if (%t{$k} > $lt) {
        say $k;
    }
    $lt = %t{$k};
}
