#! /usr/bin/env rakudo
sub MAIN($fname, $first_line, $last_line) {
	my $fh = open $fname, :chomp(False) or die($fh);
	$fh.lines($first_line - 1).eager;
	my $n = $last_line - ($first_line - 1);
	for ($fh.lines($n)) { .print }
}
