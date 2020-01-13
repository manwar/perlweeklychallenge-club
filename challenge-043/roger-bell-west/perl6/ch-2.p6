#! /usr/bin/perl6

my $base=(shift @*ARGS) || 10;
if ($base < 4 || $base == 6) {
  die "No self-descriptive numbers in base $base\n";
}

my @digit=(slip('0'..'9'),slip('A'..'Z'),slip('a'..'z'));

my @n=0 xx $base;

@n[0]=1;

if ($base>6) {
  @n[0]=$base-4;
  @n[1]=2;
  @n[2]=1;
  @n[$base-4]=1
}
while (1) {
  my @o=@n;
  my %o;
  map {%o{$_}++}, @o;
  for (0..@o.end) -> $i {
    @n[$i]=%o{$i} || 0;
  }
  if (join('',@o) eq join('',@n)) {
    last;
  }
}

print join('',map {@digit[$_]}, @n),"\n";
