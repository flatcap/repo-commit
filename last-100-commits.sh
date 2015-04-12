#!/bin/bash

PATH="/usr/bin:/usr/sbin"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

cd /mnt/space/2015-04-12_git

DIRS=$(find . -name \*.git | LANG=C sort | cut -b3-)

[ -z "$DIRS" ] && exit 1

for d in $DIRS; do
	pushd $d > /dev/null
	echo $d
	git --no-pager log --format="%cd	${d%.git}	%h	%s" --date=iso
	popd > /dev/null
done | sort -nr | head -100 | column -t -s $'\t' | cut -b 1-16,26-

