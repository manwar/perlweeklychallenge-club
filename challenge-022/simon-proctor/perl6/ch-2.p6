#!/usr/bin/env perl6

use v6;

=begin pod

Encodes and Decodes using the LZW algorithm.

Encoded data is expected as a series of space seperated numbers because I don't want to mess about bit twiddling.

=end pod

sub USAGE() {
    say "Encodes and Decodes using the LZW algorithm.\n\nEncoded data is expected as a series of space seperated numbers because I don't want to mess about bit twiddling.\n$*USAGE";
}

subset FilePath of Str where *.IO.f;
subset ValidToEncode of Str where m/^<[a..z A..Z 0..9 \  _ \n \. , ]>* \n?$/;
subset ValidToDecode of Str where m/^ [\d+]+ % " " $/;

multi sub MAIN( Bool :h(:$help) where ?* ) { USAGE() }

#| Read from STDIN and encode the result
multi sub MAIN( 'encode' ) {
    say encode-data( $*IN.slurp.chomp );
}

#| Read the text from the given file and output the encoded result
multi sub MAIN( 'encode', FilePath $path ) {
    say encode-data( $path.IO.slurp.chomp );
}

#| Encode the given string
multi sub MAIN( 'encode', Str $data ) {
    say encode-data( $data );
}

#| Read from STDIN and decode the result
multi sub MAIN( 'decode' ) {
    say decode-data( $*IN.slurp.chomp );
}

#| Read the text from the given file and output the decoded result
multi sub MAIN( 'decode', FilePath $path ) {
    say decode-data( $path.IO.slurp.chomp );
}

#| Decode the given string
multi sub MAIN( 'decode', Str $data ) {
    say decode-data( $data );
}

#| Decode a list of ints
multi sub MAIN( 'decode', *@data where { @data.all ~~ Int } ) {
    say decode-data( @data.join(" ") );
}



multi sub encode-data( ValidToEncode $str ) {
    my @working = $str.comb;
    my %dict = (available-characters() Z=> (0,1,2...*)).hash;
    my $output = [];

    LOOP: while @working.elems > 0 {
        # Find the maximum key length
        my $max = %dict.keys.map( *.codes ).sort( { $^b <=> $^a } ).first();
        $max = @working.elems if $max > @working.elems;
        
        for (1..$max).reverse -> $length {
            my $substr = @working[0..^$length].join("");
            if ( %dict{$substr}:exists ) {
                $output.push( %dict{$substr} );
                if ( @working.elems > $length ) {
                    my $next = @working[0..$length].join("");
                    %dict{$next} = %dict.values.max+1;
                }
                @working.splice(0,$length);
                next LOOP;
            }
        }
    }

    $output.join(" ");
}

multi sub encode-data( Str $ ) {
    die "Data to encode can include only a-z, A-Z, 0-9, ' ', ',', '.', and '_' newlines";
}

multi sub decode-data( ValidToDecode $str ) {
    my @input = $str.split(" ");
    my %dict = ((0,1,2...*) Z=> available-characters()).hash;
    my $next-key = %dict.keys.elems;
    my @output = [];
    my $last;

    for @input -> $key { 
        @output.push( %dict{$key} );
        with $last {
            %dict{$next-key} = $last ~ %dict{$key};
            $next-key++;
        }
        $last = %dict{$key}
    }
    
    @output.join("");
}

multi sub decode-data( Str $ ) {
    die "Data to decode should be a space seperated string of Ints";
}

sub available-characters() {
    ( |("a".."z"), |("A".."Z"), " ", "_", ",", ".", "\n", |("0".."9") );
}
