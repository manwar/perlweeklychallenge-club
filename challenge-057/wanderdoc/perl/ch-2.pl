#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to find the Shortest Unique Prefix to represent each word in the given list. Prefixes need not be of same length.
List
    [ "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" ]
Expected Output
    [ "alph", "b", "car", "cadm", "cade", "alpi" ]
=cut





##### Solution with hash.

my @words = ("alphabet", "book", "carpet", "cadmium", "cadeau", "alpine"); 
my %strings;
for my $w ( @words )
{
     for my $idx ( 1 .. length($w) )
     {
          $strings{ substr($w, 0, $idx) }++;

     }
}
my @output;
for my $w ( @words )
{
     my @cand = grep $w =~ /^$_/, keys %strings;
     if ( @cand )
     {
          my @suff = sort {length($a)<=> length($b)} grep $strings{$_} == 1, @cand;
          push @output, $suff[0]; # print $suff[0], $/;
     }
}


print join(", ", @output), $/;

##### Solution with Tree as Trie.

print "#" x 25, $/;
use Tree::DAG_Node;

my $root = Tree::DAG_Node->new({name => 'root', attributes => {f => 0} });

my $node = $root;
my @output_2;
for my $w ( @words )
{
     my @arr = split(//,$w);
     for my $idx ( 0 .. $#arr ) # $letter ( @arr )
     {
          if ( $node->mother and $node->mother->name eq 'root' 

               and $node->name eq $arr[$idx] and 0 == $idx)
          {
               $node->attributes->{f}++;
          }
          else
          {
               my ($ed) = grep $_->name eq $arr[$idx], $node->daughters;


               if ( $ed )
               {
                    $ed->attributes->{f}++;
                    $node = $ed;
               }



               else
               {
                    my $daughter = $node->new_daughter({name => $arr[$idx], attributes => {f => 1}});
                    $node = $daughter;
               }
          }
     }
     $node = $root;
}

# print map "$_\n", @{$root->draw_ascii_tree};

sub suffixes
{
     my $root = $_[0];
     my @d = $root->daughters;
     for my $dt ( @d )
     {

          my @leaves = $dt->leaves_under;

          for my $leaf ( @leaves )
          {
               my $node = $leaf;
               my $suff;

               while ( 1 == $node->mother->attributes->{f} )
               {

                    $node = $node->mother;

               }
               while ( 0 < $node->mother->attributes->{f} )
               {
                    $suff .= $node->name;
                    $node = $node->mother;
               }

               $suff .= $node->name;

               $suff = reverse $suff;
               push @output_2, $suff; # print $suff, $/;
          }
     }
}

suffixes($root);
print join(", ", @output_2), $/;