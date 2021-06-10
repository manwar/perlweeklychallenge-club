use v6;

my @input = <name,age,sex Mohammad,45,m
             Joe,20,m Julie,35,f Cristina,10,f>;

my @transposed;
for @input -> $in {
    my $i = 0;
    for $in.split(',') -> $str {
        push @transposed[$i], $str;
        $i++;
    }
}
for @transposed -> @line {
    say @line.join(',');
}
