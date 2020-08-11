sub MAIN (Str $string is copy = 'Perl Weekly Challenge'); # [1]
{
  my $count = $string ~~ tr/e/E/;

  say "$string (with $count replacements).";
}


