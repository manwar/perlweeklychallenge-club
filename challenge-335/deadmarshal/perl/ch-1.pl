#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;
use List::Util qw(min);
use List::MoreUtils qw(frequency);

sub common_characters{
  my @f = map{{frequency split ''}} @{$_[0]};
  map{my $l = $_;
      ($l) x min map{$_->{$l} // 0} @f
    } 'a'..'z'
}

print show common_characters(["bella","label","roller"]);
print show common_characters(["cool","lock","cook"]);
print show common_characters(["hello","world","pole"]);
print show common_characters(["abc","def","ghi"]);
print show common_characters(["aab","aac","aaa"]);

