perl -e '$|++; while (1) { printf "\r%02d:%02d:%02d", (localtime)[2,1,0]; sleep 1; }'
