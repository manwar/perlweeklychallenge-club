my %h;
my @a = <a b c>;
my @b = <b c f>; %h{ |@a, |@b } »=» 1;
my (@m-a, @m-b);
for %h.keys {
  @m-a.push: $_ unless @a.first($_).defined;
  @m-b.push: $_ unless @b.first($_).defined;
}
@m-a.gist.say;
@m-b.gist.say;
