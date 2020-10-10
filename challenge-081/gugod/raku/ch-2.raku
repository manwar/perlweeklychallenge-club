#!/usr/bin/env raku

sub MAIN (Str $input = 'input') {
    print-frequency-table( word-frequency( IO::Path.new($input) ) );
}

sub word-frequency ( $fh ) {
    my %freq;
    my $prev = '';
    for $fh.split(/<?wb>/) -> $token {
        if $token.match(/<:Letter>/) && !($token eq "s" && $prev eq "'") {
            %freq{$token} += 1;
        }
        $prev = $token;
    }

    return %freq;
}

sub print-frequency-table ( %freq ) {
    my %rfreq;
    for %freq.pairs -> $it {
        %rfreq{ $it.value }.append( $it.key );
    }
    for %rfreq.keys.sort -> $n {
        say $n ~ ' ' ~ %rfreq{$n}.sort.join(' ');
    }
}
