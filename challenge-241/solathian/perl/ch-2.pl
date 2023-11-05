#!usr/bin/perl
use v5.38;

# Challenge 241 - 2 - Prime Order


say primerOrder(11, 8, 27, 4);  # 11, 4, 8, 27


sub createPrimeArray($number)
{
    my @primes;
    my $divisor = 2;


    die"Number should be greater than 1"   if($number < 2);
    
    while($number != 1)
    {
        unless ($number % $divisor )
        {
            $number /= $divisor;
            push(@primes, $divisor);
            $divisor = 2;
        }
        else
        {
            $divisor++;
        }
    }
    
    return scalar @primes;
}

sub primerOrder(@list)
{
    my %hash;   # since the list is unique we can use a hash 
    my @result;
    
    foreach my $number (@list)
    {
        $hash{$number} = createPrimeArray($number);
    }
    
    # sort by the number of primes, if equal, sort by the number
    foreach my $key (sort {$hash{$a} <=> $hash{$b} || $a <=> $b } keys %hash)
    {
        push(@result, $key);
    }
    
    # cause why not
    $" = ', ';
    "@result";

}