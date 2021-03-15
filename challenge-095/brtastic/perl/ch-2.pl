use v5.24;
use warnings;

package Stack {

	use Scalar::Util qw(refaddr blessed);

	my %vals;

	my sub getval {
		my ($node) = @_;
		return defined $$node ? $vals{refaddr $node} : undef;
	}

	my sub rmval {
		my ($node) = @_;
		return delete $vals{refaddr $node}
			if defined $$node;
		return undef;
	}

	my sub addval {
		my ($node, $value) = @_;
		return $vals{refaddr $node} = $value
			if defined $$node;
		return undef;
	}

	sub new {
		my ($self) = @_;
		my $package = blessed $self || $self;
		my $last = blessed $self ? $self : undef;

		return bless \$last, $package;
	}

	sub push {
		my ($self, $value) = @_;

		my $new = $self->new;
		addval($new, $value);
		$_[0] = $new;
		return;
	}

	sub pop {
		my ($self) = @_;

		if (defined $$self) {
			my $value = rmval($self);
			$_[0] = $$self;

			return $value;
		}

		return undef;
	}

	sub min {
		my ($self) = @_;

		my $min = undef;
		my $node = $self;
		while ($$node) {
			my $value = getval($node);
			$min = ($min // $value) < $value ? $min : $value;
			$node = $$node;
		}

		return $min;
	}

	sub top {
		my ($self) = @_;

		return getval($self);
	}
}

use Test::More;

my $stack = Stack->new;

$stack->push(2);
$stack->push(-1);
$stack->push(0);

is $stack->pop, 0;
is $stack->top, -1;

$stack->push(0);
is $stack->min, -1;

is $stack->pop, 0;
is $stack->pop, -1;
is $stack->top, 2;
is $stack->pop, 2;
is $stack->pop, undef;
is $stack->top, undef;
is $stack->min, undef;

done_testing;
