#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;

my $region = 'all';
my $o = GetOptions (
	'region=s' => \$region,
);
if ( !$o ) { print "Usage: ch-1.pl --region=[north|south|west|east|central|all or without option]\n"; exit 0; }
$region = lc( $region );

my %states = map{ chomp; /(\w[^;]+)/g;}<DATA>;

my $r = {
	north => ['Algeria', 'Egypt', 'Libya', 'Morocco', 'Sudan', 'Tunisia'],
	south => ['Botswana', 'Republic of South Africa', 'Lesotho', 'Namibia', 'Eswatini'],
	west => ['Benin', 'Burkina Faso', 'Cote d\'Ivoire', 'Gambia', 'Ghana', 'Guinea', 'Guinea-Bissau', 'Cabo Verde', 'Liberia', 'Mali', 'Mauritania', 'Niger', 'Nigeria', 'Senegal', 'Sierra Leone', 'Togo'],
	east => ['Burundi', 'Comoros', 'Djibouti', 'Eritrea', 'Ethiopia', 'Kenya', 'Madagascar', 'Malawi', 'Mauritius', 'Mozambique', 'Rwanda', 'Seychelles', 'Somalia', 'South Sudan', 'Tanzania', 'Uganda', 'Zambia', 'Zimbabwe'],
	central => ['Angola', 'Cameroon', 'Central African Republic', 'Chad', 'Democratic Republic of the Congo', 'Republic of the Congo', 'Equatorial Guinea', 'Gabon', 'Sao Tome and Principe']
};

my %region_states = defined $r->{$region} ? %states{@{$r->{$region}}} : %states;

my $l = ( length( ( sort { length( $b ) <=> length( $a ) } keys %region_states )[0] ) ) + 1 ;

print defined $r->{$region} ? "# Africa states and capitals : ".ucfirst $region." region\n" : "# Africa states and capitals\n" ;
print '# https://en.wikipedia.org/wiki/List_of_sovereign_states_and_dependent_territories_in_Africa', "\n\n";

map{ printf "% ${l}s  %s\n", $_, $region_states{$_} }sort keys %region_states;

__DATA__
Algeria;Algiers
Angola;Luanda
Benin;Porto-Novo
Botswana;Gaborone
Burkina Faso;Ouagadougou
Burundi;Gitega
Cabo Verde;Praia
Cameroon;Yaounde
Central African Republic;Bangui
Chad;N'Djamena
Comoros;Moroni
Democratic Republic of the Congo;Kinshasa
Republic of the Congo;Brazzaville
Cote d'Ivoire;Yamoussoukro
Djibouti;Djibouti
Egypt;Cairo
Equatorial Guinea;Malabo
Eritrea;Asmara
Eswatini;Lobamba
Ethiopia;Addis Ababa
Gabon;Libreville
Gambia;Banjul
Ghana;Accra
Guinea;Conakry
Guinea-Bissau;Bissau
Kenya;Nairobi
Lesotho;Maseru
Liberia;Monrovia
Libya;Tripoli
Madagascar;Antananarivo
Malawi;Lilongwe
Mali;Bamako
Mauritania;Nouakchott
Mauritius;Port Louis
Morocco;Rabat
Mozambique;Maputo
Namibia;Windhoek
Niger;Niamey
Nigeria;Abuja
Rwanda;Kigali
Sao Tome and Principe;Sao Tome
Senegal;Dakar
Seychelles;Victoria
Sierra Leone;Freetown
Somalia;Mogadishu
Republic of South Africa;Pretoria
South Sudan;Juba
Sudan;Khartoum
Tanzania;Dodoma
Togo;Lome
Tunisia;Tunis
Uganda;Kampala
Zambia;Lusaka
Zimbabwe;Harare
