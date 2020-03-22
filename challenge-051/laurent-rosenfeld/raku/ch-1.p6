use v6;
constant TARGET = 0;

my @list = @*ARGS.elems > 0 ?? @*ARGS.sort !! (-25, -10, -7, -3, 2, 4, 8, 10);
for @list.combinations(3) -> $combination {
    say $combination if ([+] $combination) == TARGET;
}
