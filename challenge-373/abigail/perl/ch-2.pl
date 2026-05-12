#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (my $line = <>) {
    my ($n, @list) = split /\s+/ => $line;  # Split input
    do {say "-1;"; next} if $n > @list;     # Special case if n > list size
    my $per_set  = int (@list / $n);        # Number of elements per set
    my $overflow = @list - $n * $per_set;   # Number of sets with one more elem
    for my $i (1 .. $n) {
        my $set_size = $per_set;            # Calculate the set size
           $set_size ++ if $i <= $overflow; # 
        print join " " => splice @list, 0, $set_size; # Fetch the set and print
        print "; ";                                   # Terminate set
    }
    print "\n";
}

__END__
