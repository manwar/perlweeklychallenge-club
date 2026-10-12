#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub word_squares{
  my ($words) = @_;
  return [] unless @$words;

  my ($n,@res,%used) = length $words->[0];
  
  my $solve;
  $solve = sub{
    my $k = @res;
    return 1 if $k == $n;
    my $prefix = join '',map{substr($res[$_],$k,1)} 0..$k-1;
    
    foreach my $i(0..$#$words){
      next if $used{$i};
      next unless substr($words->[$i],0,$k) eq $prefix;
      $used{$i} = 1;
      push @res,$words->[$i];
      return 1 if $solve->();
      pop @res;
      delete $used{$i}
    }
    0
  };

  my $found = $solve->();
  undef $solve;
  $found ? \@res : [];
}

is_deeply word_squares(['MA','AM','MY','ME']),['MA','AM'],'Example 1';

is_deeply word_squares(['SUN','USE','NET','SEE','TEN']),
  ['SUN','USE','NET'],'Example 2';

is_deeply word_squares(['BOAT','TEAL','AREA','TSAR','OGRE']),
  ['BOAT','OGRE','AREA','TEAL'],'Example 3';

is_deeply word_squares(['CARD','AREA','REAR','DART']),
  ['CARD','AREA','REAR','DART'],'Example 4';

is_deeply word_squares(['HEART','TREND','EMBER','RESIN','ABUSE']),
  ['HEART','EMBER','ABUSE','RESIN','TREND'],'Example 5';

done_testing();

