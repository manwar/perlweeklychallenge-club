#! /usr/bin/env raku

unit sub MAIN ($str where $str ~~ /^ <[a .. z]>+ $/,
               :v(:$verbose));

my %h = ('z' ... 'a').map({ state $i = 1;  $_ => $i++});

my $total = 0;

for 1 .. $str.chars -> $i
{
  my $letter = $str.substr($i -1, 1);
  my $sum    = $i * %h{$letter};

  $total += $sum;
 
  say ": Pos:$i Char:'$letter' Val:%h{$letter} Sum:$sum" if $verbose;
}

say $total;