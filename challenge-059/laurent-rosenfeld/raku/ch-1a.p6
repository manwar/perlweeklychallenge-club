use v6;

my $k = 3;
my @vals = <1 4 3 2 5 2>;
my %out = classify { $_ < $k ?? 'before' !! 'after'}, @vals;
say join " → ", |%out<before>, |%out<after>;
