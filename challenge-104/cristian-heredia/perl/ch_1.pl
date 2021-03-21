=begin

TASK #1 › FUSC Sequence
Submitted by: Mohammad S Anwar
Write a script to generate first 50 members of FUSC Sequence. Please refer to OEIS for more information.

The sequence defined as below:

    fusc(0) = 0
    fusc(1) = 1
    for n > 1:
    when n is even: fusc(n) = fusc(n / 2),
    when n is odd: fusc(n) = fusc((n-1)/2) + fusc((n+1)/2)

=end
=cut

use strict;
use warnings;
use Data::Dumper;

#Create hash: key (numbers 0-max), value (result fusc)
my %fusc = (0, 0, 1, 1);
my $n = 2;
my $max = 50;
my $result = '';

sequenceFusc();
printSequence();

sub sequenceFusc {
    
    while ($n <= $max) {
       #if is even:
       if ($n % 2 == 0) {
           $fusc{$n} = $fusc{$n/2};
       }
       else {
           $fusc{$n} = $fusc{($n-1)/2} + $fusc{($n+1)/2};
       }
       $n++;
    }
}

sub printSequence {
    $n = 0;
    while ($n <= $max) {
        $result = $result."$fusc{$n}, ";
        $n++;
    }
    $result =~ s/,\s+$//;
    print "$result\n";
}
