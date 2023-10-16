#https://theweeklychallenge.org/blog/perl-weekly-challenge-237/
use strict; use warnings;

sub max(@){ my $m; !defined$m || $m<$_ and $m=$_ for @_; $m }

sub permutations(@) {
  @_ or return;
  my @i = 0..$#_;
  my @r;
  while ( push @r, [@_[@i]] ) {
    my $p = $#i || last;
    --$p || last while $i[$p-1] > $i[$p];
    push @i, reverse splice @i, my$q=$p;
    ++$q while $i[$p-1] > $i[$q];
    @i[$p-1,$q] = @i[$q,$p-1];
  }
  @r
}


sub count_greater { 0+grep$_[0][$_]>$_[1][$_],0..$#{$_[0]}}

sub max_greater { max map count_greater(\@_, $_), &permutations }

my @tests = (
  [1, 3, 5, 2, 1, 3, 1] => 4,
  [1, 2, 3, 4] => 3
);

while(@tests){
  my($input, $expected)=splice@tests,0,2;
  my $got = max_greater(@$input);
  print $got == $expected ? 'ok' : '***NOT OK';
  print "   input: @$input    expected: $expected    got: $got\n";
}

