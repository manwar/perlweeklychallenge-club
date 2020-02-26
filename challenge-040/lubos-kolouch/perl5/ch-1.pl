#!env perl
use strict;
use warnings;
use feature qw /say/;
use Data::Dumper;


my $array_ref = shift // die 'No arrays passed';

my @arr = $array_ref;

die "Usage ch-1.pl \"[1 2 3 4][5 6 7 8]\"" unless ($arr[0] =~ / ^(\[(. *)+\])+$/msx);

my $arr_size;

my @all_array;

my $i=0;
for (split /\]/, $arr[0]) {
    $_ =~ s/\[//g;

    push @{$all_array[$i]}, split / /;

    $arr_size = scalar @{$all_array[$i]} unless $arr_size;

    die "arrays are not of the same size" unless scalar @{$all_array[$i]} == $arr_size;
    $i++;
}

for my $key (0..$arr_size-1) {
    for my $arr (0..scalar @all_array -1) {
            print $all_array[$arr][$key]." ";
        }
    say '';
}
