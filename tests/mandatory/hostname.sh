#!/bin/bash
source "assert.sh"
assert [ "$(hostnamectl hostname)" = "welee42" ] "Hostname is not welee42"
