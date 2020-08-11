#!/usr/bin/env perl
use warnings;
use strict;

use DateTime;
use Term::ANSIScreen qw/cls/;
my $console = Term::ANSIScreen->new;

# Problem:
# Write a script to display Digital Clock. Feel free to be as creative
# as you can when displaying digits. We expect bare minimum something
# like “14:10:11”.

while (1) {
  # Clear the screen
  cls();
  # Go to top left corner
  $console->Cursor(0, 0);
  # Print current time to seconds
  print DateTime->now->hms . "\n";
  # And sleep for 1 second.
  sleep 1;
}
