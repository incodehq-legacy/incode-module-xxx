if [ $# -lt 1 ]; then
    echo "usage: `basename $0` [NewNameUpperCase]" >&2
    exit 1
fi

FROM_UPPER="Xxx"
FROM_LOWER=`echo ${FROM_UPPER} | tr "[:upper:]" "[:lower:]"`

TO_UPPER=$1
TO_LOWER=`echo ${TO_UPPER} | tr "[:upper:]" "[:lower:]"`

echo "FROM_UPPER = ${FROM_UPPER}"
echo "FROM_LOWER = ${FROM_LOWER}"
echo "TO_UPPER = ${TO_UPPER}"
echo "TO_LOWER = ${TO_LOWER}"

echo
echo "renaming directories..."
echo

for a in `find . -type d | grep "${FROM_LOWER}$" | grep -v target`
do 
    b=`echo $a | sed "s/${FROM_LOWER}/${TO_LOWER}/g" | sed "s/${FROM_UPPER}/${TO_UPPER}/g"`
    echo $a
    echo $b
    mv $a $b
    echo ""
done


echo
echo "renaming files..."
echo

for a in `find . -type f | grep ${FROM_UPPER} | grep -v target | grep -v _rename_xxx.sh`
do 
    b=`echo $a | sed "s/${FROM_UPPER}/${TO_UPPER}/g"`
    echo $a
    echo $b
    mv $a $b
done

for a in `find . -type f | grep ${FROM_LOWER} | grep -v target | grep -v _rename_xxx.sh`
do 
    b=`echo $a | sed "s/${FROM_LOWER}/${TO_LOWER}/g"`
    echo $a
    echo $b
    mv $a $b
done


echo
echo "editing files..."
echo

for a in `find . -type f | egrep "(\.java|\.xml|\.properties|\.ini|\.sh|\.adoc)$" | grep -v target | grep -v "\.git" | grep -v _rename_xxx.sh`
do 
    echo $a
    cat $a | sed "s/${FROM_UPPER}/${TO_UPPER}/g" | sed "s/${FROM_LOWER}/${TO_LOWER}/g" > /tmp/1.$$
    mv /tmp/1.$$ $a
done
