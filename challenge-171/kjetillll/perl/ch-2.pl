#!/usr/bin/perl
sub compose {
    my($f,$g)=@_;
    sub { $f->($g->(@_)) }
}
my $f = sub{ shift() =~ s/.//r };   #remove first char
my $g = sub{ shift() x 2 };         #same string twice
my $h = compose($f,$g);
print $h->('gold'), "\n";           #oldgold
