use Cro::HTTP::Client;

sub url-part-encode (Str(Cool) $in --> Str) {
  $in.trans: (|<! # $ % & ' ( ) * + , / : ; = ? @ [ ]>, ' ') => (|<%21 %23 %24 %25 %26 %27 %28 %29 %2A %2B %2C %2F %3A %3B %3D %3F %40 %5B %5D>, '+')
}

#| Find the time in <city>
unit sub MAIN(
  $city is copy;
);

my $geodb-client = Cro::HTTP::Client.new: base-uri => 'http://geodb-free-service.wirefreethought.com';

my $city-encoded = url-part-encode($city);

my &formatter = { "%02d:%02d %s".sprintf: .hour % 12, .minute, .hour >= 12 ?? 'pm' !! 'am' }

my $result =
  await $geodb-client\
          .get('/v1/geo/cities?limit=1&offset=0&namePrefix=%s'.sprintf: $city-encoded)\
          .then({ await .result.body })\
          .then({ if my $cityid = .result<data>[0]<id> {
                    $city = .result<data>[0]<name region country>.join(', ');
                    $cityid = url-part-encode($cityid);
                    await $geodb-client.get('/v1/geo/cities/%s/dateTime'.sprintf($cityid));
                  } else {
                    die "$city not found."
                  }
                })\
  	  .then({ DateTime.new(await(.result.body).<data>, :&formatter)});


say "The time in $city is $result";

CATCH {
  when X::Cro::HTTP::Error {
    die "Error in request: ‘$_’";
  }
  default {
    die $_;
  }
}
