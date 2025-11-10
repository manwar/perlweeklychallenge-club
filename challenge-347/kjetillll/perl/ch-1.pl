
sub f {
    pop() =~ /^(\d+)\w* (\w\w\w )(\d{4})/ or die;
    my $m = 1 + index('Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec ', $2) / 4;
    sprintf "$3-%02d-%02d", $m || die, $1
}

use Test::More tests => 5;
is f("1st Jan 2025"), "2025-01-01";
is f("22nd Feb 2025"), "2025-02-22";
is f("15th Apr 2025"), "2025-04-15";
is f("23rd Oct 2025"), "2025-10-23";
is f("31st Dec 2025"), "2025-12-31";
