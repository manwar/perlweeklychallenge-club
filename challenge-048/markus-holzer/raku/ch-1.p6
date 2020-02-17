# perfect example of overcomplicated thinking
# the shift two, push one method is probably nicer,
# if not faster

my @circle = 1..500;
my $offset = 0;

while @circle.elems > 1
{
    my $pivot-man = @circle[ *-2 ];
    @circle = @circle[ $offset, { $_ + 2 } ... * ];
    $offset = @circle[ *-1 ] == $pivot-man ?? 0 !! 1;
}

# Survivor: No. 245
say "Survivor: No.", @circle.first;
