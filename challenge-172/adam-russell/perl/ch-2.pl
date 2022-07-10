use strict;
use warnings;
##
# You are given an array of integers. Write a script to compute the five-number summary 
# of the given set of integers.
##
sub five_number_summary{
    my @numbers = @_;
    my($minimum, $maximum, $first_quartile, $median, $third_quartile);
    my @sorted = sort {$a <=> $b} @numbers;
    $minimum = $sorted[0];
    $maximum = $sorted[@sorted - 1];
    if(@sorted % 2 == 0){
        my $median_0 = $sorted[int(@sorted / 2) - 1];
        my $median_1 = $sorted[int(@sorted / 2)];
        $median = ($median_0 + $median_1) / 2;
        my @lower_half = @sorted[0 .. int(@sorted / 2)];
        my $median_lower_0 = $lower_half[int(@lower_half / 2) - 1];
        my $median_lower_1 = $lower_half[int(@lower_half / 2)];
        $first_quartile = ($median_lower_0 + $median_lower_1) / 2;       
        my @upper_half = @sorted[int(@sorted / 2) .. @sorted];
        my $median_upper_0 = $upper_half[int(@upper_half / 2) - 1];
        my $median_upper_1 = $upper_half[int(@upper_half / 2)];
        $third_quartile = ($median_upper_0 + $median_upper_1) / 2;
    }
    else{
        $median = $sorted[int(@sorted / 2)];
        $first_quartile = [@sorted[0 .. int(@sorted / 2)]]->[int(@sorted / 2) / 2];
        $third_quartile = [@sorted[int(@sorted / 2) .. @sorted]]->[(@sorted - int(@sorted / 2)) / 2];
    }
    return {
        minimum => $minimum, 
        maximum => $maximum, 
        first_quartile => $first_quartile, 
        median => $median, 
        third_quartile => $third_quartile
    };
}

MAIN:{
    my @numbers;
    my $five_number_summary;
    @numbers = (6, 3, 7, 8, 1, 3, 9);
    print join(", ", @numbers) . "\n";
    $five_number_summary = five_number_summary(@numbers);
    map{
        print "$_: $five_number_summary->{$_}\n";
    } keys %{$five_number_summary};
    print "\n\n";
    @numbers = (2, 6, 3, 8, 1, 5, 9, 4);
    print join(", ", @numbers) . "\n";    
    $five_number_summary = five_number_summary(@numbers);
    map{
        print "$_: $five_number_summary->{$_}\n";
    } keys %{$five_number_summary};
    print "\n\n";
    @numbers = (1, 2, 2, 3, 4, 6, 6, 7, 7, 7, 8, 11, 12, 15, 15, 15, 17, 17, 18, 20);
    print join(", ", @numbers) . "\n";      
    $five_number_summary = five_number_summary(@numbers);
    map{
        print "$_: $five_number_summary->{$_}\n";
    } keys %{$five_number_summary};
}


