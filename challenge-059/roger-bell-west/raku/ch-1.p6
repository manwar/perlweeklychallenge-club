#! /usr/bin/perl6

my $k=3;
my @list=(1,4,3,2,5,2);

if (@*ARGS) {
  $k=pop @*ARGS;
  @list=@*ARGS;
}

my %m=classify { $_ < $k ?? 1 !! 2 }, @list;

my @out;
for 1,2 -> $mode {
  @out.append: %m{$mode}.flat;
}

say join(' → ',@out);
