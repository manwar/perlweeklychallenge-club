use v6d;

# Copyright © 2024 PerlMonk Athanasius

sub MAIN()
{
    my %dict;
     ++%dict{$_} for $*PROGRAM-NAME.IO.words;

    %dict.keys.pick.say;
}
