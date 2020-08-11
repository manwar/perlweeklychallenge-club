#! /usr/bin/perl6

my $n=11;
my $m1=$n.chars+1;
my $m2=($n*$n).chars+1;
my $fmt='%' ~ $m1 ~ 's%1s' ~ (('%' ~ $m2 ~ 's') xx $n) ~ "\n";
printf($fmt,'x','|',(1..$n));
printf($fmt,'-' x $m1,'+',('-' x $m2) xx $n);
for 1 .. $n -> $row {
  my @a=($row,'|');
  for 1 .. $n -> $column {
    if ($column < $row) {
      push @a,'';
    } else {
      push @a,$row*$column;
    }
  }
  printf($fmt,@a);
}
