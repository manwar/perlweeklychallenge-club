#!/usr/bin/perl -w
use strict;
use 5.010;
use Math::Prime::Util  qw(:all);
my @start = ();
my @start2 = ();
my @start3 = ();
my @factors = ();
 @start = (10..$ARGV[0]);
print "You entered $ARGV[0]\n"; # Shown at the end as well
 @start2 = grep /\b[1379]\d*[1379]$/, @start;
@start3 = grep {$_  if is_prime($_)} @start2;


foreach (@start3){
    print "$_\n" if  is_prime($_);
  my $rev = reverse $_;
#print"Reverse of $_ is $rev also prime.\n" if is_prime($rev);
   
  @factors = factor($rev);
   print"Reverse of $_ is $rev has factors @factors .\n" unless is_prime($rev);

}
print "The range requested was  10 to $ARGV[0].\n";
