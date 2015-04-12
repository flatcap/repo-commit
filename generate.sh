#!/bin/bash

PATH="/usr/bin:/usr/sbin"

GIT_ROOT="/mnt/space/git"
AWK_FILE="list.awk"
HTML_FILE="list.html"
MAX_COUNT=100

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

DIRS=$(find "$GIT_ROOT" -name \*.git)

[ -z "$DIRS" ] && exit 1

for d in $DIRS; do
	REPO="${d%.git}"
	REPO="${REPO#$GIT_ROOT/}"
	GIT_DIR="$d" git --no-pager log --format="%cd	$REPO	%h	%s" --date=iso
done | sort -nr | head -n "$MAX_COUNT" | awk -f "$AWK_FILE" > "$HTML_FILE"

