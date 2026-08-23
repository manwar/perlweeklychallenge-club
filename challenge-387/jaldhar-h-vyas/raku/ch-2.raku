#!/usr/bin/raku

sub parseNumber ($formula, $position is rw) {
	my $start = $position;

	while $position < $formula.chars && $formula.substr($position, 1) ~~ /\d/ {
        $position++ 
    }

	return $position == $start
		?? 1
		!! $formula.substr($start, $position - $start);
}

sub parseGroup ($formula, $position is rw) {
	my %atoms;

	while $position < $formula.chars && $formula.substr($position, 1) ne q{)} {
		my %group;

		if $formula.substr($position, 1) eq q{(} {
			$position++;
			%group = parseGroup($formula, $position);
			$position++;
		} else {
			my $start = $position++;
            while $position < $formula.chars &&
            $formula.substr($position, 1) ~~ /<[a..z]>/ {
			    $position++;
            }
			my $element = $formula.substr($start, $position - $start);
			%group{$element} = 1;
		}

		my $multiplier = parseNumber($formula, $position);
        for %group.keys -> $key {
		    %atoms{$key} += %group{$key} * $multiplier;
        }
	}

	return %atoms;
}

sub MAIN(
    $formula
) {
    my $position = 0;
    my %atoms = parseGroup($formula, $position);
    %atoms
        .keys
        .sort
        .map({ $_ ~ (%atoms{$_} > 1 ?? %atoms{$_} !! q{}) })
        .join
        .say;
}