#!raku


class Node {
    has $.value;
    has $.next is rw;


    method Str() {
        my $current = self;
        my $string;
        while ( $current ) {
            $string ~= "{ $current.value }";
            $string ~= " -> " if $current.next;
            $current = $current.next;
        }

        $string;
    }


    method size() {
        my $size-of-the-list = 0;
        my $current = self;
        while ( $current ) {
            $size-of-the-list++;
            $current = $current.next;
        }

        $size-of-the-list;
    }
}

sub MAIN( Int $N where { $N > 0 }, *@list ) {
    say @list;

    # build the list backward and keep the root
    # at the list
    my $head = Nil;
    my $current = Nil;
    loop ( my $i = @list.elems - 1; $i >= 0; $i-- ) {
        $head = Node.new( value => @list[ $i ],
                          next => $head );
    }

    # compute the size of the list
    my $size-of-the-list = $head.size;
    "Size of the list is $size-of-the-list".say;
    $head.put;





    my $index = 1;
    my $index-to-remove = $size-of-the-list - $N + 1;


    # particular case: remove the root
    $head = $head.next if ( $index == $index-to-remove || $N > $size-of-the-list );

    # remove a specific element, but only if this has not been already done
    # by removing the root element and thus changing the size of the list
    if ( $head.size == $size-of-the-list ) {
        $current = $head;
        while ( $current ) {
            if ( ( $index + 1 ) == ( $size-of-the-list - $N + 1 ) ) {
                $current.next = $current.next.next;
                last;
            }

            $index++;
            $current = $current.next;
        }
    }


    # print the modified list
    $head.put;

}
