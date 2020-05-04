#! /usr/bin/perl6

my $s=0;
my @list=(2,3,4);
if (@*ARGS) {
  @list=@*ARGS;
}
for 0..@list.end-1 -> $i {
  for $i+1..@list.end -> $j {
    $s+=f([@list[$i],@list[$j]]);
  }
}
say $s;

sub f (@f) {
  my @g=(map {comb /./,sprintf('%b',$_)}, @f[0]).flat;
  my @h=(map {comb /./,sprintf('%b',$_)}, @f[1]).flat;
  my $r=max(@g.elems,@h.elems);
  @g.prepend(0 xx ($r-@g.elems));
  @h.prepend(0 xx ($r-@h.elems));
  my $d=0;
  map {$d+=(@g[$_]==@h[$_])??0!!1}, (0..$r-1);
  return $d;
}
