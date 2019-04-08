#!/bin/bash

# Going the easiest here
cat | perl -pE 's/^[^-.]0+//'
