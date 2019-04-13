use strict;
use warnings;
use Const::Fast;

const my $N => $ARGV[0] // 29;

$| = 1;

my @hamming = (1);
my $s2_idx  =  0;
my $s3_idx  =  0;
my $s5_idx  =  0;

print "\n", $hamming[0] if $N >= 1;

for (2 .. $N)
{
    my $next_2 = $hamming[$s2_idx] * 2;
    my $next_3 = $hamming[$s3_idx] * 3;
    my $next_5 = $hamming[$s5_idx] * 5;

    if    ($next_2 <= $next_3 && $next_2 <= $next_5)
    {
       push @hamming, $next_2;
       ++$s2_idx;
       ++$s3_idx if $next_3 == $next_2;
       ++$s5_idx if $next_5 == $next_2;
    }
    elsif ($next_3 <= $next_2 && $next_3 <= $next_5)
    {
       push @hamming, $next_3;
       ++$s3_idx;
       ++$s2_idx if $next_2 == $next_3;
       ++$s5_idx if $next_5 == $next_3;
    }
    else
    {
       push @hamming, $next_5;
       ++$s5_idx;
       ++$s2_idx if $next_2 == $next_5;
       ++$s3_idx if $next_3 == $next_5;
    }
    print ' ', $hamming[-1];
}

print "\n";
