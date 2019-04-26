#!/usr/bin/env perl6

use v6;
use lib 'lib';
use Anagrams;

my %*SUB-MAIN-OPTS = :named-anywhere;

sub USAGE { say $*USAGE }

subset FilePath of Str where *.IO.f;

#| Display Help file
multi sub MAIN ( Bool :h($help) where *.so ) { USAGE(); }

#| Find the strings(s) which has the most anagrams in the given dictionary
#| Prints out 1 string per line to STDOUT
multi sub MAIN (
    FilePath :$dict = "/etc/dictionaries-common/words" #= Dictionary file to use. Defaults to "/etc/dictionaries-common/words"
) {
    my %store;
    my $max-length = 0;
    my @values;

    for $dict.IO.words -> $word {
        my $string = order-string( $word );
        my @keys = $string.comb;
        my $current = %store;
        for @keys -> $key {
            $current{$key} //= {};
            $current = $current{$key};
        }
        $current<count>++;
        
        given $current<count> {
            when * > $max-length {
                $max-length = $current<count>;
                @values = [$string];
            }
            when * == $max-length {
                @values.push($string);
            }
        }
        
    }

    @values>>.say;
}
