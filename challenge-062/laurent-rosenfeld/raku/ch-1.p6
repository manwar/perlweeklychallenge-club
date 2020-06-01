use v6;

sub normalize (Str $addr) {
    my ($box, $domain) = split /'@'/, $addr;
    $domain.uc ~ '@' ~ $box;
}
sub process-addresses( @addresses, Bool $unique) {
    @addresses = @addresses.unique(:as(&normalize)) if $unique;
    my @sorted = sort &normalize, @addresses;
    .say for @sorted;
}
multi sub MAIN (Bool :u(:$unique) = False, *@files) {
    my @addresses = @files.IO.lines;
    process-addresses @addresses, $unique;
}
multi sub MAIN (Bool :u(:$unique) = False) {
    my @addresses = $*IN.lines;
    process-addresses @addresses, $unique;
}
