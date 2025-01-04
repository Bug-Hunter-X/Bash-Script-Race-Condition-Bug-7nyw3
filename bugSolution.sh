#!/bin/bash

# This script demonstrates a solution to the race condition bug using flock.

# Create two files
touch file1.txt
touch file2.txt

# Create a function to append text to a file with locking
append_to_file() {
  local file=$1
  local text=$2
  flock -n "$file" || exit 1 # Acquire exclusive lock or exit
  echo "$text" >> "$file"
  flock -u "$file" # Unlock the file
}

# Run two background processes to append text to the files simultaneously
append_to_file file1.txt "Line 1 from process 1"
&
append_to_file file2.txt "Line 1 from process 2"
&

# Wait for both processes to finish
wait

# Check the content of the files
cat file1.txt
cat file2.txt