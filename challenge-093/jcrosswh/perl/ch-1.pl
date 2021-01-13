#!/usr/bin/env perl

use strict;
use warnings;

=head1 NAME

PWC 093 Challenge 1

=head1 SYNOPSIS

  $ ch-1.pl (1,1),(2,2),(3,3),(4,3),(4,4)
  4

=head1 DESCRIPTION

Given a set of coordinates @N, this script will count maximum points on a
straight line when given coordinates plotted on 2-d plane.

=head1 SOLUTION

This solution works by taking the following steps:

=over

=item *
determine all lines that exist given all points

=item *
for each line, count number of points that exist on that line

=item *
find largest count

=back

For the first point, 'determine all lines that exist given all points', this
solution simply goes through all permutations of all points and figures out the
lines in the format of 'y = mx + b'.  This does involve a nested loop, so the
answer does become O(n^2) due to this, but....  A hash keyed on (m,b) is
created, pointing to an array that stores each point that lies on that line.

Then, pulling out all of the arrays that are stored within the hash, each array
is uniqued for the coordinates and the largest array by entries is printed.

=head1 AUTHORS

Joel Crosswhite E<lt>joel.crosswhite@ix.netcom.comE<gt>

=cut

my $input = $ARGV[0];
my $valid_number = qr/-?\d+(\.\d)?\d*/;
my $valid_coordinate = qr/\($valid_number\,$valid_number\)/;
if (!defined($input) || $input !~ m/^($valid_coordinate,)+$valid_coordinate$/) {
    print "Usage: ch-1.pl (#,#),(#,#),..(#,#)\n";
    print "At least two points required.\n";
    exit 1;
}

my @N = parse_input($input);

my $lines = get_all_lines(\@N);

print get_max_number_of_coordinates($lines) . "\n";
exit 0;

sub parse_input {
    my ($input) = @_;
    
    my @retval = ();
    my $coordinate;
    my $idx = 0;
    foreach my $point (split(/,/, $input)) {
        if ($idx++ % 2 == 0) {
            push(@retval, []);
            $coordinate = $retval[-1];
            $coordinate->[0] = substr($point, 1, length($point));
        } else {
            $coordinate->[1] = substr($point, 0, length($point) - 1);
        }
    }
    return @retval;
}

sub get_all_lines {
    my ($coordinates) = @_;

    my %lines;
    for (my $i = 0; $i < scalar(@{$coordinates}) - 1; $i++) {
        for (my $j = $i + 1; $j < scalar(@{$coordinates}); $j++) {
            
            my $m_and_b = get_m_and_b_for_line($coordinates->[$i],
                $coordinates->[$j]);
            push(@{$lines{$m_and_b->{m} . ',' . $m_and_b->{b}}},
                $coordinates->[$i]);
            push(@{$lines{$m_and_b->{m} . ',' . $m_and_b->{b}}},
                $coordinates->[$j]);
        }
    }
    return \%lines;
}

sub get_m_and_b_for_line {
    my ($first_cordinate, $second_cordinate) = @_;
    
    my $m = ($second_cordinate->[0] - $first_cordinate->[0]) != 0
        ? ($second_cordinate->[1] - $first_cordinate->[1]) /
            ($second_cordinate->[0] - $first_cordinate->[0])
        : '*';
    my $b = $m ne '*'
        ? (-1 * $first_cordinate->[0] * $m) + $first_cordinate->[1]
        : $first_cordinate->[0];
    return {'m' => $m, 'b' => $b};
}

sub get_max_number_of_coordinates {
    my ($lines) = @_;
    
    my $max = 0;
    foreach my $key (keys(%{$lines})) {
        # taken from https://perlmaven.com/unique-values-in-an-array-in-perl,
        # 'Home made uniq'
        my @unique = do { my %seen; grep { !$seen{$_}++ } @{$lines->{$key}} };
        $max = $max < scalar(@unique) ? scalar(@unique) : $max;
    }
    return $max;
}