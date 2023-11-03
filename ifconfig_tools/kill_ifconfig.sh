#!/bin/bash
ps -ef |grep ifconfig_loops.sh |grep -v grep |awk '{print $2}' | xargs kill -9
