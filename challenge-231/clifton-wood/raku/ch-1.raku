my @ints = (3, 2, 1, 4); @ints.grep( * != (@ints.min, @ints.max).any ).gist.say # (3 2)
