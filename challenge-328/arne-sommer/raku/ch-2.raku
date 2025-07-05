#! /usr/bin/env raku

unit sub MAIN ($str is copy where $str ~~ /^<[ a..z A..Z ]>+$/,
               :v(:$verbose));

my $index = 0;

loop
{
  my $end     = $str.chars -1;
  my $current = $str.substr($index, 1);

  last if $end   == -1;
  last if $index == $end;

  my $next = $str.substr($index +1, 1);

  print ": Checking '$current$next' (index $index)" if $verbose;

  if $current.lc eq $next.lc && $current ne $next
  {
    $str.substr-rw($index,2) = "";
    
    say " - replace with nothing -> $str" if $verbose;

    $index-- unless $index == 0;
  }
  else
  {
    say "" if $verbose;
    $index++;
  }
}

say $str;
