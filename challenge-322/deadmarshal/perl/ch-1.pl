#!/usr/bin/env perl
use strict;
use warnings;

sub string_format{
  my $str = $_[0] =~ s/-//gr;
  my ($rem,@ret) = (length($str) % $_[1]);
  $rem and push @ret,substr($str,0,$rem,'');
  push @ret,substr($str,0,$_[1],'') while(length($str) > 0);
  join '-',@ret
}

printf "%s\n", string_format('ABC-D-E-F',3);
printf "%s\n", string_format('A-BC-D-E',2);
printf "%s\n", string_format('-A-B-CD-E',4);

