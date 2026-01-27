#!/usr/bin/perl
use 5.038;
use warnings;

sub gcd($a, $b) {
    if ($b == 0) {
        return  $a;
    }

    gcd($b, $a % $b);
}

sub unique(@list) {
    my %elems;
    for (@list) {
        $elems{$_}++;
    }

    return grep { --$elems{$_} == 0 } @list;

}

sub X($arr1, $arr2) {
    return
    map {
        my $first = $_;
        map { 
            [ ref $first eq 'ARRAY' ? @{$first} : $first, $_ ];
        } @{$arr2};
    } @{$arr1};
}


my ($int) = @ARGV;

say join q{, },
  unique(
    map { "$_->[0]/$_->[1]" }
    sort { ($a->[0] / $a->[1]) <=> ($b->[0] / $b->[1]) }
    map { my $gcd = gcd($_->[0], $_->[1]); [$_->[0] / $gcd, $_->[1] / $gcd] }
    X([1 .. $int], [1 .. $int])
);
