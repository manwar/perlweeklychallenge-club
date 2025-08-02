#!/bin/sh
#
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause


set -e

def_cargo='cargo'

usage()
{
	cat <<EOUSAGE
Usage:	run-clippy.sh [-c cargo] [-n]
	-c	specify the Cargo command to use (default: $def_cargo)
	-n	also warn about lints in the Clippy "nursery" category
EOUSAGE
}

unset run_nursery
cargo="$def_cargo"

while getopts 'c:n' o; do
	case "$o" in
		c)
			cargo="$OPTARG"
			;;

		n)
			run_nursery=1
			;;

		*)
			usage 1>&2
			exit 1
			;;
	esac
done
shift "$((OPTIND - 1))"

# The list of allowed and ignored checks is synced with Rust 1.82.
set -x
"$cargo" clippy \
	--tests \
	-- \
	-W warnings \
	-W future-incompatible \
	-W nonstandard-style \
	-W rust-2018-compatibility \
	-W rust-2018-idioms \
	-W rust-2021-compatibility \
	-W unused \
	-W clippy::restriction \
		-A clippy::blanket_clippy_restriction_lints \
		-A clippy::std_instead_of_alloc \
		-A clippy::std_instead_of_core \
		-A clippy::implicit_return \
		-A clippy::missing_trait_methods \
		-A clippy::mod_module_files \
		-A clippy::question_mark_used \
		-A clippy::ref_patterns \
		-A clippy::self_named_module_files \
		-A clippy::semicolon_outside_block \
		-A clippy::separated_literal_suffix \
		-A clippy::single_call_fn \
	-W clippy::pedantic \
		-A clippy::module_name_repetitions \
	-W clippy::cargo \
	${run_nursery+-W clippy::nursery} \
	"$@"
