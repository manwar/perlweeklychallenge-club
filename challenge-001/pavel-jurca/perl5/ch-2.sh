perl -E'say+(join"",map{$_->{0}}({$_%3,"Fizz"},{$_%5,"Buzz"}))||$_ for 1..20'

