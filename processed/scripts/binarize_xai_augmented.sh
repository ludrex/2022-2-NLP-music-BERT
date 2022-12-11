#!/bin/bash
#

[[ -z "$1" ]] && { echo "PREFIX is empty" ; exit 1; }
PREFIX=$1
[[ -d "${PREFIX}_data_bin_apex_reg_cls_augmented" ]] && { echo "output directory ${PREFIX}_data_bin_apex_reg_cls_augmented already exists" ; exit 1; }
i=0
	echo "Processing fold $i"
	mkdir -p ${PREFIX}_data_bin_apex_reg_cls_augmented/$i
	fairseq-preprocess \
	    --only-source \
	    --trainpref ${PREFIX}_data_raw_apex_reg_cls_augmented/$i/train.txt \
	    --validpref ${PREFIX}_data_raw_apex_reg_cls_augmented/$i/test.txt \
	    --destdir ${PREFIX}_data_bin_apex_reg_cls_augmented/$i/input0 \
	    --srcdict ${PREFIX}_data_raw_apex_reg_cls_augmented/$i/dict.txt \
	    --workers 24
	fairseq-preprocess \
	    --only-source \
	    --trainpref ${PREFIX}_data_raw_apex_reg_cls_augmented/$i/train.label \
	    --validpref ${PREFIX}_data_raw_apex_reg_cls_augmented/$i/test.label \
	    --destdir ${PREFIX}_data_bin_apex_reg_cls_augmented/$i/label \
	    --workers 24
	cp ${PREFIX}_data_raw_apex_reg_cls_augmented/$i/train.label ${PREFIX}_data_bin_apex_reg_cls_augmented/$i/label/train.label
	cp ${PREFIX}_data_raw_apex_reg_cls_augmented/$i/test.label ${PREFIX}_data_bin_apex_reg_cls_augmented/$i/label/valid.label
echo "Done"
