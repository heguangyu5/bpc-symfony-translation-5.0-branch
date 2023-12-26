#!/bin/bash

[[ "$1" == "" ]] && {
    echo "Usage: ./bpc-prepare.sh src.list"
    exit
}

rm -rf ./Symfony/Component
mkdir -p ./Symfony/Component/Translation
rsync -a                        \
      --exclude=".*"            \
      -f"- Symfony/"            \
      -f"+ */"                  \
      -f"- *"                   \
      ./                        \
      ./Symfony/Component/Translation

echo "placeholder-component-translation.php" > ./Symfony/src.list

for i in `cat $1`
do
    if [[ "$i" == \#* ]]
    then
        echo $i
    else
        echo "Component/Translation/$i" >> ./Symfony/src.list
        filename=`basename -- $i`
        if [ "${filename##*.}" == "php" ]
        then
            echo "phptobpc $i"
            phptobpc $i > ./Symfony/Component/Translation/$i
        else
            echo "cp       $i"
            cp $i ./Symfony/Component/Translation/$i
        fi
    fi
done
cp bpc.conf Makefile ./Symfony/
