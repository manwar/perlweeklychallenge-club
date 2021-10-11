#! /usr/bin/perl6

distinctterms(3,3);

distinctterms(3,5);

sub distinctterms($m,$n) {
  my @r;
  push @r,[('x',1..$n).flat];
  my %terms;
  for (1..$m) -> $mm {
    my @q=($mm);
    for (1..$n) -> $nn {
      my $p=$mm*$nn;
      push @q,$p;
      %terms{$p}=1;
    }
    push @r,@q;
  }
  my @cw=(0,0);
  for @r -> @rr {
    for (0..@rr.end) -> $ci {
      my $wi=$ci==0 ?? 0 !! 1;
      @cw[$wi]=max(@cw[$wi],chars(@rr[$ci]));
    }
  }
  for (0..@r.end) -> $ri {
    my @k;
    if ($ri==0) {
      push @k,sprintf('%' ~ @cw[0] ~ 's',@r[$ri][0]);
    } else {
      push @k,sprintf('%' ~ @cw[0] ~ 'd',@r[$ri][0]);
    }
    push @k,'|';
    for (1..@r[$ri].end) -> $ci {
      push @k,sprintf('%' ~ @cw[1] ~ 'd',@r[$ri][$ci]);
    }
    my $l=join(' ',@k);
    say $l;
    if ($ri==0) {
      $l ~~ s:g/<-[|]>/-/;
      $l ~~ s:g/\|/+/;
      say $l;
    }
  }
  say "";
  say "Distinct Terms: " ~ join(', ',sort { $^a <=> $^b },keys %terms);
  say "Count: " ~ (%terms.keys.elems);
}
