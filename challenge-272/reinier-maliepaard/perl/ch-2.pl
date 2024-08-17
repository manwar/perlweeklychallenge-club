#!/usr/bin/perl
use strict;
use warnings;
use Benchmark qw(:all);

=begin
  Here is my solution for TASK #2, along with alternatives from
  Niels van Dijke and James Curtis-Smith. I shared the benchmark results,
  which show some variability when run multiple times. Nonetheless, James's
  solution is the fastest.
=cut

# Reinier Maliepaard: function to calculate total sum using split and for
sub ascii_differences_sum_split_1 {
    my @chars = split(//, $_[0]);
    my $total_sum = 0;

    for my $i (0 .. $#chars - 1) {
        $total_sum += abs(ord($chars[$i]) - ord($chars[$i + 1]));
    }

    return($total_sum);
}

# James Curtis-Smith: function to calculate total sum using split and for
sub ascii_differences_sum_split_2 {
    my ($t, @l) = (0, split //, $_[0]);

    my $f = ord shift @l;

    ($t += abs($f - ord)), $f=ord for @l;

    $t;
}

# Niels van Dijke: function to calculate total sum using sum0 and slide
use List::Util qw(sum0);
use List::MoreUtils qw(slide);

sub ascii_differences_sum_slide {
  sum0 slide {abs(ord($b) - ord($a))} split '',$_[0]
}

# A fanciful creation by fans, combining various Elvish elements from Tolkien's work.
my $input_string = "Aearenuialinorosinaiantirnoitisirsiensinoit";

# Benchmark all three methods
timethese(1000000, {
    'Using split_1' => sub { ascii_differences_sum_split_1($input_string) },
    'Using split_2' => sub { ascii_differences_sum_split_2($input_string) },
    'Using slide'   => sub { ascii_differences_sum_slide($input_string) },
});

=begin
Results:
  Benchmark: timing 1000000 iterations of Using slide, Using split_1, Using split_2...
  Using slide:   7 wallclock secs ( 6.55 usr +  0.00 sys =  6.55 CPU) @ 152671.76/s (n=1000000)
  Using split_1: 7 wallclock secs ( 6.87 usr +  0.00 sys =  6.87 CPU) @ 145560.41/s (n=1000000)
  Using split_2: 6 wallclock secs ( 5.76 usr +  0.00 sys =  5.76 CPU) @ 173611.11/s (n=1000000)
=cut
