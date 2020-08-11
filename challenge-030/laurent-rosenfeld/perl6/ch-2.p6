use v6;

for 1..10 X 1..10 X 1..10 -> $triplet {
    next unless ([+] | $triplet) == 12;
    say $triplet;
}
