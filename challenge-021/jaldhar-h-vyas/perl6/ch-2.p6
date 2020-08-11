#!/usr/bin/perl6

grammar URL {
    rule TOP {
        <Scheme>
        ':'
        [
            <Slashes>?
            [ <Userinfo> '@' ]?
            <Host>
            [ ':' <Port> ]?
        ]?
        <Path>?
        [ '?' <Query> ]?
        [ '#' <Fragment> ]?
    }

    token Scheme { <SchemeChar>+ }
    token Slashes { \/\/ }
    token Userinfo { <UserinfoChar>+ }
    token Host { <IPv4> | <Unreserved>+ }
    token Port { \d+ }
    token Path { <PathChar>+ }
    token Query { <QueryOrFragment>+ }
    token Fragment { <QueryOrFragment>+ }

    token SchemeChar { <[ A..Z a..z 0..9 + \- . ]> }
    token DecOctet { \d | <[1..9]>\d | 1\d\d | 2<[0..4]>\d | 25<[0..5]> }
    token HexOctet { <[ 0..9 A..F a..f ]> ** 2 }
    token IPv4 { <DecOctet> \. <DecOctet> \. <DecOctet> \. <DecOctet> }
    token PChar { <UserinfoChar> | '@' }
    token PathChar { <PChar> | '/' }
    token PctEncoded { \% <HexOctet> }
    token QueryOrFragment { <PChar> | \/ | \? }
    token SubDelim { <[ \! $ & \' \( \) * \+ \, \; \= ]> }
    token Unreserved { <[ A..Z a..z 0..9 \- . _ \~ ]> }
    token UserinfoChar { <Unreserved> | <PctEncoded> | <SubDelim> | ':' }
}

class URLAction {
    method TOP($/) {
        my $result = $<Scheme>.made ~ ':';
        if $/<Slashes> {
            $result ~= $<Slashes>;
        }

        if $/<Userinfo> {
            $result ~= $<Userinfo>.made ~ '@';
        }

        if $/<Host> {
            $result ~= $<Host>.made;
        }

        if $/<Port.made> {
            $result ~= ':' ~ $<Port>.made;
        }

        $result ~= $<Path>.made;

        if $/<Query> {
            $result ~= '?' ~ $<Query>.made;
        }

        if $<Fragment> {
            $result ~= '#' ~ $<Fragment>.made;
        }

        make($result);

    }

    method Scheme($/) {
        make($/.Str.lc);
    }

    method Host($/) {
        make($/.Str.lc);
    }

    method Userinfo($/) {
        make(self.processPctEncoded($/.Str));
    }
    
    method Port($/) {
        if ($/.Str ~~ '80') {
            make(Nil);
        }
    }

    method Path($/) {
        make(self.processPctEncoded($/.Str));
    }

    method Query($/) {
        make(self.processPctEncoded($/.Str));
    }

    method Fragment($/) {
        make(self.processPctEncoded($/.Str));
    }

    method processPctEncoded($part) {
        my $processed = $part;
        for $part ~~ m:g/ \% $<HexOctet> = ( <[ 0..9 A..F a..f ]> ** 2 ) /
        -> $pct {
            my $hex = $pct<HexOctet>.Str.uc;
            if :16($hex) ~~ / <[ A..Z a..z 0..9 \- . _ \~ ]> / { # Unreserved
                $processed = $processed.subst($pct.Str, :16($hex).chr);
            } else {
                $processed = $processed.subst($pct.Str, "%$hex");
            }
        }
        return $processed;
    }
}


multi sub MAIN($url) {
    URL.parse($url, actions => URLAction.new).made.say;
}