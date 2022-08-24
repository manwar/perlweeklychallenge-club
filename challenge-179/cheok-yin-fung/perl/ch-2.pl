# The Weekly Challenge 179
# Task 2 Unicode Sparkline
use v5.30.0;
use List::Util qw/max min uniq/;
use POSIX;
binmode(STDOUT, ":utf8");

my @n = @ARGV;

exit unless defined($ARGV[1]);

my @nn = map {$_ / min(@n)} @n;

my @s_n = sort {$a <=> $b} @nn;
my $diff = max map {$s_n[$_+1]-$s_n[$_]} (0..$#s_n-1);

my $step = min( (max @nn)/8 , $diff ) ;
$step = (max @nn)/6 if $step == 0;

foreach (@nn) {
    my $h = 9600 + floor( $_ / $step + 0.5);
    $h = 9601 if $h < 9601;    #security
    $h = 9608 if $h > 9608;    #security
    print pack("U*", $h);
}
say "";
