my @a = (8, 1, 2, 2, 3); @a.map( -> $i { @a.grep( * < $i ).elems }).gist.say
