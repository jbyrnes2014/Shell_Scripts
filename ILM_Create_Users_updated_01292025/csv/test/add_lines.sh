#for n in $(cat csv/users8.csv)

	filename=$(cat users.csv)
#do
#mv “$i” echo "$i" | tr ' ' '-'
#donei


ls | while read filename
do
echo “$filename” | grep " " >/dev/null 2>&1
if [ $? -eq 0 ]
then
newfilename=echo "$filename" | tr " " "-"
mv “$filename” $newfilename
echo “renamed “$filename” to “$newfilename””
fi
done
