#!/usr/bin/perl
use strict;
use warnings;
#-------------------------------------------

sub uncommon_word {

    my($s1, $s2) = @_;

    my %freq;
    my @result;

    $freq{$_}++ foreach(split(/ /, $s1));
    $freq{$_}++ foreach(split(/ /, $s2));

    foreach my $k (keys(%freq)) {
      push(@result, "'$k'") if($freq{$k} == 1);
    }
    print("(", join(", ", @result),")", "\n");
}

my ($s1, $s2);

# Example 1
$s1 = "Mango is sweet";
$s2 = "Mango is sour";
uncommon_word($s1, $s2); # Output: ('sweet', 'sour')

# Example 2
$s1 = "Mango Mango";
$s2 = "Orange";
uncommon_word($s1, $s2); # Output: ('Orange')

# Example 3
$s1 = "Mango is Mango";
$s2 = "Orange is Orange";
uncommon_word($s1, $s2); # Output: ()
