use feature qw( say signatures );
sub proc(@operations) {
    say "Input: \@operations = @operations";
    my $x = 0;
    foreach (@operations) {
	if (/\+/) {
	    $x++;
	} else {
	    $x--;
	}
    }
    say "Output: $x"
}

my @operations = ("--x", "x++", "x++");
proc(@operations);
@operations = ("x++", "++x", "x++");
proc(@operations);
@operations = ("x++", "++x", "--x", "x--");
proc(@operations);
