use v5.38;
use List::Util qw(sum);

sub proc(@scores) {
    say "Input: @scores";
    my @s;
    my $si = 0;
    for my $i (0 .. $#scores) {
	if ($scores[$i] eq "C") {
	    pop @s;
	    $si--;
	} elsif ($scores[$i] eq "D") {
	    push @s, 2*$s[$si-1];
	    $si++;
	} elsif ($scores[$i] eq "+") {
	    my $val = $s[$si-1] + $s[$si-2];
	    push @s, $val;
	    $si++;
	} else {
	    push @s, $scores[$i];
	    $si++;
	}
    }
    say "Output: " . sum(@s);
}

my @scores = ("5","2","C","D","+");
proc(@scores);
@scores = ("5","-2","4","C","D","9","+","+");
proc(@scores);
@scores = ("7","D","D","C","+","3");
proc(@scores);
@scores = ("-5","-10","+","D","C","+");
proc(@scores);
@scores = ("3","6","+","D","C","8","+","D","-2","C","+");
proc(@scores);
