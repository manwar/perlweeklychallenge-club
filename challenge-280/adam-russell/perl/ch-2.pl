
  
use v5.38;

  
sub count_asterisks{
  my($s) = shift;
  my $score = 0;
  my @asterisks = ();
  my @s = split /\|/, $s;
  {
      my $x = shift @s;
      my $y = shift @s;
      my @a = $x =~ m/(\*)/g if $x;
      push @asterisks, @a if @a > 0;
      redo if @s >= 1;
  }
  return 0 + @asterisks;
}

  
MAIN:{
  say count_asterisks q/p|*e*rl|w**e|*ekly|/;
  say count_asterisks q/perl/;
  say count_asterisks q/th|ewe|e**|k|l***ych|alleng|e/;
}  

