#!/usr/bin/env perl
#use v5.30.0;
use feature 'say';
no warnings;
## Task 2, find the odd string in the list of strings.
## Find the difference array of each string, then pick the strange one.
# https://gist.github.com/manwar/51d6144d28cf984da81645f779ce2932

my @s = ("adc", "wzy", "abc");
#my @s = ("aaa", "bob", "ccc", "ddd");
#my @s = ("adccc", "wzyyy", "abcde");

print "Input: \@s = (";
for (0 .. $#s - 1) {
    print '"'.$s[$_].'", ';
}
print '"'.$s[$#s].'"';
say ")";

my $alphabet = "abcdefghijklmnopqrstuvwxyz";
my @alph = split //, $alphabet;

my %hash = map { $alph[$_] => $_ + 1 } 0..25;

sub diff {
    my ($let1, $let2) = @_;
    $hash{$let1} - $hash{$let2}
}

my $output;			# For pretty formatting
sub array {			# Returns a difference array
    my $word = shift;
    $output .= "Difference array for \"$word\"";
    my $gap = length($s[0]) - 1;
    my $spacer = "\t" x 3;
    $spacer .= " " x $gap;
    $spacer .= " => [ ";    
    my @letters = split //, $word;
    $output .= " => [ ";
    for (1..$#letters-1) {
	$output .= $letters[$_]." - ".$letters[$_ - 1].", ";
    }
    $output .= $letters[$#letters]." - ".$letters[$#letters - 1]." ]\n";
    $output .= $spacer; 
    for (1..$#letters-1) {
	$output .= "$hash{$letters[$_]} - $hash{$letters[$_ - 1]}, ";
    }
    $output .= "$hash{$letters[$#letters]} - $hash{$letters[$#letters - 1]} ]\n";
    my @diff_array;
    $output .= $spacer;
    for (1..$#letters-1) {
	$output .= $hash{$letters[$_]} - $hash{$letters[$_ - 1]}.", ";
	push @diff_array, $hash{$letters[$_]} - $hash{$letters[$_ - 1]};
    }
    $output .= $hash{$letters[$#letters]} - $hash{$letters[$#letters - 1]}." ]\n\n";
    push @diff_array, $hash{$letters[$#letters]} - $hash{$letters[$#letters - 1]};
    @diff_array
}

my (@common_array, @odd_array);
my $odd_index=0;
for (0 .. $#s) {
    my @new_array = array($s[$_]);
    if ($_ == 0) {
	@common_array = @new_array;
	@odd_array = @new_array;
    }
    next if (@new_array ~~ @common_array);
    @odd_array = @new_array;
    $odd_index = $_;
}

my $ans = $s[$odd_index];
say "Output: \"$ans\"\n";
print $output;
say "The difference array for \"$ans\" is the odd one.";
