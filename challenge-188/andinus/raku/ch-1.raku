unit sub MAIN(
    Int $divisor, *@list is copy where *.elems > 0
);
@list = @list>>.Int;

my Int $pairs;
for 0 ... @list.end -> $i {
    for $i ... @list.end -> $j {
        next if $i == $j;
        $pairs++ if (@list[$i] + @list[$j]) %% $divisor;
    }
}
put $pairs;
