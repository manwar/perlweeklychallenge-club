sub MAIN($str = "552051139") {
    my @solutions;
    get_octet_set( $str.Int, @solutions );

    .say for @solutions;
}

sub get_octet_set ($str, @solutions,  $prev = []) {
    for 1 .. 3 -> $digits {
        ## out if str is undef or substr would be beyond end    #2, #3
        return if $str.chars - $digits < 0 || $prev.elems == 4;

        my $list = $prev.clone;

        ## get octet
        my $octet = substr( $str, 0, $digits );

        ## out if leading 0 or out of bounds                #1
        return if $octet ~~ /^0\d/ || $octet > 255;

        ## if this is the last octet log and return         # success here
        if $list.elems == 3 && $str.chars == $digits {
            $list.push: $octet;
            @solutions.push: $list;
            ## out: cannot have a longer solution
            return;
        }

        ## crop str to remainder
        my $cropped = substr( $str, $digits );
        ## add octet to copy of list
        my $newlist = $list.push: $octet;
        ## descend
        get_octet_set( $cropped, @solutions, $list );
    }
}
