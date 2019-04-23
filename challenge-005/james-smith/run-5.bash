for i in 'small' 'large' 'huge' 'insane'
do
  echo '## '${i^};
  /usr/bin/time -f 'Time taken: %U (%C)' perl perl5/ch-2.pl /usr/share/dict/british-english-$i
  echo '';
done
