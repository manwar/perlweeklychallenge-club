use v6;

sub MAIN (Str $input = 'Perl {Daily,Weekly,Monthly,Yearly} Challenge') {
    my $match = $input ~~ /(<-[{]>+) '{' (<-[}]>+) '}' (.+)/;
    my ($start, $options, $end) = map { ~$_ }, $match[0 .. 2];
    s:g/^ \h+ | \h+ $// for $start, $options, $end;
    say "$start $_ $end" for $options.split(/\s*','\s*/);
}
