#!/usr/bin/perl
# Test: ./ch-2.pl
use Modern::Perl;
use Test::More;

is (powers(9),   '3^2',      'Power: 9');
is (powers(16),  '2^4, 4^2', 'Power: 16');
is (powers(45),  '0',        'Power: 45');
done_testing();

sub powers {
    my ($N) = @_;
    my @answers;

    for my $i (2 .. $N) {
    	for my $j (2 .. $N) {
    		if ($i ** $j > $N) {
    			last;
    		} elsif ($i ** $j == $N) {
    			push @answers, $i . '^' . $j;
    		}
    	}
    }

    return scalar(@answers) ?
    	join ', ', @answers : 0;
}
