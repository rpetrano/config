#!/bin/bash

IFS=$'\n'

left=''
while read i; do
    case "${i:0:3}" in
        [[:space:]]*)
            jack_connect "$left" "${i:3}"
            ;;
        *)
            left="$i"
            ;;
        esac
done < ~/jack_connections

