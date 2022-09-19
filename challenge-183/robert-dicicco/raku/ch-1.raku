use v6;

# AUTHOR: Robert DiCicco
# DATE:   2022-09-19
# Challenge 183 Unique Array ( Raku )

my @list = ([1,2], [3,4], [5,6], [1,2]);

#my @list = ([9,1], [3,7], [2,5], [2,5]);

my %list_uniq = ();

my $display_list;

my $out_display_list;

print("Input: ( ");

for (0 .. @list.elems - 1 ) -> $i {

  $display_list = @list[$i].join(",");

  if not %list_uniq.EXISTS-KEY(@list[$i]) {

    %list_uniq{@list[$i]} = 1;

  }

  $out_display_list ~= "[";

  $out_display_list ~= @list[$i].join(",") ~ "],";

}

$out_display_list ~~ s:g/\,$//;

$out_display_list ~= " \)";

 print("$out_display_list\n");

my $out = "";

print "Output: ";

for %list_uniq.keys -> $key {

  $out ~= "[$key], ";

}

chop($out);

$out ~~ s:g/\,\s+$//;

my @s = sort(split(",",$out));

$out = @s.join(",");

$out = $out.sort;

print("(" ~ $out ~ " )" ~ "\n");
