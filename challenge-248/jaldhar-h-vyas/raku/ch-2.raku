#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @a = @args.map({ [ $_.words.map({ .Int }) ] });
    my @b;

    for 0 .. @a.elems - 2 -> $row {
        my @c;
        for 0 .. @a[$row].elems - 2 -> $col {
            @c.push( [+] (@a[$row;$col], @a[$row;$col + 1],
                @a[$row + 1; $col], @a[$row + 1; $col + 1]) );
        }
        @b.push(@c);
    } 

    say "[\n",
        @b.map({ (q{  [ }, @$_.join(q{, }), " ]").join }).join(",\n"),
        "\n]\n";
}