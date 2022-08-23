#!/bin/sh

perl -MLingua::EN::Numbers=num2en_ordinal -E "say num2en_ordinal $1"
