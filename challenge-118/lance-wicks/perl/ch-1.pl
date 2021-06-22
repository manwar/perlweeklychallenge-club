__PACKAGE__->run() unless caller;

use lib './lib';
use Binary::Palindrome;

sub run {
    my $n = $ARGV[0] || shift;

    my $bp = Binary::Palindrome->new;
    if ( my $res = $bp->is_palindrome($n) ) {
        print "$res as binary representation of $n is ",
            $bp->represent_as_binary($n), " which is Palindrome.";
    }
    else {
        print "$res as binary representation of $n is ",
            $bp->represent_as_binary($n), " which is NOT Palindrome.";
    }
}

1;
