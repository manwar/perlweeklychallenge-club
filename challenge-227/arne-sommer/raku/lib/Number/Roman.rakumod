unit module Number::Roman;

our sub to-roman (Numeric $number is copy) is export(:to)
{
  return "nulla" if $number == 0;
  return "non potest" unless 0 < $number < 3999;
  return "non potest" unless $number.Int == $number;

  my $string = "";
  
  while $number >= 1000 { $string ~= "M";  $number -= 1000; }
  if $number >= 900     { $string ~= "CM"; $number -= 900; }
  if $number >= 500     { $string ~= "D";  $number -= 500; }
  if $number >= 400     { $string ~= "CD"; $number -= 400; }
  while $number >= 100  { $string ~= "C";  $number -= 100; }
  if $number >= 90      { $string ~= "XC"; $number -= 90; }
  if $number >= 50      { $string ~= "L";  $number -= 50; }
  if $number >= 40      { $string ~= "XL"; $number -= 40; }
  while $number >= 10   { $string ~= "X";  $number -= 10; }
  if $number >= 9       { $string ~= "IX"; $number -= 9; }
  if $number >= 5       { $string ~= "V";  $number -= 5; }
  if $number >= 4       { $string ~= "IV"; $number -= 4; }
  while $number >= 1    { $string ~= "I";  $number -= 1; }

  return $string;
}

my %value = (I => 1, V => 5, X => 10, L => 50, C => 100, D => 500, M => 1000);

my Set $valid-roman = %value.keys.Set;

my $current-value = Inf;

our sub from-roman (Str $roman) is export(:from)
{
  my @digits = $roman.comb;

  die "Non-Roman digit $_ detected." unless $valid-roman{$_} for @digits;

  my $number = 0;

  while @digits
  {
    my $current = @digits.shift;
        
    if @digits.elems
    {
      if %value{@digits[0]} > %value{$current}
      {
        $number += %value{@digits.shift} - %value{$current};
        next;
      }
    }
    $number += %value{$current};
  }

  return to-roman($number) eq $roman
    ?? $number
    !! die "Not a valid Roman Number: $roman";
}
