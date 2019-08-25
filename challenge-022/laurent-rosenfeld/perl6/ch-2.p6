use v6;

constant $start-dict-size = 26;

sub encode (Str $in) {
    my %dict = map { $_[0] => $_[1] },
        ( ('A'..'Z') Z (^$start-dict-size) );
    my $ω = "";
    my @result = gather {
        for $in.comb -> $c {
            my $ωc = $ω ~ $c;
            if %dict{$ωc}:exists {
                $ω = $ωc;
            } else {
                take %dict{$ω};
                %dict{$ωc} = +%dict;
                $ω = $c;
            }
        }
        take %dict{$ω} if $ω.chars;
    }
    # say %dict;
    return @result;
}
sub decode (@encoded) {
    my $dict-size = $start-dict-size;
    my %dict = map { $_[1] => $_[0] },
        ( ('A'..'Z') Z (^$start-dict-size) );
    my $ω = %dict{shift @encoded};
    my @result = gather {
        take $ω;
        for @encoded -> $i {
            my $str;
            if %dict{$i}:exists {
                $str = %dict{$i};
            } elsif  $i == $dict-size {
                $str = $ω ~ $ω.substr(0,1)
            }
            take $str;
            %dict{$dict-size++} = $ω ~ $str.substr(0,1);
            $ω = $str;
        }
    }
    return join "", @result;
}

my $input_str = 'TOBEORNOTTOBETOBEORNOTTOBETOBEORNOTTOBE';
my @encoded = encode $input_str;
say @encoded;
say decode @encoded;
