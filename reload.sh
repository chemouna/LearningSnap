#!/bin/bash
ps aux | grep [h]askellcourses | awk '{print $2}' | xargs kill
echo 0


