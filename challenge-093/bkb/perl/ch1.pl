#!/home/ben/software/install/bin/perl
use warnings;
use strict;

use JSON::Parse 'json_file_to_perl';
use JSON::Create 'create_json';
use List::Util 'max';

for my $file (@ARGV) {
    my $p = json_file_to_perl ($file);
    my $max = find_col ($p);
    print create_json ({max => $max}, sort => 1, indent => 1);
}

sub find_col
{
    my ($p) = @_;
    my @count;
    my $n = scalar (@$p);
    for my $i (0..$n-1) {
	my $start = $p->[$i];
	for my $j ($i+1..$n-1) {
	    my $end = $p->[$j];
	    my $c = 2;
	    for my $k ($j+1..$n-1) {
		my $pk = $p->[$k];
		if (collinear ($start, $end, $pk)) {
		    $c++;
		}
	    }
	    push @count, $c;
	}
    }
    return max @count;
}

sub collinear
{
    my ($a, $b, $c) = @_;
    my $d = prod ($a, $b) + prod ($b, $c) + prod ($c, $a);
    return $d == 0;
}

sub prod
{
    my ($a, $b) = @_;
    return $a->{x} * $b->{y} - $a->{y} * $b->{x};
}
