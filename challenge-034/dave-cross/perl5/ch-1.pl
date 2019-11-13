#!/usr/bin/perl

use strict;
use warnings;

use feature 'say';

open my $fh, '<', '/etc/passwd' or die $!;

my @users;

while (<$fh>) {
  chomp;
  my %user;

  # Lvalue is a hash slice
  # Rvalue is a list slice
  @user{qw[user id shell]} = (split /:/)[0, 2, -1];

  push @users, \%user;
}

for (@users) {
  # Another hash slice
  printf "User: %s, Shell: %s\n", @{$_}{qw[ user shell ]};
}
