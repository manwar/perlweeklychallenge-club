#!perl
use strict;
use warnings FATAL => qw(all);

# Challenge:
# You are given two positive numbers $N and $S.
# Write a script to list all positive numbers having exactly $N digits where sum of all digits equals to $S.
# Example

# Input:
    # $N = 2
    # $S = 4

# Output:
    # 13, 22, 31, 40




use Getopt::Long;
use Pod::Usage;
use List::Util qw(first sum);




my $message_text = <<"OUT";
Usage: script flags string.
Flags: 
--d digits in the number.
--s sum of all digits in the number.
--h read this message
OUT




my %opts = (digits => 2, sum_of_digits => 4,);


GetOptions( \%opts, 
     'digits|d=i', 
     'sum_of_digits|s=i',
     'help|h'

) or die pod2usage($message_text);

die pod2usage($message_text) unless $opts{digits} and $opts{sum_of_digits};

my $min = '1' . '0' x ($opts{digits} - 1);
my $max = '9' . '9' x ($opts{digits} - 1);

my $num = $min;
while ($num  <= $max )
{
     last if substr($num, 0, 1) > $opts{sum_of_digits};
     my @digits = split(//,$num);

     $num++ and next if first { $_ > $opts{sum_of_digits} } @digits;
     print $num, $/ if sum(@digits) == $opts{sum_of_digits};
     $num++
}