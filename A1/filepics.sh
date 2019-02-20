#!/bin/sh

export PATH=$PATH:/courses/courses/cscb09w19/bin
if [ $# -eq 0 ] 
then
    echo "Missing input" >&2
    exit 0
fi

if [ $# -gt 1 ] 
then
    echo "Only 1 argument should be given" >&2
    exit 0
fi


if [ ! -d $1 ] 
then
    echo "$1 is Not a directory" >&2
   
else
    for i in $1/*
    do
        
        if [ -f "$i" ] && file "$i" | grep -iq jpeg
        then

            if image_info=$(exiftime -tg "$i")
            then 
                year=`echo $image_info | cut -c 18-21`
                month=`echo $image_info | cut -c 23-24`

                mkdir -p "$PWD/$year/$month"
                mv "$PWD/$i" "$PWD/$year/$month"
            else

                echo "no data for $i" >&2
            fi
            
            

            
        else
            echo "$i is not a jpeg file"
        fi
    done 


fi
