#!/usr/bin/env perl 
use strict;
use warnings;
use re 'eval';

# 1) change the integer ($m) in string. For example 7 becomes 'NNNNNNN'
# 2) make a big regex. The regex depends of the number of primes to sum ($n)
# 3) use the regex to find all solutions

# example : the regex will match (NN)(NNNNN) on "NNNNNNN" : $1 == "NN" , $2 == "NNNNN" => 7=2+5

# regex pieces 
my $firstnumber='(NN+?)'; # find a number > 2 
my $isprime='(??{$+=~/^(NN+)\1+$/})'; # produce "1" if number is not prime and will fail with backtracking
my $otherbiggernumber='(\g{-2}N+?)'; #\g{-2} is the capture of the precedent number, so current number is bigger
my $storage='(?{push @sol,[map length, @{^CAPTURE}] })(?!)'; # store solution and force bactracking with '(?!)' --  https://perldoc.pl/perlvar#@%7B%5ECAPTURE%7D
#my $storage='(?{push @sol,[map { $+[$_] - $-[$_] } 1..$n]})' # @+ et @- https://perldoc.pl/perlvar#@LAST_MATCH_END https://perldoc.pl/perlvar#@LAST_MATCH_START 


#for my $input ([18,2],[19,3],[7,2],[119,3],[119,4],[119,5],[119,6],[119,7],[119,8],[119,9],[341,3],[341,4],[341,5],[341,6],map [$_,3],4..99) {
for my $input ([18,2],[19,3],[7,2],[119,8],[341,3]) {

    my $m = $input->[0];
    my $n = $input->[1];
    my $number = "N" x $m; 
    my @sol;
    my $regex =
       '^' .
       $firstnumber . $isprime .
       ( ($otherbiggernumber . $isprime) x ($n - 1)) .
       '$' .
       $storage;

    $number =~ $regex ;
    print "regex : \n" , $regex , "\n";  #
    print "$m ($n primes) = \n";
    for my $s (@sol) {
        print "\t", join ' + ',@$s;
        print "\n";
    }
    print "---\n" ;
}
