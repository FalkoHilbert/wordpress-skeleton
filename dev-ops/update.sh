#!/usr/bin/env bash

source $(dirname "$0")/functions.sh

wp core update-db --path="$__WPPath__"
