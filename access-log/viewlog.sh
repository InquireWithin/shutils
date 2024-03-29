#!/bin/bash
[[ ! $# -eq 1 ]] && echo "error: only 1 argument accepted" >&2 && echo "USAGE: $0 [arg]" && exit 1
./ac_summary.awk $1.log > $1.rpt
#header
cat $1.rpt | sed -nE -e '1,7p'
#body
cat $1.rpt | sed -E -e '1,7d' -e '180,187d' | sed -E -e 's/.*\s.*\s0//g' -e '/./!d'
#summary
cat $1.rpt | sed -nE -e '180,187p'

