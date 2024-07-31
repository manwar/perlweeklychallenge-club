use strict; use warnings;

sub f {
    my $end = '';
    shift()
      =~ s{ (\S) (\S*) }
          {
            my( $first, $rest ) = ($1,$2);
            $end .= 'a';
            $first =~ /[aeiou]/i
              ? $first . $rest . 'ma' . $end
              : $rest . $first . 'ma' . $end
          }exgr
}


use Test::More tests => 3;
is f( $$_{input} ), $$_{output} for
{
    input  => 'I love Perl',
    output => 'Imaa ovelmaaa erlPmaaaa'
},
{
    input  => 'Perl and Raku are friends',
    output => 'erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa'
},
{
    input  => 'The Weekly Challenge',
    output => 'heTmaa eeklyWmaaa hallengeCmaaaa'
}
