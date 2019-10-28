#! /bin/bash
cat "$@" | sort | uniq -c | sort -nr
