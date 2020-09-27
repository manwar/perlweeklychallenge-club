use strict;
use warnings;
##
# You are given an array of positive numbers @N.
# Write a script to represent it as Histogram Chart 
# and find out how much water it can trap.
##
sub print_histogram{
    my($values) = @_;
    my @sorted_values = sort @{$values};
    my $max = $sorted_values[-1];
    my $x = $max;
    while($x >= 1){
        print "$x ";
        for my $h (@{$values}){
            print "# " if $h >= $x;
            print "  " if $h < $x;
        }
        print "\n";
        $x--;
    }
    print "- " x (@{$values} + 1);
    print "\n  " . join(" ", @{$values}) ."\n";
}

sub get_bucket_end{
    my($values, $i) = @_;
    for my $j (($i+1) .. (@{$values} - 1)){
        if($values->[$j] >= $values->[$i]){
            return $j;
        }
    }
    return -1;
}

sub find_buckets{
    my($values) = @_;
    my @buckets;
    for(my $i=0; $i < @{$values}; $i++){
        my $bucket_start = $i;
        my $bucket_end = get_bucket_end($values, $i);
        if($bucket_end > 0 && ($bucket_end - $bucket_start) >=1){
            push @buckets, [$bucket_start, $bucket_end];
            $i = $bucket_end - 1;
        }
    } 
    return @buckets; 
}

sub volume{
    my($buckets, $values) = @_;
    my $volume = 0;
    for my $bucket (@{$buckets}){
        my $bucket_start = $bucket->[0];
        my $bucket_end = $bucket->[1];
        my $min_wall = ($values->[$bucket_start] >= $values->[$bucket_end])? $bucket_end: $bucket_start;
        for my $i ($bucket_start + 1 .. $bucket_end - 1){
            $volume += ($values->[$min_wall] - $values->[$i]);
        }
    }
    return $volume;
}

MAIN:{
    my @A = (2, 1, 4, 1, 2, 5);
    my @buckets = find_buckets(\@A);
    my $volume = volume(\@buckets, \@A);
    print_histogram(\@A);
    print "Volume: $volume\n";
    
    print "\n";
    
    @A = (3, 1, 3, 1, 1, 5);
    @buckets = find_buckets(\@A);
    $volume = volume(\@buckets, \@A);
    print_histogram(\@A);
    print "Volume: $volume\n";
}