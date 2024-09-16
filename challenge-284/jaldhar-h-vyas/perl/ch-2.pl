#!/usr/bin/perl
use v5.38;

my @list1 = split /\s*/, $ARGV[0];
my @list2 = split /\s*/, $ARGV[1];

my %elems;
for my $int (@list1) {
    push @{$elems{$int}}, $int;
}

my @result;

for my $e (@list2) {
    push @result,  @{$elems{$e}};
    delete $elems{$e};
}

for my $e (sort { $a <=> $b } keys %elems) {
    push @result,  @{$elems{$e}};
    delete $elems{$e};
}

say q{(}, (join q{, }, @result), q{)};