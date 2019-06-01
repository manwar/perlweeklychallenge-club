#! /usr/bin/env perl6

multi MAIN (Int $number where $number > 0)
{
  say to-roman($number);
}
 
multi MAIN (Str $roman)
{
  my $int = from-roman($roman);
  $roman eq to-roman($int)
    ?? say $int
    !! die "Wrong order of the Roman digits"; 
}

sub to-roman (Int $number is copy)
{
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

# my Set $subtractive = <CM CD XC XL IX IV>.Set;

my %value = ( I => 1, V => 5, X => 10, L => 50, C => 100, D => 500, M => 1000);

my Set $valid-roman = %value.keys.Set;

my $current-value = Inf;

sub from-roman (Str $roman)
{
  my @digits = $roman.comb;

  die "Non-Roman digit $_ detected." unless $valid-roman{$_} for @digits;

  my $number = 0;

  while @digits
  {
    my $current = @digits.shift;
    
    # die "Wrong order of the Roman digits" if $current-value < %value{$current};
    # $current-value = %value{$current};
    
    if @digits.elems
    {
      if %value{@digits[0]} > %value{$current}
      {
        # die "Non-Roman Subtractive Notation" unless $subtractive{$current ~ @digits[0]};
        $number += %value{@digits.shift} - %value{$current};
        next;
      }
    }
    $number += %value{$current};
  }

  return $number;
}