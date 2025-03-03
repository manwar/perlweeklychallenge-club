#!/usr/bin/perl
use v5.38;

sub intersection($arr1, $arr2) {
    my %intersection;
    for my $i (@{$arr1}, @{$arr2}) {
        $intersection{$i}++;
    }

    return grep { $intersection{$_} > 1 } keys %intersection;
}

my @list = map { [ split /\s+/, $_ ] } @ARGV;

my @result = @{shift @list};

for my $arr (@list) {
    @result = intersection(\@result, $arr);
}

say q{(}, (join q{, }, sort { $a <=> $b } @result), q{)};
