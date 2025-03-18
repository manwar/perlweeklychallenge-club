#!/bin/sh
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

set -e

usage()
{
	cat <<'EOUSAGE'
Usage:  format.sh check
	format.sh reformat
	format.sh -h | -V | --help | --version
EOUSAGE
}

version()
{
	echo 'format.sh 0.1.0'
}

show_config()
{
	test -f .perltidyrc
	test -f .tidyallrc
	perltidy -dpro
}

cmd_check()
{
	set -x
	show_config
	tidyall -a --check-only
}

cmd_reformat()
{
	set -x
	show_config
	tidyall -a --no-backups
}

unset show_help show_version
while getopts 'hV-:' o; do
	case "$o" in
		h)
			show_help=1
			;;

		V)
			show_version=1
			;;

		-)
			case "$OPTARG" in
				help)
					show_help=1
					;;

				version)
					show_version=1
					;;

				*)
					echo "Unrecognized long option '--$OPTARG'" 1>&2
					usage 1>&2
					exit 1
					;;
			esac
			;;

		*)
			usage 1>&2
			exit 1
			;;
	esac
done
shift "$((OPTIND - 1))"

[ -z "$show_version" ] || version
[ -z "$show_help" ] || usage
[ -z "$show_version$show_help" ] || exit 0

if [ "$#" -lt 1 ]; then
	echo 'No subcommand specified' 1>&2
	usage 1>&2
	exit 1
fi
cmd="$1"
shift
case "$cmd" in
	check)
		cmd_check "$@"
		;;

	reformat)
		cmd_reformat "$#"
		;;

	*)
		echo "Unrecognized subcommand '$cmd' specified" 1>&2
		usage 1>&2
		exit 1
		;;
esac
