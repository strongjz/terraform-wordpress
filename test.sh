while  ! [ -x "$(command -v foo)" ]
do 
  echo 'Error: git is not installed.' >&2 
  sleep 5
done
