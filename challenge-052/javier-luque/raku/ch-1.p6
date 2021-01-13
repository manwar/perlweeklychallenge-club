#!/usr/bin/perl
# Test: ./ch-6.p6

multi MAIN { MAIN(100, 999) };
multi MAIN(Int $start, Int $end) {
    die "End smaller than start" if $end < $start;
    .say for ($start .. $end).grep({is-stepping($_)});
}

sub is-stepping($num) {
    my $is_stepping = True;
    my $prev_digit;

    for ($num.comb) -> $i {
    	$is_stepping = False
    		if ($prev_digit.defined &&
    		    $prev_digit != $i + 1 &&
    		    $prev_digit != $i - 1 );

    	$prev_digit = $i;
    }

    return $is_stepping;
}
