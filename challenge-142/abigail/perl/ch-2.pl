#
# To do this, we need two things:
#
#  1.  A perl with threads compiled in.
#  2.  A machine with a real-time OS (Windows, and almost all Unices,
#            including Linux and MacOs will not do).
#
# 2. is necessary because the algorithm critically depends on sleeping
# for an exact amount of time. Most OSses cannot do this. I don't even
# know whether perl runs on any OS which can sleep an exact amount of time.
#
# I'm not even going to bother recompiling my perl to implement some
# stupid joke. Let alone buy another box.
#

die "$^O will not do.\n";
