#! /usr/bin/perl6

my @names=('blue','yellow','black','green','red');
my @base=(8,7,0,5,9);
my @candidate=(1,2,3,4,6);
my $target=11;

my @index;
my @metanames;
for (0..@names.end-1) -> $k {
  @metanames.push(@names[$k]);
  @metanames.push(@names[$k] ~ '/' ~ @names[$k+1]);
}
push @metanames,@names[@names.end];

for (0..@base.end*2) -> $a {
  @index[0]=$a;
  for (0..@base.end*2) -> $b {
    @index[1]=$b;
    for (0..@base.end*2) -> $c {
      @index[2]=$c;
      for (0..@base.end*2) -> $d {
        @index[3]=$d;
        for (0..@base.end*2) -> $e {
          @index[4]=$e;
          my @sums=@base;
          for (0..@candidate.end) -> $i {
            my $ix=floor(@index[$i]/2);
            @sums[$ix]+=@candidate[$i];
            if (@index[$i]%2==1) {
              @sums[$ix+1]+=@candidate[$i];
            }
          }
          if (min(@sums)==$target && max(@sums)==$target) {
            say join(', ',map {"@candidate[$_] in @metanames[@index[$_]]"}, (0..@candidate.end));
          }
        }
      }
    }
  }
}
