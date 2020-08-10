#!/usr/bin/perl 
use 5.28.1;
use warnings;
use Data::Dumper;
use Scalar::Util "looks_like_number";

#You are given a positive integer $N (< 11).
#
#Write a script to print number of trailing zeroes in $N!.


#get value
#test for in range

#calculate factorial
#gen num trailing 0's
#say num
#


say int numberoftrailingzeroesfrom (afactorialof (anumberoftenorless (frominput())));



sub frominput{
   my $input =shift @ARGV;
   die "You forgot to give me a value, dummy!" unless defined $input;
   $input
}

sub anumberoftenorless{
   my $value = pop;
   die "\"$value\" isn't a number, dimbulb!" unless looks_like_number $value;
   die "$value needs to be equal to or less than 10, you dolt." if $value > 10;
   $value
}

sub afactorialof{
   my $value = pop;
   # 0! = 1, it turns out, so this logic works fine.
   my $factorialized=1;
   $factorialized *= $_ for 2 .. $value;
   $factorialized
}

sub numberoftrailingzeroesfrom{
   my $number = pop;
   print "$number has how many trailing zeroes?   ";
   $number =~ /(0*$)/;
   split '', $1
}



