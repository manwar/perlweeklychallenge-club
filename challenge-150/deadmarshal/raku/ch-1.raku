sub fibonacci_words($input1, $input2)
{
  my @arr = [$input1, $input2];
  repeat
  {
    @arr.push(@arr[*-2] ~ @arr[*-1]);
  }until (@arr[*-1].chars >= 52);
  return @arr.comb[50];
}

sub MAIN(Str $input1, Str $input2)
{
  say fibonacci_words($input1, $input2);
}
