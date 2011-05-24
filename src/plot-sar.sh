#!/bin/bash

# place this script in your path, then...
# 1. user sargather to collect statistics into a directory e.g. foo
# 2. cd foo
# 3. plot-sar.sh
# 4. eog *.png &
#
# dependencies: gnuplot sargather python

/usr/share/pm-plots/plot-block
/usr/share/pm-plots/plot-context-switches
/usr/share/pm-plots/plot-cpu_stats
/usr/share/pm-plots/plot-disk-util
/usr/share/pm-plots/plot-interrupts
/usr/share/pm-plots/plot-io
/usr/share/pm-plots/plot-memory
/usr/share/pm-plots/plot-network
/usr/share/pm-plots/plot-network-errors
/usr/share/pm-plots/plot-paging
/usr/share/pm-plots/plot-sockets
