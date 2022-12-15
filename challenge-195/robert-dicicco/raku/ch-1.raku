use v6;

#`{

  AUTHOR: Robert DiCicco

  DATE: 2022-12-12

  Challenge 195 Special Integers ( Perl )

 

  SAMPLE OUTPUT

  raku .\SpecialIntegers.rk

  Input: $n = 15

  Output: 14

 

  Input: $n = 35

  Output: 32

}

 

sub CheckUniqDigits($n) {

  my %h1 = ();

  my @arr = $n.comb;

  for (@arr) -> $val {

    %h1.EXISTS-KEY($val) ?? return 0 !! %h1{$val}++;

  }

  return 1;

}

 

for <15 35> -> $input {

  my $output = 0;

  print "Input: \$n = $input\n";

  for 1..$input -> $i {

    $output += CheckUniqDigits($i);

  }

  print "Output: $output\n\n";

}
