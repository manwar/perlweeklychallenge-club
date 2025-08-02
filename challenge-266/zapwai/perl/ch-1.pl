use v5.38;

my $line1 = 'Mango is sweet';
my $line2 = 'Mango is sour';
proc($line1, $line2);

$line1 = 'Mango Mango';
$line2 = 'Orange';
proc($line1, $line2);

$line1 = 'Mango is Mango';
$line2 = 'Orange is Orange';
proc($line1, $line2);

sub proc($line1, $line2) {
    my @words = sort (split(" ", $line1), split(" ", $line2));
    my $match_flag = 0;
    my @ans;
    for my $i (0 .. $#words - 1) {
	if ($match_flag) {
	    if ($words[$i] ne $words[$i+1]) {
		$match_flag = 0;
	    }
	    next;
	}
	if ($words[$i] eq $words[$i+1]) {
	    $match_flag = 1;
	    next;
	}
	push @ans, $words[$i];
    }
    push @ans, $words[$#words] unless ($match_flag);
    say "Input: \$line1 = $line1; \$line2 = $line2";
    say "Output: @ans";
}
