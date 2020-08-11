#! /usr/bin/env raku

my regex VINCHAR { A | B | C | D | E | F | G | H | J | K | L | M | N | P | R | S | T | U | V | W | X | Y | Z | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 };

my @vinchar = <A B C D E F G H J K L M N P R S T U V W X Y Z 1 2 3 4 5 6 7 8 9 0>;

subset VIN of Str where * ~~ /^ <VINCHAR> ** 17 $/;
subset WMI of Str where * ~~ /^ <VINCHAR> **  3 $/;

my %country1 = ( J => "Japan", L => "China", 1 => "USA",       2 => "Canada",
                 4 => "USA",   5 => "USA",   6 => "Australia", 7 => "New Zealand",
		 W => "Germany");

my %country2;

add-country("AA", "AH", "South Africa");
add-country("AJ", "AN", "Cote d'Ivoire");
add-country("BA", "BE", "Angola");
add-country("BF", "BK", "Kenya");
add-country("BL", "BR", "Tanzania");
add-country("CA", "CE", "Benin");
add-country("CF", "CK", "Madagascar");
add-country("CL", "CR", "Tunisia");
add-country("DA", "DE", "Egypt");
add-country("DF", "DK", "Morocco");
add-country("DL", "DR", "Zambia");
add-country("EA", "EE", "Ethiopia");
add-country("EF", "EK", "Mozambique");
add-country("FA", "FE", "Ghana");
add-country("FF", "FK", "Nigeria");
add-country("KA", "KE", "Sri Lanka");
add-country("KF", "KK", "Israel");
add-country("KL", "KR", "Korea (South)");
add-country("KS", "K0", "Kazakhstan");
add-country("MA", "ME", "India");
add-country("MF", "MK", "Indonesia");
add-country("ML", "MR", "Thailand");
add-country("MS", "M0", "Myanmar");
add-country("NA", "NE", "Iran");
add-country("NF", "NK", "Pakistan");
add-country("NL", "NR", "Turkey");
add-country("PA", "PE", "Philippines");
add-country("PF", "PK", "Singapore");
add-country("PL", "PR", "Malaysia");
add-country("RA", "RE", "United Arab Emirates");
add-country("RF", "RK", "Taiwan");
add-country("RL", "RR", "Vietnam");
add-country("RS", "R0", "Saudi Arabia");
add-country("SA", "SM", "United Kingdom");
add-country("SN", "ST", "East Germany");
add-country("SU", "SZ", "Poland");
add-country("S1", "S4", "Latvia");
add-country("TA", "TH", "Switzerland");
add-country("TJ", "TP", "Czech Republic");
add-country("TR", "TV", "Hungary");
add-country("TW", "T1", "Portugal");
add-country("UH", "UM", "Denmark");
add-country("UN", "UT", "Ireland");
add-country("UU", "UZ", "Romania");
add-country("U5", "U7", "Slovakia");
add-country("VA", "VE", "Austria");
add-country("VF", "VR", "France");
add-country("VS", "VW", "Spain");
add-country("VX", "V2", "Serbia");
add-country("V3", "V5", "Croatia");
add-country("V6", "V0", "Estonia");
add-country("XA", "XE", "Bulgaria");
add-country("XF", "XK", "Greece");
add-country("XL", "XR", "Netherlands");
add-country("XS", "XW", "Russia");
add-country("XX", "X2", "Luxembourg");
add-country("X3", "X0", "Russia");
add-country("YA", "YE", "Belgium");
add-country("YF", "YK", "Finland");
add-country("YL", "YR", "Malta");
add-country("YS", "YW", "Sweden");
add-country("YX", "Y2", "Norway");
add-country("Y3", "Y5", "Belarus");
add-country("Y6", "Y0", "Ukraine");
add-country("ZA", "ZR", "Italy");
add-country("ZX", "Z2", "Slovenia");
add-country("Z3", "Z5", "Lithuania");
add-country("3A", "3W", "Mexico");
add-country("3X", "37", "Costa Rica");
add-country("38", "39", "Cayman Islands");
add-country("8A", "8E", "Argentina");
add-country("8F", "8K", "Chile");
add-country("8L", "8R", "Ecuador");
add-country("8S", "8W", "Peru");
add-country("8X", "82", "Venezuela");
add-country("9A", "9E", "Brazil");
add-country("9F", "9K", "Colombia");
add-country("9L", "9R", "Paraguay");
add-country("9S", "9W", "Uruguay");
add-country("9X", "92", "Trinidad & Tobago");
add-country("93", "99", "Brazil");

sub add-country($from, $to, $name)
{
  my ($first, $second) = $from.comb;

  loop
  {
    %country2{$first ~ $second} = $name;

    last if "$first$second" eq $to;

    if $second eq "Z"
    {
      $second = "1";
    }
    elsif $second eq "9"
    {
      $second = "0";
    }
    elsif $second eq "0"
    {
      die "Not possible to increment past { $first }0. Set up two rules.";
    }
    else
    {
      repeat { $second.=succ } until $second eq any @vinchar;
    }
  }
}

sub wmi2manufacturer( WMI $wmi)
{
  my %manufacturer2 = (  JA  => "Isuzu",
                         JF  => "Fuji Heavy Industries",
  		         JN  => "Nissan",
                         JS  => "Suzuki",
  		         JT  => "Toyota",
                         JY  => "Yamaha",
                         KL  => "Daewoo/GM Korea",
  		         KN  => "Kia",
  		         UU  => "Dacia",
  		        '1B' => "Dodge",
 		        '1C' => "Chrysler",
 		        '1F' => "Ford",
 		        '1G' => "General Motors",
 		        '1J' => "Jeep",
 		        '1L' => "Lincoln",
 		        '1M' => "Mercury",
 		        '1N' => "Nissan",
		        '2F' => "Ford",
		        '2M' => "Mercury",
		        '2T' => "Toyota",
		        '3F' => "Ford",
		        '3G' => "General Motors",
		        '3N' => "Nissan",
		        '4F' => "Mazda",
		        '4J' => "Mercedes-Benz",
		        '4M' => "Mercury",
		        '4T' => "Toyota",
		        '5L' => "Lincoln",
		        '5T' => "Toyota",
		        '5U' => "BMW",
		        '5X' => "Hyundai/Kia",
		        '55' => "Mercedes-Benz",
		        '6F' => "Ford",
		        '6G' => "General Motors",
		        '6H' => "Holden",
  );

  my %manufacturer3 = (  AAV  => "Volkswagen",
                         AHT  => "Toyota",
                         AFA  => "Ford",
			'1G1' => "Chevrolet",
			'1G3' => "Oldsmobile",
			'1G4' => "Buick",
			'1G9' => "Google",
			'1GB' => "Chevrolet incomplete vehicles",
			'1GC' => "Chevrolet",
			'1GD' => "GMC incomplete vehicles",
			'1GM' => "Pontiac",
			'1HG' => "Honda",
  );

  return %manufacturer3{$wmi} // return %manufacturer2{$wmi.substr(0,2)} // "";
}

sub vin2year(VIN $vin)
{
  my %year = ( A => "1980,2010", B => "1981,2011", C => "1982,2012", D => "1983,2013",
               E => "1984,2014", F => "1985,2015", G => "1986,2016", H => "1987,2017",
	       J => "1988,2018", K => "1989,2019", L => "1990,2020", M => "1991,2021",
	       N => "1992,2022", P => "1993,2023", R => "1994,2024", S => "1995,2025",
	       T => "1996,2026", U => "1997,2027", V => "1998,2028", W => "1999,2029",
	       1 => "2001,2031", 2 => "2002,2032", 3 => "2003,2033", 4 => "2004,2034",
	       5 => "2005,2035", 6 => "2006,2036", 7 => "2007,2037", 8 => "2008,2038",
	       9 => "2009,2039", 0 => "1980");

  return %year{$vin.substr(9,1)} // "";
}

sub wmi2country (WMI $wmi)
{
  return %country1{$wmi.substr(0,1)} if $wmi.substr(0,1) eq any %country1.keys;
  return %country2{$wmi.substr(0,2)} if $wmi.substr(0,2) eq any %country2.keys;
  return;
}

sub verify-checksum(VIN $vin)
{
  my $check  = $vin.substr(8, 1);
  my $string = $vin.substr(0, 8) ~ $vin.substr(9);

  my %trans = ( A => 1, B => 2, C => 3, D => 4, E => 5, F => 6, G => 7, H => 8,
                J => 1, K => 2, L => 3, M => 4, N => 5,         P => 7,         Q => 9,
                R => 1, S => 2, T => 3, U => 4, V => 5, W => 6, X => 7, Y => 8, Z => 9,
                1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9, 0 => 0);

  my @weight = <8 7 6 5 4 3 2 10 9 8 7 6 5 4 3 2>;

  my $sum = 0;

  for ^$string.chars -> $index
  {
    my $trans = %trans{$string.substr($index,1)} // return False;
    my $value = $trans * @weight[$index];
    
    $sum += $value;
  }

  my $got = $sum mod 11;

  $got = "X" if $got == 10;

  return $check eq $got;  
}


multi sub MAIN (VIN $vin)
{
  say "Looks like a legal VIN. Checking if it is valid..";

  my $wmi = $vin.substr(0,3); # World Manufacturer Identifier
  my $vds = $vin.substr(3,6); # Vehicle Descriptor Section
  my $vis = $vin.substr(9,8); # Vehicle Identifier Section

  say "WMI: $wmi";

  my $country = wmi2country($wmi);

  unless $country
  {
    say "- Not a valid country";
    exit;
  }
  
  say "- Country: $country";
  
  my $manufacturer = wmi2manufacturer($wmi) || "Not implemented";

  say "- Manufacturer: $manufacturer";
  say "VDS: $vds";

  if $country eq any <China USA Canada Mexico>
  {
    if verify-checksum($vin)
    {
      say "- North American/China Checksum: OK.";
    }
    else
    {
      say "- Checksum: Failure.";
      exit;
    }
  }
  else
  {
    if verify-checksum($vin)
    {
      say "- Non-Mandatory Checksum verified.";
    }
    else
    {
      say "- Non-Mandatory Checksum failure.";
    }
  }

  say "VIS: $vis";
  
  my $year = vin2year($vin);
  
  unless $year
  {
    say "Not a valid year";
    exit;
  }

  say "- Year: $year";
}

multi sub MAIN (Str $vin)
{
  say "Not a legal VIN";
  say " - contains illegal character(s)" unless $vin ~~ /^ <VINCHAR> + $/;
  say " - wrong length ({ $vin.chars } instead of 17)" unless $vin.chars == 17;
}
