use feature qw/say/;
use strict;

my ($bits) = @ARGV;

die "positive integers only\n" unless $bits =~ /^-?\d+\z/ && $bits > 0;

my $count = 0;
while ($count < 2 ** $bits) {
	say sprintf('%0'.$bits.'b', $count);
	$count++;
}