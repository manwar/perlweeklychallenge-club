use strict;
use warnings;
use feature "say";

my ($n, $k) = @ARGV;
my $err_msg = "Please supply two integer parameters freater than 0\n";
die $err_msg unless $n and $k;
die $err_msg if $n !~ /^\d{1,2}$/ or $k !~ /^\d+$/;
my @start = 1..$n;
permute("", @start);

sub permute {
    my ($str, @vals) = @_;
    if (scalar @vals == 0) {
        say $str and exit unless --$k;
        return;
    }
    permute("$str " . $vals[$_], @vals[0..$_-1], @vals[$_+1..$#vals]) for 0..$#vals;
}
