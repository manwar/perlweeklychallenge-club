use strict;
use warnings;
use feature "say";

my @input_tests = ( [ "littleit", "lit"], ["london", "lon"], ["aaaa", "aa"]);
my $count;
for my $in (@input_tests) {
    $count = 0;
    search_substr (@$in);
    say "@$in: $count";
}
sub search_substr {
    my ($in, $searched) = @_;
    my $start = substr $searched, 0, 1;
    my $index = 0;
    while (1) {
        $index = index $in, $start, $index;
        return if $index < 0;
        $index++;
        ++$count and next  if length $searched == 1;
        search_substr (substr($in, $index), substr($searched, 1));
    }
}
