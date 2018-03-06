grep BSCS9MIG *sql| sed 's/.*DATAFILE//' |\
sed 's/.*\/ora\/\(.*\)\/BSCS.*SIZE \(.*\)G.*/\1 \2/' | sort |\
awk 'BEGIN { tot_size[""]=0 } {if (user!=$1) {print user " total size " tot_size[user]}; user=$1; size=$2; tot_size[user]+=size; }'
