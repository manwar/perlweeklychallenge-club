#! /usr/bin/perl6

use Gumbo;

my @dtime;

for ('2019-11-london.html','2019-12-london.html') -> $file {
  my $dlt=0;
  my $fh=open :r,$file;
  my $text='';
  for $fh.lines {
    $text ~= $_;
  }
  close $fh;
  my $xml=parse-html($text);
  my $tab=$xml.root.elements(:TAG<table>, :RECURSE)[0];
  for $tab.elements(:TAG<tr>, :RECURSE) -> $tr {
    my @td=$tr.elements(:TAG<td>, :RECURSE);
    if (@td.elems==12) {
      my $dl=@td[2].nodes[0].text;
      $dl ~~ /(\d+) ':' (\d+) ':' (\d+)/;
      $dlt+=$0*3600+$1*60+$2;
    }
  }
  push @dtime,$dlt;
}

say 'delta ',@dtime[1]-@dtime[0],' s';
