#!/usr/bin/env raku

say (1..36).map(&self-descriptive).flat.head(3);

multi self-descriptive($base where * == 1|2|3|6)
{
    Empty;
}

multi self-descriptive($base where * == 4|5)
{
    my $start = (1         ~ 0 x $base - 1).parse-base($base);
    my $end   = ($base - 1 ~ 0 x $base - 1).parse-base($base);

    gather 
    {
        while $start < $end
        {
            my $multiple = $start.base($base);

            take $multiple if all map 
            { 
                $multiple.substr($_, 1) == $multiple.indices($_) 
            }, ^$base; 

            $start += $base;
        }
    }
}

multi self-descriptive($base)
{
    ($base - 4).base(36) ~ 21 ~ 0 x $base - 7 ~ 1000;
}
