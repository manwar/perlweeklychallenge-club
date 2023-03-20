package main;

use strict;
use warnings;


sub minimum_index_sums
{
	my($array_ref_1, $array_ref_2) = @_;

	my %in_both = build_hash_with_strings_in_both_arrays($array_ref_1, $array_ref_2);
	my %index_sums = ();
	my @minimum_index_sums;

	if(scalar(keys %in_both)) {
		my %index_sums = build_index_sums(\%in_both);
		my %minimum_index_sums;
		my $current_minimum;

		foreach my $string1 ( sort { $a cmp $b } keys %index_sums ) {
			my $sum = $index_sums{$string1};

			if(!$current_minimum) {
				$current_minimum = $sum;
			}

			foreach my $string2 ( sort { $a cmp $b } keys %index_sums) {
				my $sum2 = $index_sums{$string2};

				if($sum2 <= $current_minimum) {
					$minimum_index_sums{$string2} = $sum2;
					$current_minimum = $sum2;
				} else {
					delete $minimum_index_sums{$string2};
				}
			}
		}

		@minimum_index_sums =  keys %minimum_index_sums;
	}

	return @minimum_index_sums;

}

sub build_hash_with_strings_in_both_arrays
{
	my($array_ref_1, $array_ref_2) = @_;

        my %in_both = ();

        for (my $i = 0; $i < scalar( @{$array_ref_1}); $i++)  {
                my $first_element = $array_ref_1->[$i];

                for(my $j = 0; $j < scalar( @{$array_ref_2} ); $j++) {
                        my $second_element = $array_ref_2->[$j];

                        if($first_element eq $second_element) {
                                if(!exists $in_both{$first_element}) {
                                        $in_both{$first_element} = {
                                                'indexes' => []
                                        };
                                }

                                push(@{$in_both{$first_element}->{'indexes'}}, $i);
                                push(@{$in_both{$first_element}->{'indexes'}}, $j);
                        }
                }
        }

        return %in_both;
}


sub build_index_sums
{
        my($in_both_href) = @_;

        my %in_both = %{$in_both_href};

        my %index_sums;

        foreach my $string ( keys %in_both ) {
                my $indexes = $in_both{$string}->{'indexes'};
                my $index_sum = 0;
                map { $index_sum += $_ } @{$indexes};
                $index_sums{$string} = $index_sum;
        }
        return %index_sums;
}


print "(" , join(",", map { '"' . $_ . '"' } minimum_index_sums(["Perl", "Raku", "Love"], ["Raku", "Perl", "Hate"]) ) . ")\n";
print "(" . join(",", map { '"' . $_ . '"' } minimum_index_sums(["A", "B", "C"], ["D", "E", "F"]) ) . ")\n";
print "(" . join(",", map { '"' . $_ . '"' } minimum_index_sums(["A", "B", "C"], ["C", "A", "B"]) ) . ")\n";




#minimum_index_sum(["A", "B", "C"], ["D", "E", "F"]);
#minimum_index_sum(["B", "B", "C"], ["C", "A", "B"]);


1;
