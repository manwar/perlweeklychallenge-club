#!/usr/bin/perl

use strict;
use warnings;

use constant SPACE => ' ';
use constant SPACE_WIDTH => length(SPACE);

my $line_len = shift || 72; # Old-skool Unix

my $text = join ' ', <DATA>;

my $space_left = $line_len;

for (split /\s+/, $text) {
  if (SPACE_WIDTH + length() > $space_left) {
    print "\n$_";
    $space_left = $line_len - length();
  } else {
    print $_ . SPACE;
    $space_left -= (length() + SPACE_WIDTH);
  }
}

print "\n";

__DATA__
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis volutpat,
ipsum nec luctus dictum, velit nisi sodales dui, ut feugiat risus dolor
vel metus. Morbi ut pretium velit. Proin ultricies enim magna, at semper
odio molestie vitae. In hac habitasse platea dictumst. Fusce non sapien
bibendum ligula pellentesque volutpat in et lectus. Vestibulum ante ipsum
primis in faucibus orci luctus et ultrices posuere cubilia Curae;
Vestibulum sodales molestie dignissim.
