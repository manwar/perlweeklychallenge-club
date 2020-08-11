#! /usr/bin/perl6

my %ev;

my $fh=open :r,'data1';
for $fh.lines {
  my @e=($_ ~~ m:g/(IN|OUT) ':' \s* (\d+) ':' (\d+)/);
  while (@e) {
    my @match=@e.shift.values;
    my $delta=(@match.shift eq 'IN')??1!!-1;
    my $t=(60*@match.shift)+@match.shift;
    %ev{$t}+=$delta;
  }
}

my $ontime=0;
my $occ=0;
my $laston=0;
for (%ev.keys.sort({$^a <=> $^b})) -> $t {
  my $lastocc=$occ;
  $occ+=%ev{$t};
  if ($lastocc==0 && $occ>0) {
    $laston=$t;
  } elsif ($lastocc>0 && $occ==0) {
    $ontime+=($t-$laston);
  }
}

say $ontime;
