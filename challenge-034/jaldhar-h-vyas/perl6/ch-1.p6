#!/usr/bin/perl6

sub binarySearch(@haystack,  $needle) {
    if @haystack.elems {
        my $mid = (@haystack.elems / 2).Int; 

        if $needle eq @haystack[$mid] { 
            return True;
        }

        if $needle gt @haystack[$mid] { 
            return binarySearch(@haystack[$mid + 1 .. *], $needle);
        } 

        return binarySearch(@haystack[0 .. $mid - 1], $needle);
    }
    return False;
}

sub MAIN() {
    my @letters = ('a' .. 'z');
    my @haystack = @letters.pick(@letters.elems / 2);
    my $needle = @letters.pick;

    say "is $needle in ", @haystack.join, '?';
    say binarySearch(@haystack.sort, $needle) ?? 'Yes.' !! 'No.';
}

