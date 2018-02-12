#!/bin/bash
myvar='Hello World'
echo $myvar
# Hello World

newvar="More $myvar"
echo $newvar
# More Hello World

newvar='More $myvar'
echo $newvar
# More $myvar
