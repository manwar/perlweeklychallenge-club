#!/usr/bin/env perl

use strict;
use warnings;

=head1 NAME

PWC 090 Challenge 2

=head1 SYNOPSIS

  $ ch-2.pl 25 7
  The initial twos table looks like:
  2^0 = 1
  2^1 = 2
  2^2 = 4
  2^3 = 8
  2^4 = 16
  2^5 = 32
  
  Decomposition looks like:
  25-16 = 9
  9-8 = 1
  1-1 = 0
  
  The table of the second multiplicand times powers of 2 (* values will be used):
  * 1 7
  2 14
  4 28
  * 8 56
  * 16 112
  32 224
  
  The solution using Ethiopian Multiplication looks like:
  112+56+7=175

=head1 DESCRIPTION

Given two positive numbers, this script will demonstrate Ethiopian
Multiplication using the given numbers.

=head1 AUTHORS

Joel Crosswhite E<lt>joel.crosswhite@ix.netcom.comE<gt>

=cut

my ($first_input, $second_input) = validate_inputs();

my @twos_table = build_twos_table($first_input);
print_twos_table(\@twos_table);

my @decomposition_places =
    build_decomposition_table($first_input, \@twos_table);
print_decomposition_table($first_input, \@twos_table, \@decomposition_places);

my @second_twos_table = ($second_input);
map { push(@second_twos_table, $second_twos_table[-1] * 2) }
    (2..scalar(@twos_table));
print_second_twos_table(\@second_twos_table, \@decomposition_places);

print_solution(\@decomposition_places, \@second_twos_table);

exit 0;

sub validate_inputs {
    my $first_input = $ARGV[0];
    my $second_input = $ARGV[1];
    if ((!defined($first_input) || $first_input !~ m/^[1-9]\d*$/)
        || (!defined($second_input) || $second_input !~ m/^[1-9]\d*$/)) {
        print "Usage: ch-2.pl <positive integer> <positive integer>\n";
        exit 1;
    }
        
    if ($first_input < $second_input) {
        my $tmp = $first_input;
        $first_input = $second_input;
        $second_input = $tmp;
    }

    return ($first_input, $second_input);
}

sub build_twos_table {
    my ($first_input) = @_;
    my @table = (1);
    while ($first_input > $table[-1]) {
        push(@table, 2 * $table[-1]);
    }
    splice(@table, -1);
    return @table;
}

sub print_twos_table {
    my ($twos_table) = @_;
    print "The initial twos table looks like:\n";
    for (my $i = 0; $i < scalar(@{$twos_table}); $i++) {
        printf("2^%d = %d\n", $i, $twos_table->[$i]);
    }
    print "\n";
}

sub build_decomposition_table{
    my ($first_input, $twos_table) = @_;
    my @table;
    for (my $i = scalar(@{$twos_table}) - 1; $i >= 0; $i--) {
        next if $first_input < $twos_table->[$i];
        push(@table, $i);
        $first_input -= $twos_table->[$i];
    }
    return @table;
}

sub print_decomposition_table{
    my ($first_input, $twos_table, $decomposition_places) = @_;
    print "Decomposition looks like:\n";
    foreach my $value (@{$decomposition_places}) {
        printf("%d-%d = %d\n", $first_input, $twos_table->[$value],
            ($first_input - $twos_table->[$value]));
        $first_input -= $twos_table->[$value];
    }
    print "\n";
}

sub print_second_twos_table{
    my ($second_table, $decomposition_places) = @_;
    print "The table of the second multiplicand times powers of 2 (* values "
        . "will be used):\n";
    for (my $i = 0; $i < scalar(@{$second_table}); $i++) {
        print '* ' if (grep( /^$i/, @{$decomposition_places}));
        printf("%d %d\n", 2 ** $i, $second_table->[$i]);
    }
    print "\n";
}

sub print_solution{
    my ($decomposition_places, $twos_table) = @_;
    print "The solution using Ethiopian Multiplication looks like:\n";
    my $solution;
    my $output = '';
    foreach my $index (@{$decomposition_places}) {
        $output = sprintf($output . '%d+', $twos_table->[$index]);
        $solution += $twos_table->[$index];
    }
    chop($output);
    print $output . '=' . $solution . "\n";
}
