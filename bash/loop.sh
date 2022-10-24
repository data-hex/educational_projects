while [ 1 ]
do
    echo "enter your name:"
    read name
    if [[ -z $name ]]
    then
        break
    fi
    echo "enter your age:"
    read age
    if [[ $age -eq 0 ]]
    then
        break
    elif [[ $age -le 16 ]]
    then
        category=child
    elif [[ $age > 16 && $age < 26 ]]
    then
        category=youth
    else
        category=adult
    fi
    echo "$name, your group is $category"
    done
echo "bye"
