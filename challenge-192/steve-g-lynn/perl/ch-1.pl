#!/usr/bin/env perl

print &binary_flip(5),"\n"; #2
print &binary_flip(4),"\n"; #3
print &binary_flip(6),"\n"; #1

sub binary_flip  {
    my $b=sprintf("%b",shift);
    $b =~ tr/[10]/[01]/;
    eval('0b' . $b);
}

