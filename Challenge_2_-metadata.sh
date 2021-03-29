metadata_url='http://169.254.169.254/latest/meta-data/'
metadata=`curl -s $metadata_url`
meta_arr=( $metadata )
meta_len=${#meta_arr[@]}
rm -rf  myfile.json
echo '{' > myfile.json
i=0
for x in $metadata; do
        i=$((i+1))
        value=`curl -s $metadata_url/$x`
        if [ $i == $meta_len ]; then
                echo "\""$x"\":\""$value"\"" >> myfile.json
        else
                echo "\""$x"\":\""$value"\"," >> myfile.json
        fi

done

echo '}' >> myfile.json