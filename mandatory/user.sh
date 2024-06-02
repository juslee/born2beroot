#!/bin/bash
usermod -aG sudo welee
groupadd user42
usermod -aG user42 welee
