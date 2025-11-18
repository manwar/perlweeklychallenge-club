use v5.38;
use List::Util qw(min);

sub proc($src, $tar) {
    say "Input: \$source = $src,\t\$target = $tar";
    my ($srchr, $srcmin) = split ":", $src;
    my ($tarhr, $tarmin) = split ":", $tar;
    my $diff = (60*$tarhr + $tarmin) - (60*$srchr + $srcmin);
    $diff = min(abs($diff), 1440-abs($diff));
    my @l = reverse (1, 5, 15, 60);
    my $steps = 0;
    for my $i (0 .. $#l) {
	my $div = $l[$i];
	if ($diff >= $div) {
	    my $K = int($diff / $div);
	    $steps += $K;
	    $diff -= $K*$div;
	}
    }
    say "Output: $steps";
}

my $src = "02:30";
my $tar = "02:45";
proc($src, $tar);

$src = "11:55";
$tar = "12:15";
    
proc($src, $tar);

$src = "09:00";
$tar = "13:00";

proc($src, $tar);

$src = "23:45";
$tar = "00:30";

proc($src, $tar);

$src = "14:20";
$tar = "15:25";

proc($src, $tar);
