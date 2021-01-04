#!/bin/bash

# Exlore using grep in bash scripts
# 01/03/20  Updated
# 01/03/20  Created

# grep a string
str='hello world'
grep 'hello' <<< $str
echo $?

