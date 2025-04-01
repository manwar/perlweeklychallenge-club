#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub find_third{
  my ($s,$first,$second) = @_;
  my (@words,@ret) = split ' ',$s;
  foreach my $i(0..$#words-1){
    push @ret,$words[$i+2] =~ /\W$/ ? substr($words[$i+2],0,-1) : $words[$i+2]
      if ($words[$i] eq $first) && ($words[$i+1] eq $second)
  }
  @ret
}

print show find_third('Perl is a my favourite language but Python is my favourite too.',
		      'my',
		      'favourite');
print show find_third('Barbie is a beautiful doll also also a beautiful princess.',
		      'a',
		      'beautiful');
print show find_third('we will we will rock you rock you.','we','will');

