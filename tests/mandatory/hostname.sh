#!/bin/bash
source "assert.sh"
assert [ "$(hostnamectl hostname)" = "welee42" ]
