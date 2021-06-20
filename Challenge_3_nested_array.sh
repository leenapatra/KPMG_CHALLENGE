# define the array
nested_array={"a":{"b":{"c":"d"}}}

#define the input
input_key="d"

# split the array to fetch object and arrange in key value pair.
IFS=":" read -ra obj <<< "${nested_array}"
length=${#obj[@]}
#echo "length>>" $length
#echo "object >>>" ${obj[@]}
key_arr=()
for (( x=0; x<$length; x++ )); do
        key_obj=${obj[$x]}
        key=( $key_obj )
        key=$(echo $key | sed 's/{//g')
        key=$(echo $key | sed 's/"//g')
        key=$(echo $key | sed 's/}//g')
        key_arr+=($key)
        #echo "after>>" $key
done


#echo ${key_arr[@]}

# now loop against the array created above to compare current key in loop vs the keep that was input.
# if matched, it will consider current key as the primary key and data byond that as value.
for (( i=0; i<$length; i++ )); do
        IFS=":" read -r key1 value1 <<< "$nested_array"
        #nested_array=$value1
        #echo $value1
        current_key=${key_arr[$i]}
        #echo "Input vs Current>>"$input_key"--"$current_key
        if [[ "$input_key" = "$current_key" ]]; then
                echo "It Matched"
                echo "Value is >>" $value1
        else
                nested_array=$value1
                echo "No Matched"
        fi
        #echo ${key_arr[$i]}
done
