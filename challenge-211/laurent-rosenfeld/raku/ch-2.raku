sub avg (@a) { return ([+] @a) / @a.elems; }

sub find-partition (@current, @left) {
    return if @left.elems <= 1;
    # say "Current: ", avg @current if @current.elems > 0;
    if @current.elems > 0 and $*target == avg @current  {
        push @*result, @current;
        return;
    }
    for 0..@left.end -> $i {
        find-partition( (@current, @left[$i]).flat,
            (@left[0..$i-1, $i+1..@left.end]).flat);
        return if @*result.elems > 0;
    }
}

sub start-partition (@in) {
    my $*target = avg @in;
    my @*result;
    my @current;
    find-partition @current, @in;
    return @*result;
}

for <1 2 3 4 5 6 7 8>, <1 2 3>, <1 3> -> @test {
    my @output = start-partition @test;
    print @test, " => ";
    if @output.elems == 0 {
        say "false";
    } else {
        print "true : ";
        push @output, (@test (-) @output[0]).keys;
        say @output;
    }
}
