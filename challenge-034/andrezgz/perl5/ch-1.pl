#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-034/
# Task #1
# Write a program that demonstrates using hash slices and/or array slices.

use strict;
use warnings;

my $heroes_identity = {
    'Superman' => 'Clark Kent',
    'Batman'   => 'Bruce Wayne',
    'Flash'    => 'Barry Allen',
    'Aquaman'  => 'Arthur Curry',
    'Deadpool' => 'Wade Wilson',
    'Hawkeye'  => 'Clint Barton',
    'Hulk'     => 'Bruce Banner',
};

my $actions = {
    '--help'        => \&help,
    '--array-slice' => \&array_slice,
    '--hash-slice'  => \&hash_slice,
    '-h'   => \&help,
    '-as'  => \&array_slice,
    '-hs'  => \&hash_slice,
};

my ($option, @rest) = @ARGV;
#choose action from the given option or invoke the default one
my $action = $option && $actions->{$option} || $actions->{'--help'};
$action->($heroes_identity,@rest);
exit 0;

sub array_slice {
    my ($heroes_identity,$offset,$length) = @_;

    my @heroes = sort keys %{$heroes_identity};
    print 'Array of heroes:' . aref_to_string(\@heroes) . "\n";

    my $slice_mssg = '';
    my @slice;
    if (defined $offset && defined $length) {
        @slice = splice @heroes, $offset, $length;
        $slice_mssg  = "Array slice of $length elements from position $offset";
    }
    elsif (defined $offset) {
        @slice = splice @heroes, $offset;
        print "Array slice of elements from position $offset";
    }
    else {
        @slice = splice @heroes;
        print "Array slice of elements";
    }
    print $slice_mssg . ':' . aref_to_string(\@slice) . "\n";

    print 'Array of remaining elements:' . aref_to_string(\@heroes) . "\n";
    return;
}

sub hash_slice {
    my ($heroes_identity,@sel_heroes) = @_;
    @sel_heroes = grep { exists $heroes_identity->{$_} }
                  map  { ucfirst }
                  @sel_heroes;

    if ( @sel_heroes ) {
        my @sel_heroes_identity = @{$heroes_identity}{ @sel_heroes};
        print 'Hash of heroes:' . href_to_string($heroes_identity) . "\n";
        print 'Array of existing given heroes:' . aref_to_string(\@sel_heroes) . "\n";
        print 'Hash slice of existing given heroes:' . aref_to_string(\@sel_heroes_identity) . "\n";
    }
    else {
        print "None of the given heroes exist\n";
    }
    return;
}


sub help {
    print <<"EOT";
Usage: $0 <option> <arguments>

Options:
    -h, --help          display this help and exit.

    -hs, --hash-slice   print a hash slice example for the given heroes.
                        arguments: [<heroe> ...]
                        example: $0 --hash-slice Superman Batman

    -as, --array-slice  print an array slice example of <length> heroes,
                        starting from position <offset>.
                        arguments: [<offset> | <offset> <length> ]
                        example: $0 --array-slice 2 3

EOT
    return;
}


sub aref_to_string {
    my $aref = shift;
    my $ret = join ',', map { "'$_'" } @{$aref};
    return "\n($ret)\n";
}

sub href_to_string {
    my $href = shift;
    my $ret = join "\n", map { sprintf "%12s => '%s'","'$_'",$href->{$_} } sort keys %{$href};
    return "\n(\n$ret\n)\n";
}

__END__

./ch-1.pl --hash-slice Superman Batman
Hash of heroes:
(
   'Aquaman' => 'Arthur Curry'
    'Batman' => 'Bruce Wayne'
  'Deadpool' => 'Wade Wilson'
     'Flash' => 'Barry Allen'
   'Hawkeye' => 'Clint Barton'
      'Hulk' => 'Bruce Banner'
  'Superman' => 'Clark Kent'
)

Array of existing given heroes:
('Superman','Batman')

Hash slice of existing given heroes:
('Clark Kent','Bruce Wayne')



./ch-1.pl --array-slice 2 3
Array of heroes:
('Aquaman','Batman','Deadpool','Flash','Hawkeye','Hulk','Superman')

Array slice of 3 elements from position 2:
('Deadpool','Flash','Hawkeye')

Array of remaining elements:
('Aquaman','Batman','Hulk','Superman')
