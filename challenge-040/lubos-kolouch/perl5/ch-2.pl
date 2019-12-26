#!env perl
use strict;
use warnings;
use feature qw /say/;
use Data::Dumper;


my $array_ref = shift // die 'No arrays passed';

my @arr = $array_ref;

die "Usage ch-2.pl \"[10 4 1 8 12 3][0 2 5]\"" unless ($arr[0] =~ / ^(\[(\d+\h*)+\])+$/msx);

my $arr_size;

my @all_array;

my $i=0;
for (split /\]/, $arr[0]) {
    $_ =~ s/\[//g;

    push @{$all_array[$i]}, split / /;

    $arr_size = scalar @{$all_array[$i]} unless $arr_size;

    $i++;
}

my @sort_array;

for (@{$all_array[1]}) {
    push @sort_array, $all_array[0][$_];
}

@sort_array = sort {$a <=> $b} @sort_array;

$i=0;
for (@{$all_array[1]}) {
    $all_array[0][$all_array[1][$i]] = $sort_array[$i];
    $i++;
}

warn Dumper \$all_array[0];
