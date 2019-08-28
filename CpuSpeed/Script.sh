#!/bin/sh

#  Script.sh
#  CpuSpeed
#
#  Created by Fredrik Sellgren on 2019-08-22.
#  Copyright © 2019 Fredrik Sellgren. All rights reserved.

CPU=$(top -l 2 -n 0 -F | egrep -o ' \d*\.\d+% idle' | tail -1 | awk -F% -v prefix="$prefix" '{ printf "%s%.1f%%\n", prefix, 100 - $1 }')
echo $CPU
