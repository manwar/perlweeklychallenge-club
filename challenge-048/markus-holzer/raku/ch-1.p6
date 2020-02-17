my @circle = (1..500);

while @circle.elems > 1
{
    my $offset = @circle.elems %% 2 ?? 0 !! 1;
    @circle = @circle[ $offset, { $_ + 2 } ... * ];
}

# Survivor: No. 245
say "Survivor: No.", @circle.first;
