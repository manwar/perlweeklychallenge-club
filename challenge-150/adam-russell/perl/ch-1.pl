use strict;
use warnings;
##
# You are given two strings having same number of digits, $a and $b.
# Write a script to generate Fibonacci Words by concatenation of  
# the previous two strings. Print the 51st digit of the first term
# having at least 51 digits.
## 

sub _fibonacci_words_51{
    my($accumulated) = @_;
    my $i = @{$accumulated} - 1;
    my $next = $accumulated->[$i - 1] . $accumulated->[$i];
    return substr($next, 51 - 1, 1) if length($next) >= 51;
    push @{$accumulated}, $next;
    _fibonacci_words_51($accumulated);
}

sub fibonacci_words{
    my($u, $v) = @_;
    return _fibonacci_words_51([$u, $v]);
}

MAIN:{
    print fibonacci_words(q[1234], q[5678]) . "\n";    
}