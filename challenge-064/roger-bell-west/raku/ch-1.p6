#! /usr/bin/perl6

my @in=(
  (1,2,3),
  (4,5,6),
  (7,8,9),
    );


my @l=((0,0),);

my $s='';
my @p;

while (@l) {
  my @t=(shift @l).flat;
  my @xy=splice @t,0,2;
  push @t,@in[@xy[0]][@xy[1]];
  if (@t[@t.end] == @in[@in.end][@in[@in.end].end]) {
    my $sa=sum(@t);
    if ($s eq '' || $sa < $s) {
      $s=$sa;
      @p=@t;
    }
  }
  if (@xy[0] < @in.end && @xy[1] <= @in[@xy[0]+1].end) {
    push @l,(@xy[0]+1,@xy[1],map {$_},@t);
  }
  if (@xy[1] < @in[@xy[0]].end) {
    push @l,(@xy[0],@xy[1]+1,map {$_},@t);
  }
}

say "$s ( " ~ join(' → ',@p) ~ " )";
