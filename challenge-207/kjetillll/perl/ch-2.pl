
sub H_index {
    @_ = sort { $b <=> $a } @_; #sort input array
    pop while $_[-1] < @_;      #keep cutting off last elem while its less than array length 
    return 0+@_                 #H-index is now the length of the array
}

my @test = (
    [10,8,5,4,3],    #4
    [25,8,5,3,3],    #3
    [10,8,5,5,5],    #5
    [25,1,1,1],      #1
    [25],            #1
);

for ( @ARGV ? ([@ARGV]) : @test ) {
    my @input = @$_;
    printf "Input: %-20s   H-Index: %d\n", "@input", H_index(@input);
}

__END__

perl ch-2.pl

Input: 10 8 5 4 3             H-Index: 4
Input: 25 8 5 3 3             H-Index: 3
Input: 10 8 5 5 5             H-Index: 5
Input: 25 1 1 1               H-Index: 1
Input: 25                     H-Index: 1
