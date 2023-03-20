# The Weekly Challenge 208
# Task 1 Minimum Index Sum
use v5.30.0;
use warnings;
use Array::Utils qw/intersect/;

sub aindex {
    my $item = $_[0];
    my @list = $_[1]->@*;
    for my $i (0..$#list) {
        return $i if $item eq $list[$i];
    }
    return undef;
}

sub mis {
    my @ans = ();
    my @list1 = $_[0]->@*;
    my @list2 = $_[1]->@*;
    my @comm  = intersect(@list1, @list2);
    my $mis = $#list1 + $#list2;
    foreach (@comm) {
        my $ind_sum = aindex($_, [@list1]) + aindex($_, [@list2]);
        if ($ind_sum == $mis) {
            push @ans, $_;
        } elsif ($ind_sum < $mis) {
            $mis = $ind_sum;
            @ans = ($_);
        }
    }
    return [sort {$a cmp $b} @ans];
}

use Test::More tests=>3; 
use Test::Deep;
cmp_deeply 
    mis(["Perl", "Raku", "Love"], ["Raku", "Perl", "Hate"]), 
    ["Perl", "Raku"];
cmp_deeply mis(["A", "B", "C"], ["D", "E", "F"]),
    [];
cmp_deeply
    mis(["A", "B", "C"], ["C", "A", "B"]),
    ["A"];
