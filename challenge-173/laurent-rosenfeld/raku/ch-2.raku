my @s = 2;
while @s.elems < 10 {
    push @s, 1 + [*] @s;
}
.say for @s;
