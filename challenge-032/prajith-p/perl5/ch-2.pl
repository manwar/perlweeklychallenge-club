#!/usr/bin/perl

# https://alexwlchan.net/2018/05/ascii-bar-charts

use List::Util qw<max>;
use utf8;
use feature qw<say>;

binmode STDOUT, ":utf8";

sub divmod {
     my $number = shift;
     my $divisor = shift;

     my $remainder = $number % $divisor;
     my $quotient = ($number - $remainder) / $divisor;

     return ($quotient, $remainder);
}

my $data = { apple => 3, cherry => 2, banana => 1 };

my $max_value = max(values %{$data});
my $increment = $max_value / 25;

my $longest_label_length = max map { length($_) } keys %{$data};

foreach my $label (sort { $data->{$b} <=> $data->{$a}} keys %{$data}) {
    my $count = $data->{$label};

    my ($bar_chunks, $remainder) = divmod(($count * 8 / $increment), 8);
    my $bar = '█' x $bar_chunks;
 
    if ( $remainder > 0 ) {
        $bar .= chr(ord('█') + (8 - $remainder));
    }
    $bar ||= '▏';
    my $fmt = "%-$longest_label_length" .'s ' . ' |' . "%-4d";
    say sprintf($fmt,  $label, $count) .  $bar;
}
