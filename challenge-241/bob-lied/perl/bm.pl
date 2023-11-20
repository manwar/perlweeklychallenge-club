#!/usr/bin/env perl

use v5.38;

use Benchmark qw/:all/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

my $Diff;
my $Rep = 1;

GetOptions("diff:i" => \$Diff, "repeat:i" => \$Rep, "test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

die "Usage: $0 -d DIFF m n o ..." unless defined $Diff && @ARGV > 0;

cmpthese($Rep, {
  # 'Original    ' => sub { triplet_1($Diff, @ARGV) },
    'No k loop   ' => sub { triplet_2($Diff, \@ARGV) },
    'Early k stop' => sub { triplet_3a($Diff, \@ARGV) },
    'Early j stop' => sub { triplet_3b($Diff, \@ARGV) },
    'Early exit  ' => sub { triplet_3($Diff, \@ARGV) },
    'Shift i     ' => sub { triplet_4($Diff, @ARGV) },
    'Shift i,j   ' => sub { triplet_4a($Diff, @ARGV) },
} );

sub triplet_4a($diff, @nums)
{
    use integer;
    my $count = 0;
    while ( defined(my $i = shift @nums ) )
    {
        my @rest = @nums;
        while ( defined(my $j = shift @rest) )
        {
            my $dj = $j - $i;

            # Input is sorted, so stop once the difference is too big.
            if ( $dj > $diff ) { last }
            elsif ( $dj < $diff ) { next }

            for my $k ( @rest )
            {
                my $dk = $k - $j;
                if ( $dk > $diff ) { last }
                elsif ( $dk == $diff )
                {
                    $count++;
                }
            }
        }
    }
    return $count;
}

sub triplet_4($diff, @nums)
{
    my $count = 0;
    while ( defined(my $i = shift @nums ) )
    {
        for my $j ( 0 .. ($#nums-1) )
        {
            my $dj = $nums[$j] - $i;

            # Input is sorted, so stop once the difference is too big.
            if ( $dj > $diff ) { last }
            elsif ( $dj < $diff ) { next }

            for ( my $k = ($j+1) ; $k <= $#nums ; $k++ )
            {
                my $dk = $nums[$k] - $nums[$j];
                if ( $dk > $diff ) { last }
                elsif ( $dk == $diff )
                {
                    $count++;
                }
            }
        }
    }
    return $count;
}
sub triplet_3($diff, $nums)
{
    my $count = 0;
    for ( my $i = 0 ; $i <= $nums->$#*-2; $i++ )
    {
        for ( my $j = $i+1; $j <= $nums->$#*-1; $j++ )
        {
            my $dj = $nums->[$j] - $nums->[$i];

            # Input is sorted, so stop once the difference is too big.
            if ( $dj > $diff ) { last }
            elsif ( $dj < $diff ) { next }

            for ( my $k = $j+1; $k <= $nums->$#* ; $k++ )
            {
                my $dk = $nums->[$k] - $nums->[$j];
                if ( $dk > $diff ) { last }
                elsif ( $dk == $diff )
                {
                    $count++;
                }
            }
        }
    }
    return $count;
}

sub triplet_3b($diff, $nums)
{
    my $count = 0;
    for ( my $i = 0 ; $i <= $nums->$#*-2; $i++ )
    {
        for ( my $j = $i+1; $j <= $nums->$#*-1; $j++ )
        {
            my $dj = $nums->[$j] - $nums->[$i];

            # Input is sorted, so stop once the difference is too big.
            if ( $dj > $diff ) { last }
            elsif ( $dj < $diff ) { next }

            for ( my $k = $j+1; $k <= $nums->$#* ; $k++ )
            {
                my $dk = $nums->[$k] - $nums->[$j];
                if ( $dk == $diff )
                {
                    $count++;
                }
            }
        }
    }
    return $count;
}

sub triplet_3a($diff, $nums)
{
    my $count = 0;
    for ( my $i = 0 ; $i <= $nums->$#*-2; $i++ )
    {
        for ( my $j = $i+1; $j <= $nums->$#*-1; $j++ )
        {
            next unless $nums->[$j] - $nums->[$i] == $diff;
            for ( my $k = $j+1; $k <= $nums->$#* ; $k++ )
            {
                my $dk = $nums->[$k] - $nums->[$j];
                if ( $dk - $diff ) { last }
                elsif ( $dk == $diff )
                {
                    $count++;
                }
            }
        }
    }
    return $count;
}

sub triplet_2($diff, $nums)
{
    my $count = 0;
    for ( my $i = 0 ; $i <= $nums->$#*-2; $i++ )
    {
        for ( my $j = $i+1; $j <= $nums->$#*-1; $j++ )
        {
            next unless $nums->[$j] - $nums->[$i] == $diff;
            for ( my $k = $j+1; $k <= $nums->$#* ; $k++ )
            {
                if ( $nums->[$k] - $nums->[$j] == $diff )
                {
                    $count++;
                }
            }
        }
    }
    return $count;
}

sub triplet_1($diff, @nums)
{
    my $count = 0;
    for ( my $i = 0 ; $i <= $#nums-2; $i++ )
    {
        for ( my $j = $i+1; $j <= $#nums-1; $j++ )
        {
            for ( my $k = $j+1; $k <= $#nums ; $k++ )
            {
                if (   $nums[$k] - $nums[$j] == $diff
                    && $nums[$j] - $nums[$i] == $diff )
                {
                    $count++;
                }
            }
        }
    }
    return $count;
}
