use v5.30;
use List::Util qw( max );
my @alphanumstr = ("perl", "2", "000", "python", "r4ku");
my @alphanumstr = ("001", "1", "000", "0001");
my @nums = map {length $_} @alphanumstr;
for my $i (0 .. $#alphanumstr) {
    if ($alphanumstr[$i] =~ /^(\d+)$/) {
	$nums[$i] = $1;
    }
}
say "Input: \@alphanumstr = @alphanumstr";
my $max = max @nums;
say "Output: $max";