#! /usr/bin/perl6

my %tree=(
  '' => [<a e i o u>],
  a => [<e i>],
  e => [<i>],
  i => [<a e o u>],
  o => [<a u>],
  u => [<o e>],
    );

print map {"$_\n"}, generate(2,%tree);

sub generate {
  my ($len,%tree)=@_;
  my @list=('');
  while (1) {
    if (@list[0].chars==$len) {
      last;
    }
    my $r=shift @list;
    my $s = substr($r,*-1,1) || '';
    for @(%tree{$s}) -> $extension {
      push @list,$r ~ $extension;
    }
  }
  return @list;
}
