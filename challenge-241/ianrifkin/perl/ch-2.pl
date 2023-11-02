use v5.30.3;
use warnings;
use strict;
use Getopt::Long;
use Pod::Usage;

#accept cmd line input
my $man = 0;
my $help = 0;
my $str_input;
GetOptions ('help|?' => \$help, man => \$man,
	    "int_input=s" => \$str_input)
    or pod2usage(2);

pod2usage(1) if $help;
pod2usage(-exitstatus => 0, -verbose => 2) if $man;

# Prepare input array
my @int_input;
# if values provided at cmd line split on comma
if ( $str_input ) {
    @int_input = (split(/,/, $str_input) );
}
# else set default values from example if no cmd line input
else {
    @int_input = (11, 8, 27, 4) unless @int_input;
}

# run the program
prime_order(\@int_input);


sub prime_order {
    my ($int_input) = @_;

    my %results;
    # Let's calcuate how many prime factors of each input number
    foreach (@{$int_input}) {
    	my $num = $_;
	$num =~ s/^\s+//; #remove whitespace is provided at cmd line just for prettiness
	
	die("Invalid input") if $num <= 2; #This shouldn't happen based on task instructions
	
	#Every number will have at least one prime (self)
	$results{$num} = 1;

	# Find the first prime factor (or self if it is prime)
	my $find_prime = prime_finder($num);

	next unless $find_prime; # go to next num if no prime found (e.g. input is 3)

	next if ($find_prime == $num); # go to next $num in loop if input number was prime

	# since input num was not prime, increment for smallest factor
	# then we will loop below to find the other factors
	$results{$num}++;

	# Calc all remaining prime factors
	my $smallest = $num / $find_prime; #the smallest prime so loop knows when to stop	
	while ($find_prime > $smallest) {
	    my $new_find_prime = prime_finder($find_prime); #calc next prime
	    last unless $new_find_prime; #exit loop if no prime found
	    last if $find_prime == $new_find_prime; #exit loop if prime found is same
	    $results{$num}++; #incr. if prime found
	    $find_prime = $new_find_prime; #start next loop or exit loop
	}

	next; #expclitly showing that we're going to next $num (just for clarity)
    }
    
    # Now we need to prepare the ouptut
    # Create a sorted array from the results hash
    my @sorted_output;
    # This should should by the count first ($results{$a} <=> $results{$b}) then the input numbers ($b cmp $a)
    foreach my $ordered_num (sort { $results{$a} <=> $results{$b} or $a <=> $b } keys %results) {
	push(@sorted_output, $ordered_num);
    }

    # Finally, print the sorted output
    say "(" . join(", ", @sorted_output) . ")";
}

# This subroutine outputs a prime number from the provided input $num
sub prime_finder {
    my ($num) = @_;
    my $num_was_prime;
    for (my $i = 2; $i <= sqrt($num); $i++) { 
	if ($num % $i == 0) {
	    return $num / $i;
	    $num_was_prime = 0;		
	    last; 
	}
	else {
	    $num_was_prime = 1;
	}
	
    }
    return $num if $num_was_prime;    
}


__END__

=head1 Challenge 241, Task 2, by IanRifkin: Prime Order

See https://theweeklychallenge.org/blog/perl-weekly-challenge-241/#TASK2 for more information on this challenge

=head1 SYNOPSIS

perl ./ch-2.pl [options]

=head1 OPTIONS

=over 8

=item B<-help>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=item B<-int_input>

An optional comma separated list of numbers (else defaults to values from example 1)

=back

=head1 DESCRIPTION

Task 2 in Challenge 241 states:

   - You are given an array of unique positive integers greater than 2.

   - Write a script to sort them in ascending order of the count of their prime factors, tie-breaking by ascending value.

This program accepts an optional comma separated list of numbers else defaults to the provided numbers from example 1.

Note: There is an assumption that "tie-breaking by ascending value" means the value of the input number (vs. the value of their prime factor)

=cut
