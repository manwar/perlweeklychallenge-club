#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @target = @args.shift.words;
    my @source = @args.map({ [.words] });

    my $trg = @target.join;
    my $result = False;

    for @source.permutations -> $src {
        if (@$src».join).join eq $trg {
            $result = True;
            last;
        }
    }

    say $result;
}
