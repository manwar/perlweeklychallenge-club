#!/usr/bin/env python
#===============================================================================
#
#         FILE: 12101.py
#
#        USAGE: ./12101.py M N 
#
#  DESCRIPTION: Invert the Nth least significant bit of number M and output.
#
#        NOTES: No input validation - GIGO.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 17/07/21
#===============================================================================

import sys
print (int(sys.argv[1]) ^ 2 ** (int(sys.argv[2]) - 1))
