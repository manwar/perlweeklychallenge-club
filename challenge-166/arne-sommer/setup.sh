#! /bin/sh

mkdir dir_a dir_a/Old_Fonts/ dir_b dir_c 
cd dir_a
touch  Arial.ttf  Comic_Sans.ttf  Georgia.ttf  Helvetica.ttf  Impact.otf  Verdana.ttf

cd ../dir_b
touch Arial.ttf  Comic_Sans.ttf  Courier_New.ttf  Helvetica.ttf  Impact.otf  Tahoma.ttf  Verdana.ttf

cd ../dir_c
touch Arial.ttf  Courier_New.ttf  Helvetica.ttf  Impact.otf  Monaco.ttf  Verdana.ttf
