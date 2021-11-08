use v6;
unit sub MAIN(
    #|[Because negative integers get parsed like named parameters.]
    IntStr:D :$n!
) {
    $n ~~ rx:r/ \d+ /; # Let's keep the Unicode.
    given my $snip = $/.chars - 3 {
        when * % 2 {
            put 'even number of digits'
        }
        when * < 0 {
            put 'too short';
        }
        default {
            let $snip div= 2;
            put m:r/ ^ [ . ** {$snip} ] <( . ** 3 )> [ . ** {$snip} ] $ / given $/;
        }
    }
}
