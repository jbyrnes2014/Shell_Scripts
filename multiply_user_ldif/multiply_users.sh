## define end value ##
file=$(cat users.csv)

END=5
## print date five times ##
x=$END 
while [ $x -gt 0 ]; 
do 
  echo -e "$file" >> users_list.csv

  x=$(($x-1))
done

sed -n '1,300p' users_list.csv > users_list-C.csv

