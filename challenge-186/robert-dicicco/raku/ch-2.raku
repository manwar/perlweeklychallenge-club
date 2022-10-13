use v6;

# AUTHOR: Robert DiCicco
# DATE: 2022-10-11
# Challenge 186 Unicode Makeover ( Raku )

my @arr = ["ÃÊÍÒÙ","âÊíÒÙ"];

my $i = 0;

for (@arr) -> $x {

  while $i < $x.chars {

    my $c = $x.substr($i,1).ord;

    given $c {

      when 192..197 { print 'A';}

      when 200..203 { print 'E';}

      when 204..207 { print 'I';}

      when 210..214 { print 'O';}

      when 217..219 { print 'U';}

      when 224..229 { print 'a';}

      when 232..235 { print 'e';}

      when 236..239 { print 'i';}

      when 242..246 { print 'o';}

      when 249..252 { print 'u';}

      default { say '?'}

    }

    $i++;

  }

  say " ";

  $i = 0;

}
