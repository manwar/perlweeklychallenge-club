#!/usr/bin/raku

sub MAIN (
    *@list
) {
    my $seq = '00';
    my @output = @list.map({ $_.subst(/^../, $seq++)});
    @output.join(q{ }).say;
}