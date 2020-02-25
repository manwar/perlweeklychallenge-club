use v6;

sub my-chop (Str $in is rw) {
    my $char = $in.substr(*-1);
    $in = $in.substr(0, $in.chars - 1);
    $char;
}

sub combine (Str $combined, Str $source is copy) {
    if $source eq "" {
        say $combined if evaluate($combined) == 100;
        return;
    }
    my $operand = my-chop $source;
    for '+', '-', '' -> $op {
        my $str = "$combined$op$operand";
        combine($str, $source);
    }
}

sub evaluate (Str $expr) {
    my $val = 0;
    $val += $_ for $expr ~~ m:g/(<[+-]>?\d+)/;
    return $val;
}

my $source = "123456789".flip;
my $combined = my-chop $source;
combine $combined, $source;
