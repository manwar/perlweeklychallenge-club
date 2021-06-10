#!/usr/bin/env raku

say bell-numbers.head(10);

sub bell-numbers
{
    my @current-row = 1;

    gather
    {
        loop
        {
            take @current-row.head;

            my @next-row = @current-row.tail;

            while @current-row
            {
                @next-row.push: @current-row.shift + @next-row.tail;
            }

            @current-row = @next-row;
        }
    }
}
