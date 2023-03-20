#!/usr/bin/raku

sub MAIN(
    *@strings #= two lists of strings separated by '-'
) {
    my @list1;
    my @list2;
    my $destination = 'first';

    for @strings -> $string {
        if $string eq '-' {
            $destination = 'second';
            next;
        }
        if $destination eq 'first' {
            @list1.push($string);
        } elsif $destination eq 'second' {
            @list2.push($string);
        }
    }

    my %common;

    for 0 .. @list1.end -> $i {
        %common{@list1[$i]}[0] = $i;
        unless %common{@list1[$i]}[1]:exists {
            %common{@list1[$i]}[1] = -1;
        }
    }

    for 0 .. @list2.end -> $i {
        unless %common{@list2[$i]}[0]:exists {
            %common{@list2[$i]}[0] = -1;
        }
        %common{@list2[$i]}[1] = $i;
    }

    my %indexsum;

    for %common.keys -> $string {
        if %common{$string}[0] != -1 && %common{$string}[1] != -1 {
            %indexsum{$string} = %common{$string}.sum;
        }
    }

    my $minimumindex = %indexsum.values.sort({ $^a <=> $^b }).first;

    say q{(} ~
        %indexsum
            .keys
            .grep({ %indexsum{$_} == $minimumindex })
            .map({ q{"} ~ $_ ~ q{"}})
            .sort
            .join(q{, })
         ~ q{)};
}