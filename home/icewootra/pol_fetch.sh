#!/bin/bash

curl "http://repository.playonlinux.com/V4_data/repository/get_file.php?version=playonlinux-4&id=$1" | vim -
