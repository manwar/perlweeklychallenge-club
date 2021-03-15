#! /usr/bin/perl6

use Test;

plan 1;

is(wp(1606134123,1614591276,'t2.csv'),'00:10:24 Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)','example 1');

sub wp($ts,$tn,$csvfile) {
  my $td=($tn-$ts)*1000;
  my $fh=open :r,$csvfile;
  my @aoa;
  for $fh.lines {
    .chomp;
    my ($len,$title)=$_.comb(/<-[,]>+/,2);
    $title ~~ s/^\"//;
    $title ~~ s/\"$//;
    @aoa.push([$len,$title]);
  }
  my $tp=sum(map {$_[0]},@aoa);
  $td %= $tp;
  for @aoa -> @t {
    if ($td < @t[0]) {
      $td=floor($td/1000);
      my $h=floor($td/3600);
      my $m=floor($td/60) % 60;
      my $s=$td % 60;
      return sprintf('%02d:%02d:%02d %s',$h,$m,$s,@t[1]);
    } else {
      $td-=@t[0];
    }
  }
}

