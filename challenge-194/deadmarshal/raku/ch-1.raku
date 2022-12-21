sub digital-clock(Str $str)
{
  if ($str ~~ /(.)(.):(.)(.)/)
  {
    $1 eq '?' ?? ($2 < 4 ?? 2 !! 1)
    !! $2 eq '?' ?? ($1 < 2 ?? 9 !! 3)
    !! $3 eq '?' ?? 5
    !! 9;    
  }
}

say digital-clock('?5:00');
say digital-clock('?3:00');
say digital-clock('1?:00');
say digital-clock('2?:00');
say digital-clock('12:?5');
say digital-clock('12:5?');

