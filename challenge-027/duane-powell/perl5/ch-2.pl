#!/usr/bin/perl
use Modern::Perl;

# Write a script that allows you to capture/display historical data.

my $h = Historical->new();
sleep 1;
$h->set(1);
$h->get_history();
sleep 1;
$h->set(1);
sleep 1;
$h->set(11);
sleep 1;
$h->set(111);
sleep 1;
$h->set(11);
sleep 1;
$h->set(1);
$h->get_history();
exit;

package Historical;
sub new {
	my $class = shift;
	my $now = time;
	my $self = {
		x => 0,
		x_history => {$now => 0},
	};
	return bless $self, $class;
}
sub set {
	my $self = shift;
	my $next = shift;
	if ($self->{x} != $next) {
		$self->{x} = $next;
		my $now = time;
		$self->{x_history}{$now} = $next;
	}
}
sub get_history {
	my $self = shift;
	say "History of x is:";
	foreach (sort (keys %{ $self->{x_history} })) {
		say "$_ => ", $self->{x_history}{$_};
	}
}

__END__

./ch-2.pl 
History of x is:
1569256589 => 0
1569256590 => 1
History of x is:
1569256589 => 0
1569256590 => 1
1569256592 => 11
1569256593 => 111
1569256594 => 11
1569256595 => 1

