#!/bin/bash

# ## full + aug
# hs=full
# tbl=std
# d_type="_augment"

# ## - aug
hs=full
tbl=std
d_type="_augment/"

## - aug - table
# hs=full
# tbl=no
# d_type=""

# ## - aug - table -history
# hs=no
# tbl=no
# d_type=""


# epoch=1 # 600 for spider, 200 for +aug

DATE=`date '+%Y-%m-%d-%H-%M-%S'`

data_root=generated_datasets/generated_data${d_type}
save_dir="saved_models_hs${DATE}"
log_dir="train_log"
mkdir -p ${save_dir}
mkdir -p ${log_dir}
mkdir -p ${log_dir}/train${d_type}

export CUDA_VISIBLE_DEVICES=2
module=col
epoch=600
/data4/tong.guo/Py36/bin/python3 train.py \
  --data_root    ${data_root} \
  --save_dir     ${save_dir} \
  --history_type ${hs} \
  --table_type   ${tbl} \
  --train_component ${module} \
  --epoch        ${epoch} \
  > "${log_dir}/train${d_type}${DATE}.txt" \
  2>&1 &

export CUDA_VISIBLE_DEVICES=3
epoch=300
for module in multi_sql keyword op agg root_tem des_asc having andor
do
  /data4/tong.guo/Py36/bin/python3 train.py \
    --data_root    ${data_root} \
    --save_dir     ${save_dir} \
    --history_type ${hs} \
    --table_type   ${tbl} \
    --train_component ${module} \
    --epoch        ${epoch} \
    > "${log_dir}/train${d_type}${DATE}.txt" \
    2>&1 &
done
