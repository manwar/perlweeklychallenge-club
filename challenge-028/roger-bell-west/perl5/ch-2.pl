#! /usr/bin/perl

use strict;
use warnings;

use Imager;
use Getopt::Std;
use POSIX qw(strftime);

my %o=(w => 80,
       f => '/usr/share/fonts/truetype/msttcorefonts/Arial.ttf');

getopts('w:f:',\%o);

unless (-e $o{f}) {
  die "Specify an existing ttf/otf font file with -f\n";
}

my $f=Imager::Font->new(file => $o{f});

my $base=500;
my $size=10;

my $t=strftime('%T',localtime);

my $i=Imager->new(xsize => $base,ysize => $base, channels => 1);
my @bounds=$i->align_string(string => strftime('%T',localtime),
                            font => $f,
                            x => 0,
                            y => 0,
                            halign => 'left',
                            valign => 'top',
                            size => $size,
                              );
$size*=$o{w}/$bounds[2];
$base=$o{w};
$i=Imager->new(xsize => $base,ysize => $base, channels => 3);
my $w=Imager::Color->new(xname => 'white');
$i->box(color => $w,filled => 1);
my $b=Imager::Color->new(xname => 'black');
@bounds=$i->align_string(string => strftime('%T',localtime),
                         font => $f,
                         color => $b,
                         x => 0,
                         y => 0,
                         halign => 'left',
                         valign => 'top',
                         size => $size,
                           );
foreach my $yscan ($bounds[1]..$bounds[3]) {
  foreach my $xscan ($bounds[0]..$bounds[2]) {
    my @c=$i->getpixel(x => $xscan,y => $yscan)->hsv;
    if ($c[2]<0.5) {
      print '*';
    } else {
      print ' ';
    }
  }
  print "\n";
}
