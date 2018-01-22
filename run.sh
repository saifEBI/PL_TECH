#!/bin/sh

R --vanilla < script.R
java -Xmx10G  -jar parse_atlas_file.jar output_file > final_matrix.txt
