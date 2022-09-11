my @daily-temps;
for './temperature.txt'.IO.lines -> $line {
    push @daily-temps, split /','\s/, $line;
}
my $temp = Inf;
for @daily-temps.sort({$^a leg $^b}) -> @record {
    say @record[0] if @record[1] > $temp;
    $temp = @record[1];
}
