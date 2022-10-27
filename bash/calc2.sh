#!/bin/bash

re='^[0-9]+$'
symbols='[\+\/\*-\%**]'
calc () { let "value = $1 $2 $3" && echo $value; }

while [ 1 == 1 ]
do
    read -a data
    if [[ ${data[0]} =~ "exit" ]]
    then
        echo "bye"
        break
    elif [[ ${data[0]} =~ $re && ${data[1]} =~ $symbols && ${data[2]} =~ $re ]]
    then
        echo `calc ${data[0]} "${data[1]}" ${data[2]}`
    else
        echo "error"
        break
    fi
done
