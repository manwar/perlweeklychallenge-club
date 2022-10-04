
use strict;
use warnings;

use Test::YAFT;
use YAML::Syck qw[ LoadFile ];

act { [ challenge_185_2 (@{ $_[0] }) ] } 'input';

my $plan = LoadFile "./ch-2.yaml";
for my $message (sort keys %$plan) {
	it $message
		=> with_input => $plan->{$message}{input},
		=> expect     => $plan->{$message}{expect},
	;
}

had_no_warnings;
done_testing;

