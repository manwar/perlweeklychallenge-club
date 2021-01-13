#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
It is thought that the following sequence will always reach 1:
    $n = $n / 2 when $n is even
    $n = 3*$n + 1 when $n is odd
For example, if we start at 23, we get the following sequence:
23 → 70 → 35 → 106 → 53 → 160 → 80 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
Write a function that finds the Collatz sequence for any positive integer. Notice how the sequence itself may go far above the original starting number.
Extra Credit

Have your script calculate the sequence length for all starting numbers up to 1000000 (1e6), and output the starting number and sequence length for the longest 20 sequences.
=cut

use List::Util qw(max min);
use Time::HiRes qw(time);

my $start = time;
my %collatz_mem;

%collatz_mem = ( 4 => 2, 2 => 1); # ( 5 => 16, 16 => 8, 8 => 4, 4 => 2, 2 => 1, );



sub collatz
{
     my $n = $_[0];
     my @seq;
     while ( $n != 1 )
     {
          if ( exists $collatz_mem{$n})
          {
               my $key = $n;
               while ( $key > 1)
               {
                    push @seq, $key;


                    $key = $collatz_mem{$key};
               }
               push @seq, 1;

               return @seq;
          }
          else
          {

               my $old_n = $n;
               push @seq, $n;
               
               if ( 0 == $n % 2 )
               {
                    $n = $n / 2;
               }
               else

               {
                    $n = 3 * $n + 1;
               }
               $collatz_mem{$old_n} = $n;
          }
     }
}



my $EDGE = 20;
my %longest;
my $PRINT_SEQUENCE = 0;

for my $N ( 1 .. 1_000_000)
{
     my @sequence = collatz($N);

     my $length = scalar @sequence;

     my $max = max keys %longest || 1;

     if ( $length > $max )
     {
          $longest{$length} = [@sequence];
     }

     my $how_many = scalar keys %longest;

     if ( $how_many > $EDGE )
     {
          my $min = min keys %longest;
          delete $longest{ $min };
     }
}



for my $n ( sort {$b <=> $a} keys %longest )
{
     print ${$longest{$n}}[0], ': ', scalar @{$longest{$n}}, $/;
     print join(' -> ', @{$longest{$n}}), $/ if 1 == $PRINT_SEQUENCE;
}

print "Used time: ", time() - $start, $/;



__END__
837799: 525
626331: 509
939497: 507
704623: 504
927003: 476
511935: 470
796095: 468
970599: 458
546681: 452
820023: 450
410011: 449
615017: 447
938143: 445
461263: 444
230631: 443
691895: 442
345947: 441
997823: 440
518921: 439
792735: 437
Used time: 58.2856910228729