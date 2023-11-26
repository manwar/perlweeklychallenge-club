my @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0]);
@matrix.map( *.reverse.map( *.not.Int ) ).gist.say


