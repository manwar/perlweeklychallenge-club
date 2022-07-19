use v6;

# AUTHOR: Robert DiCicco
# DATE: 2022-07-18
# Challenge 174 Disarium Numbers ( Raku )

my $inp = 0;
my @arr = ();

sub getPosiSum(@a){

  my $sum = 0;

  my $i = 0;

  while $i < @a.elems  {

      $sum += @a[$i] ** ($i+1);

      $i++;

  }

  return $sum;

}

$inp = 0;

my $count = 1;

while $count < 20 {

  @arr = $inp.comb;

  my $retval = getPosiSum(@arr);

  if $retval == $inp {

    print("$retval ");

    $count++;

  }

  $inp++;

}

print(" ");
