use v6;

# AUTHOR: Robert DiCicco
# DATE: 2022-09-26
# Challenge 184 Sequence Number ( Raku )

my $cnt = 0;

my @arr = ( 'ab1234', 'cd5678', 'ef1342');

#my @arr = ( 'pq1122', 'rs3334');

print("Input: \@list = (" );

for ( @arr ) -> $a {

  print("\'$a\' ");

}

print(")\n");

print("Output: (");

for (@arr) -> $a {

  my $pt1 = substr($a, 0, 2);

  my $pt2 = substr($a,2,4);

  my $text1 = sprintf("%.2d", $cnt );

  $cnt++;

  print("$text1$pt2 ");

}

print(")\n");
