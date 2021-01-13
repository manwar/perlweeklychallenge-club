# Gapful Number
#
# Write a script to print first 20 Gapful Numbers greater than or equal to 100.
# Please check out the page for more information about Gapful Numbers.
#
# Gapful numbers >= 100: numbers that are divisible by the number formed by
# their first and last digit. Numbers up to 100 trivially have this property
# and are excluded.

my @gapful = (100..Inf).grep({
    $_ % Int(Str($_).comb[0] ~ Str($_).comb[*-1]) == 0
});

@gapful[^20].say;
