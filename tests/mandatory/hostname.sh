#!/bin/bash
source "assert.sh"
assert [ "$(hostnamectl hostname)" eq "welee42" ] "Hostname is not welee42"
