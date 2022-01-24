$_ = q:to/END/;
    unused
    one     two       three    four     five
    six     seven     eight    nine     ten
    eleven  twelve    thirteen fourteen fifteen
    sixteen seventeen eighteen nineteen twenty
    ?       ?          ?       ?        ?
    ?       ?          ?       ?        thirty
    ?       ?          ?       ?        ?
    ?       ?          ?       ?        forty
    ?       ?          ?       ?        ?
    ?       ?          ?       ?        fifty
    ?       ?          ?       ?        ?
    ?       ?          ?       ?        sixty
    ?       ?          ?       ?        ?
    ?       ?          ?       ?        seventy
    ?       ?          ?       ?        ?
    ?       ?          ?       ?        eighty
    ?       ?          ?       ?        ?
    ?       ?          ?       ?        ninety
    ?       ?          ?       ?        ?
    ?       ?          ?       ?        one hundred
    END

# Change all newlines to two spaces.
s:g/\n/ /;

# Delete spaces at the end of line.
s/\s*$$//;

# Split on two or more spaces.
my @spelled = .split(/\s\s+/);

# Fill in 21...29, 31...39, 41...49, ..., 91...99.
for (20, 30, 40 ... 90) -> $i {
    for (1 .. 9) -> $j {
    	@spelled[$i+$j] = @spelled[$i] ~ '-' ~ @spelled[$j];
    }
}

# Print out numbers with no 'e' in the numbers' names.
(1..100).map({@spelled[$_].contains('e') or .say});2
