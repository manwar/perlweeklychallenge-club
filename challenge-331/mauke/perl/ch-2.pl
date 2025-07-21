use v5.40;

sub has_duplicate_chars($string) {
    my %seen;
    for my $c (split //, $string) {
        return true
            if $seen{$c}++;
    }
    false
}

sub are_buddies($source, $target) {
    my $delta = $source ^. $target;
    $delta =~ /[^\0]/g
        or return has_duplicate_chars($source);
    my $p1 = $-[0];
    $delta =~ /[^\0]/g
        or return false;
    my $p2 = $-[0];
    return substr($source, $p1, 1) eq substr($target, $p2, 1)
        && substr($source, $p2, 1) eq substr($target, $p1, 1)
        && scalar($delta !~ /[^\0]/g);
}

@ARGV == 2
    or die "Usage: $0 SOURCE TARGET\n";
my ($fst, $snd) = @ARGV;
say are_buddies($fst, $snd) ? 'true' : 'false';
