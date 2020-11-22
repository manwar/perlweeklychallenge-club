use strict;
use warnings;
##
# You are given an unsorted array of integers @N.
# Write a script to find the longest consecutive sequence. 
# Print 0 if no sequence found.
##
sub min_max{
    my @a = @_;
    my($min, $max) = ($a[0], $a[0]);
    for my $x (@a){
        $min = $x if($x < $min);
        $max = $x if($x > $max);
    }
    return ($min, $max);
}

sub longest_sequence{
    my @sequences = @_;
    my @max = (0);
    for my $sequence (@sequences){
        @max = @{$sequence} if((@{$sequence} > @max) && (@{$sequence} > 1));
    }
    return @max;
}

sub continuous_sub_sequences{
    my @a = @_;
    my($min, $max) = min_max(@a);
    my @sub_sequences;
    my $sub_sequence = [];
    while($min <= $max){
        my $test = grep {$_ == $min} @a;
        if($test){
            push @{$sub_sequence}, $min;
        }
        else{
            push @sub_sequences, $sub_sequence if(@{$sub_sequence} > 0);
            $sub_sequence = [];
        }
        $min++;
    }
    return @sub_sequences;
}

MAIN:{
    my @N = (100, 4, 50, 3, 2);
    my @sequences = continuous_sub_sequences(@N);
    my @max = longest_sequence(@sequences);
    print join(",", @max) . "\n";
    @N = (20, 30, 10, 40, 50);
    @sequences = continuous_sub_sequences(@N);
    @max = longest_sequence(@sequences);
    print join(",", @max) . "\n";
    @N = (20, 19, 9, 11, 10);
    @sequences = continuous_sub_sequences(@N);
    @max = longest_sequence(@sequences);
    print join(",", @max) . "\n";
}