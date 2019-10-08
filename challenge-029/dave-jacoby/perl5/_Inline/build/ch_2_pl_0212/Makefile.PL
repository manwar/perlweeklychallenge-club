use ExtUtils::MakeMaker;
my %options = %{
{
  'NAME' => 'ch_2_pl_0212',
  'INC' => '-iquote"/home/jacoby/local/dev/perlweeklychallenge-club/challenge-029/dave-jacoby/perl5"',
  'VERSION' => '0.00',
  'TYPEMAPS' => [
    '/home/jacoby/perl5/perlbrew/perls/perl-5.30.0/lib/5.30.0/ExtUtils/typemap'
  ]
}
};
WriteMakefile(%options);

# Remove the Makefile dependency. Causes problems on a few systems.
sub MY::makefile { '' }
