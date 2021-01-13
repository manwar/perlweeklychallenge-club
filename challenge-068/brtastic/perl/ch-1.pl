use v5.26;
use warnings;

use constant ROW => 0;
use constant COL => 1;
use constant TRIGGER_VALUE => 0;
use constant DEFAULT_VALUE => 1;

sub make_rule {
	my ($type, $value) = @_;

	return sub {
		my ($val) = @_;
		return $val->[$type] eq $value
			? TRIGGER_VALUE : DEFAULT_VALUE;
	};
}

sub zero_matrix {
	my ($matrix) = @_;
	my @rules;

	my sub apply_rules {
		my ($val) = @_;
		my $new_value = DEFAULT_VALUE;

		foreach my $rule (@rules) {
			$new_value = $rule->($val);
			last if $new_value ne DEFAULT_VALUE;
		}
		return $new_value;
	}

	my sub transform_forth {
		for my $m_ind (keys $matrix->@*) {
			for my $n_ind (keys $matrix->[$m_ind]->@*) {
				my $value = $matrix->[$m_ind][$n_ind];
				my @new_value = ($m_ind, $n_ind);
				$matrix->[$m_ind][$n_ind] = \@new_value;

				if ($value eq TRIGGER_VALUE) {
					push @rules, make_rule ROW, $new_value[ROW];
					push @rules, make_rule COL, $new_value[COL];
				}
			}
		}
	}

	my sub transform_back {
		for my $m_val ($matrix->@*) {
			for my $n_val ($m_val->@*) {
				$matrix->[$n_val->[0]][$n_val->[1]] = apply_rules($n_val);
			}
		}
	}

	transform_forth;
	transform_back;
	return $matrix;
}

use Test::More;

is_deeply zero_matrix([
	[1, 1, 1],
	[1, 1, 1],
	[1, 1, 1],
]), [
	[1, 1, 1],
	[1, 1, 1],
	[1, 1, 1],
];

is_deeply zero_matrix([
	[1, 0, 1],
	[1, 1, 1],
	[1, 1, 1],
]), [
	[0, 0, 0],
	[1, 0, 1],
	[1, 0, 1],
];

is_deeply zero_matrix([
	[1, 0, 1],
	[1, 1, 1],
	[1, 0, 1],
]), [
	[0, 0, 0],
	[1, 0, 1],
	[0, 0, 0],
];

is_deeply zero_matrix([
	[1, 1, 1, 1],
	[1, 0, 0, 1],
	[1, 0, 0, 1],
	[1, 1, 1, 1],
]), [
	[1, 0, 0, 1],
	[0, 0, 0, 0],
	[0, 0, 0, 0],
	[1, 0, 0, 1],
];

done_testing;
