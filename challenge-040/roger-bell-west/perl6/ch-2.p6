#! /usr/bin/perl6

my @list=(10, 4, 1, 8, 12, 3);
my @indices=(0,2,5);

my @s=(map {@list[$_]},@indices).sort;
map {@list[@indices[$_]]=@s[$_]},(0..@indices.end);

print join(', ',@list),"\n";
