#!/usr/bin/perl

# Challenge 025
#
# Generate a longest sequence of the following "English Pokemon" names where
# each name starts with the last letter of previous name.

use Modern::Perl;

my @names = qw( audino bagon baltoy banette bidoof braviary bronzor carracosta
                charmeleon cresselia croagunk darmanitan deino emboar emolga
                exeggcute gabite girafarig gulpin haxorus heatmor heatran
                ivysaur jellicent jumpluff kangaskhan kricketune landorus
                ledyba loudred lumineon lunatone machamp magnezone mamoswine
                nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena
                porygon2 porygonz registeel relicanth remoraid rufflet sableye
                scolipede scrafty seaking sealeo silcoon simisear snivy snorlax
                spoink starly tirtouga trapinch treecko tyrogue vigoroth
                vulpix wailord wartortle whismur wingull yamask
            );

say join(" ", find_longest_sequence(@names));

sub find_longest_sequence1 {
    my($longest_path, $current_path, @pending) = @_;
#say "(@$current_path) (@pending)";

	my $found_name = 0;
	for my $i (0 .. $#pending) {
		if (@$current_path == 0 ||
            substr($current_path->[-1], -1, 1) eq substr($pending[$i], 0, 1)) {
			$found_name = 1;
			
			find_longest_sequence1($longest_path,
			   [ @$current_path, $pending[$i] ],
			   ( @pending[0..$i-1], @pending[$i+1..$#pending] ) );
		}
	}
	
	if (!$found_name) {
        if (@$current_path > @$longest_path) {
            @$longest_path = @$current_path;
        }
	}
}

sub find_longest_sequence {
    my(@words) = @_;
    my @longest_path;
    find_longest_sequence1(\@longest_path, [], @names);
    return @longest_path;
}
