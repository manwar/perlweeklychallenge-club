#! /usr/bin/perl6

my @place;
for lines() {
  .chomp;
  my @k=comb(/\S/,$_);
  map {@place[$_]{@k[$_]}++}, (0..@k.end);
}

for @place -> %h {
  my @v=values %h;
  my @k=keys %h;
  my @i=sort {@v[$^b] <=> @v[$^a]}, (0..@v.end);
  print @k[@i[0]];
}
print "\n";
