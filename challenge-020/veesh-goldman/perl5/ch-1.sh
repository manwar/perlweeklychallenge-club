#!/bin/bash

perl -pE'split / /, s/(.) \g1*/$& /gx'
