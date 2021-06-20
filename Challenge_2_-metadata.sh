#This Script has to be executed from an EC2 Instance. The URL Mentioned below is the one that returns the instance metadata

#line 4 to line 7 gets the instance metadata and stores in an array for processing
metadata_url='http://169.254.169.254/latest/meta-data/'
metadata=`curl -s $metadata_url`
meta_arr=( $metadata )
meta_len=${#meta_arr[@]}

#remove any existing file and then process
rm -rf  myfile.json

#start building your json.
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

cat myfile.json
