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

	# Get number of prime factors
	$results{$num} = prime_finder($num);
    }
    
    # Prepare the ouptut in a nice sorted array
    my @sorted_output;
    # This should should by the count first ($results{$a} <=> $results{$b}) then the input numbers ($b cmp $a)
    foreach my $ordered_num (sort { $results{$a} <=> $results{$b} or $a <=> $b } keys %results) {
	push(@sorted_output, $ordered_num);
    }

    # Finally, print the sorted output
    say "(" . join(", ", @sorted_output) . ")";
}

sub prime_finder {
    # This sub finds the number of prime factors for a given number
    my ($num) = @_;
    my $counter = 0; #the number of prime factors
    my $calculating = 1;
    while ($calculating) {
	for (my $i = int(sqrt($num)); $i >= 1; $i--) {
	    #looping backwards to find biggest prime factor first
	    if ($num % $i == 0) { #if prime factor found
		$counter++; #increment that we found a prime factor
		$calculating = 0 if ($i == 1); #if the prime factor is 1 stop the parent while loop
		$num = $num / $i; #otherwise reset num lower to search for the next prime factor
		last; #and restart for loop with new number
	    }
	    
	}
    }
    return $counter;
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
