#!/usr/bin/perl

use v5.40;

use List::Util qw(shuffle);

my $s = <<END;
This supposed Cambridge research is unfortunately an urban legend. However,
the effect has been studied. For example—and with a title that probably
made the journal’s editor a little nervous—Raeding wrods with jubmled
lettres: there is a cost by Rayner, White, et. al. looked at reading speed
and comprehension of jumbled text.
END

say $s;
say $s =~ s/(\pL)(\pL{2,})(\pL)/$1 . (join '', shuffle(split q(), $2)) . $3/reg;
