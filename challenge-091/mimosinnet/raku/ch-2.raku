#!/usr/bin/env raku

my @n1 = 1,2,1,2; 
my @n2 = 2,1,1,0,2;
my @n3 = 2,2,1,2,0,5,2;

for ( @n1, @n2, @n3 ) -> @N {
  my $output = 0;
  my $result = 'It does not reach';
  say 'Input : @N = ' ~ @N;
  my $initial = @N.shift;
  while @N {
    $result = 'It does not reach';
    if $initial eq @N.elems { 
      $output = 1;
      $result = 'It jumps to the last index';
      last; 
    } 
    if $initial gt @N.elems {
      $output = 1;
      $result = 'It jumps over the last index';
      last 
    } 
    my @elems = @N.splice(0,$initial);
    $initial = pop @elems;
    last if $initial eq 0;
  }
  say "Output: $output ($result) \n";
}
