#! /bin/sh

FILENAME="rank__2.txt"
`redis-cli ZREVRANGE rank__2 0 99 > $FILENAME`
echo "generate file $FILENAME"
for line in `cat $FILENAME`
do
    echo $line \
    `redis-cli --raw get "charbase_"$line"_name"` \
    `redis-cli --raw get "charbase_"$line"_level"`
done
