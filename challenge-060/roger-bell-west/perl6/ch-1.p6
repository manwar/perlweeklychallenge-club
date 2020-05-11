#! /usr/bin/perl6

for (
  (1,'A'),
  (26,'Z'),
  (27,'AA'),
  (52,'AZ'),
  (53,'BA'),
  (520,'SZ'),
  (620,'WV'),
  (676,'YZ'),
  (677,'ZA'),
  (701,'ZY'),
  (702,'ZZ'),
  (703,'AAA'),
  (1024,'AMJ'),
  (2600,'CUZ'),
  (10000,'NTP'),
    ) -> @testpair {
  my $l=encode(@testpair[0]);
  if ($l ne @testpair[1]) {
    die "Failed @testpair[0] gives $l should be @testpair[1]\n";
  }
  $l=decode(@testpair[1]);
  if ($l ne @testpair[0]) {
    die "Failed @testpair[1] gives $l should be @testpair[0]\n";
  }
}

sub encode ($inc) {
  my $in=$inc;
  my $b=26;
  my $c=$b;
  my $d=1;
  while ($in > $c) {
    $in-=$c;
    $c*=$b;
    $d++;
  }
  $in--;
  my @digits;
  my @c=('A'..'Z');
  for (1..$d) {
    unshift @digits,@c[$in % $b];
    $in=truncate($in/$b);
  }
  return join('',@digits);
}

sub decode ($in) {
  my @c=('A'..'Z');
  my %c=map {@c[$_] => $_}, (0..@c.end);
  my @digits=$in.comb(/./);
  my $d=@digits.elems;
  my $b=26;
  my $o=0;
  for (@digits) {
    $o*=$b;
    $o+=%c{$_};
  }
  my $c=1;
  $o++;
  for (2..$d) {
    $c*=$b;
    $o+=$c;
  }
  return $o;
}
