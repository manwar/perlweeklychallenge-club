my @array = (11..35).pick: 25;

say @array;

my $max = @array.max;

my @results = @array.pop;
    
while @array.pop -> $n {
    @results.unshift: $n if $n > @results.head;

    last if $n == $max;
}

say @results;
