unit sub MAIN( *@N where @N.all ~~ Int );

my $max = @N.max;

my @histo = reverse [Z]
    (' ', '-', |(1..$max) ),
    |@N.map: { $_, '-', |('#' xx $_), |(' ' xx ($max - $_)) };

my @pretty = @histo.map({
    .join('')
    .subst(/ <?after '#'> ( \s+ ) <?before '#'> /, { '~' x .chars }, :g)
    .subst('', ' ', :g )});


.say and .indices('~').elems.say with @pretty.join("\n");

# This was my first attempt before I realized we're supposed to
# print the histogram too and I can just count the ~ in the output

sub index-find { @N.pairs.grep( *.value >= $^h ).map: *.key }
sub index-diff { ($^i.cache.skip >>->> $^i).map: * - 1 }

say ($max...0)
    .map( &index-find )
    .map( &index-diff )
    .flat
    .sum;