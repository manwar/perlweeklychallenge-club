use v6;

#  AUTHOR: Robert DiCicco
# DATE: 22-MAR-2022
# Challenge 157 Brazilian Number ( Raku )

sub MAIN ( Int $num ){

  my $retval = 0;
  my $flag = 0;

  say "Input: $num";

  for 2..($num-2) {
    my $x = $num.base($_);
    $retval = checkDigits($x);
    say "In base $_: $x";

    if ($retval == 1)  {
      $flag++;
      say "Output: 1";
    }

    last if $retval == 1;
  }

  if ($flag == 0) {
    say "Output: 0";
  }
}

sub checkDigits ( $n ) {

  my @arr = $n.comb;
  my $digit = @arr[0];

  for 1..(@arr.elems - 1) -> $i  {
    my $ch = @arr[$i];
    return 0 if ( $ch != $digit);
  }

  return 1;
}
