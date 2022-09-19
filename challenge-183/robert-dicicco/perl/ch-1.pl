#!perl.exe

use strict;
use warnings;

# AUTHOR: Robert DiCicco
# DATE: 2022-09-19
# Challenge 183 Unique Array ( Perl )

my @list = ([1,2], [3,4], [5,6], [1,2]);

#my @list = ([9,1], [3,7], [2,5], [2,5]);

my %list_uniq = ();

my $display_list;

my $out_display_list;

print("Input: ( [");

for my $i (0 .. (scalar @list) - 1 ){

  $display_list = join(",", @{$list[$i]});

  $out_display_list .= join(",", @{$list[$i]});

  $out_display_list .= "], [";

  if (! exists $list_uniq{$display_list} ) {

    $list_uniq{$display_list} = 1;

  }

}

$out_display_list =~ s/\,\s+\[$//;

print($out_display_list);

print(" )\n");

my $out ="";

for my $key ( keys %list_uniq) {

   $out .= "[$key], ";

}

$out =~ s/\,\s+$//;

my @s = sort(split(" ",$out));

$out = join(" ", @s);

chop($out);

print("Output: ( $out )\n");
