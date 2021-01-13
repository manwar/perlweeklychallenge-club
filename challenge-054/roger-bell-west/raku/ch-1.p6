#! /usr/bin/perl6

my ($n,$k)=@*ARGS;

my @f;
my $b=1;
my $v=1;
while ((@f.elems == 0) || @f[@f.end] < $k) {
  push @f,$v;
  $v*=$b;
  $b++;
}

my $nk=$k-1;
my @n;
loop (my $i=@f.end;$i>=0;$i--) {
  unshift @n,floor($nk/@f[$i]);
  $nk-=@f[$i]*@n[0];
}

my @i=(1..$n);
my @o;
loop (my $j=$n;$j>=1;$j--) {
  my $f=@n[$j-1] || 0;
  push @o,splice @i,$f,1;
}

say join($n>9 ?? ',' !! '',@o);
