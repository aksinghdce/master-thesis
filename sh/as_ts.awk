#!/bin/awk -f

{
    # remove leading dash
    str = substr($1, 2)
    # remove ms part
    str = substr(str, 1, length(str) - 5)

    print str
}
