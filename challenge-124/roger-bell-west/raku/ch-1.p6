#! /usr/bin/perl6

my $char='^';
my @shape=(3,-3,-4,-5,-5,-5,-5,-5,-4,-3,3,1,1,1,3,1,1);
my $mx=max(map {abs($_)},@shape);

for @shape -> $row {
  my $line;
  if ($row>0) {
    $line=$char x $row;
  } else {
    $line=(' ' x -$row)~$char;
  }
  my $ll=chars($line);
  if ($ll <= $mx) {
    $line ~= ' ' x ($mx-$ll+1);
  }
  my $f=$line.substr(1).flip;
  print "$f$line\n";
}
