use v6;

# AUTHOR: Robert DiCicco
# DATE 2022-07-12
# Challenge 173 Esthetic Number ( Raku )

my $arr = ();

sub is_esthetic($a) {

  $arr = $a.comb;
  my $prev = $arr[0];
  my $i = 1;

  while $i < $arr.elems {

    if abs($arr[$i] - $prev) == 1 {
      $prev = $arr[$i];
      $i++;
    } else {
      return -1;
    }

  }

  return 1;

}

for (100..5000) -> $e {

  my $retval = is_esthetic($e);

   if $retval == 1 {

     print("$e ");

   }

}

print("\n");
