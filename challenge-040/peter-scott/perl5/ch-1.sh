#!/bin/sh
cat <<'EOF' > /tmp/arrays
I L O V E Y O U
2 4 0 3 2 0 1 9
! ? £ $ % ^ & *
EOF
perl -lane '$i=0; push @{$x[$i++]}, $_ for @F; END{print "@$_" for @x}' /tmp/arrays
