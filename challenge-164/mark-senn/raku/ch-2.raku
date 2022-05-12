use v6.d;

# Return True if $_ is a happy number.
# Return False if $_ is not a happy number.

sub is-happy(Int $_ is copy) {
    my @digit; # array of digits for current number
    my %seen; # have we seen this number before?
    loop {
    	$_ = ((@digit = .split('')) <<*>> @digit).sum;
    	$_ == 1 and return True;
    	%seen{$_} and return False;
    	%seen{$_} = True;
    }
}

(1..*).grep({.&is-happy}).head(8).join(' ').say;1
