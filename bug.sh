#!/bin/bash

# This script demonstrates a race condition bug.

# Create two files
touch file1.txt
touch file2.txt

# Create a function to append text to a file
append_to_file() {
  local file=$1
  local text=$2
  echo "$text" >> "$file"
}

# Run two background processes to append text to the files simultaneously
append_to_file file1.txt "Line 1 from process 1"
& # Background process
append_to_file file2.txt "Line 1 from process 2"
&

# Wait for both processes to finish
wait

# Check the content of the files
cat file1.txt
cat file2.txt