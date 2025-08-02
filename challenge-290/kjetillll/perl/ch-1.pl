use strict; use warnings; use v5.10;

my($true, $false) = (1, 0);

sub de {
    my($seen, $head, @tail) = @_;
    ! ref($seen)               ? de({}, @_)
    : $$seen{$head * 2}        ? $true
    : $$seen{$head / 2}        ? $true
    : @tail && ++$$seen{$head} ? de($seen, @tail)
    :                            $false
}

sub de2 {
    my %seen;
    for(@_){
        return $true if $seen{ $_ * 2 };
        return $true if $seen{ $_ / 2 };
        $seen{ $_ }++;
    }
    $false
}

say de(@ARGV) ? 'true' : 'false' and exit if @ARGV;

use Test::More;
is de(6, 2, 3, 3)           => $true;
is de(3, 1, 4, 13)          => $false;
is de(2, 1, 4, 2)           => $true;
is de(0, 1, 3)              => $false; #double exists for 0, but not in a different place
is de(0, 1, 3, 0)           => $true;
is de(50...99)              => $false;
is de(50...100)             => $true;
is de(reverse(50...99))     => $false;
is de(reverse(50...100))    => $true;
done_testing;
