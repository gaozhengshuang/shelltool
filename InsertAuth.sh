#!/bin/bash

find ./ -type f -iname "*.go" -exec sed -i '1i/// @file '\{\}'\n''/// @brief\n/// @author jackytse, xiejian1998@foxmail.com\n/// @version 1.0\n/// @date 2017-11-01\n' \{\} \;
