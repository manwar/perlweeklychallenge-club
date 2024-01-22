#!usr/bin/env raku

sub unique-sum-zero($n)
{
  my @ret;
  for 1..$n/2 -> $i {
    @ret.push: $i,-$i
  }
  @ret.push(0) unless $n %% 2;
  @ret
}

say unique-sum-zero(5);
say unique-sum-zero(3);
say unique-sum-zero(1);
