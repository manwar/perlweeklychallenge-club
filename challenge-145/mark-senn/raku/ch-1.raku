my @a = (1, 2, 3);
my @b = (4, 5, 6);

# Compute dot product of @a and @b and print it.
# "@a <<*>> @b" does pair-wise multiplication of elements in @a and @b.
# For example, "[+] (4, 10, 18)" does  4 + 10 + 18.
say [+] (@a <<*>> @b);
