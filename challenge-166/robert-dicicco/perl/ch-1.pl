#!perl.exe

use strict;
use warnings;
use feature qw/say/;

# AUTHOR: Robert DiCicco
# DATE: 2022-05-23
# Challenge 166 Hexadecimal Words ( Perl )

my %letters = ( 'a'=>'a','b'=>'b','c'=>'c','d'=>'d','e'=>'e','f'=>'f','o'=>0,'l'=>1,'i'=>1,'s'=>5,'t'=>7);
my $found = 0;
my $selection = $ARGV[0];

die "Length Selection Error. Must be between 2 and 8 inclusive" if ($selection < 2 or $selection > 8);

open(FH, '<', "./Words.txt") or die "Can't open Words.txt\n";

while(my $word = <FH>) {

  $word = lc($word);
  $word =~ s/^\s+|\s+$//g;                  # remove both leading and trailing spaces
  next if (length($word) != $selection);    # only look at the slected length words
  my @arr = split(//,$word);                # create array of chars

  foreach my $val (@arr){                   # if we have a character not in out list, go to next
    if(! defined($letters{$val})){
      next;
    }

    if(exists($letters{$val})){             # if its in our list, bump the found flag
      $found++;
    }
  }

  $word =~ tr/olist/01157/;                 # convert certain chars to their number representations

     if ($selection == 2) {                 # if our found char total = our selection number, print the word
        print "0x000000$word " if ($found == $selection);
    } elsif ( $selection == 3) {
        print "0x00000$word " if ($found == $selection);
    } elsif ( $selection == 4) {
        print "0x0000$word " if ($found == $selection);
    } elsif ( $selection == 5) {
        print "0x000$word " if ($found == $selection);
    }   elsif ( $selection == 6) {
        print "0x00$word " if ($found == $selection);
    } elsif ($selection == 7) {
        print "0x0$word " if ($found == $selection);
    } elsif ($selection == 8) {
        print "0x$word " if ($found == $selection);
    } else {
        # should not reach here
        ;
    }

    $found = 0;                             # reset the found flag, go another round
  }

  print "\n";
