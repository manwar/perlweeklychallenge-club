#!/usr/bin/python
#===============================================================================
#
#         FILE: 10801.py
#
#        USAGE: ./10801.py  
#
#  DESCRIPTION: Store a scalar and print the memory address of it
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 18/04/21
#===============================================================================
i = 5
print ('i is stored at address ' + str (hex (id (i))))
