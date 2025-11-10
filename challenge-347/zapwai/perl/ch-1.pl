use v5.38;

my @DAYS = qw(1st 2nd 3rd 4th 5th 6th 7th 8th 9th 10th 11th
	      12th 13th 14th 15th 16th 17th 18th 19th 20th 21st
	      22nd 23rd 24th 25th 26th 27th 28th 29th 30th 31st );
my @MONTHS = qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );

sub dodi($n) {
    if ($n < 10) {
	return "0$n";
    } else {
	return $n;
    }
}

sub proc($str) {
    say "Input: \$str = $str";
    my ($day, $mon, $yr) = split ' ', $str;
    my ($day_index, $mon_index);
    for my $i (0 .. $#DAYS) {
	$day_index = $i if ($DAYS[$i] eq $day);
    }

    for my $j (0 .. $#MONTHS) {
	$mon_index = $j if ($MONTHS[$j] eq $mon);
    }
    my $output = "$yr-".dodi($mon_index+1)."-".dodi($day_index+1);
    say "Output: $output";
}

my $str = "1st Jan 2025";
proc($str);
$str = "22nd Feb 2025";
proc($str);
$str = "15th Apr 2025";
proc($str);
$str = "23rd Oct 2025";
proc($str);
$str = "31st Dec 2025";
proc($str);
