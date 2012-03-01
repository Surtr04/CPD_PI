#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Usage:"
	echo "	gprof_simul <folder>"
	echo "	folder - folder name to be created inside simulations to generate input/output"
	echo "	folder/gprof will also be created to save gprof results"
	exit 1
fi

MODE=$(cat MODE)
REQUIRED="GPROF"
if [ $MODE != $REQUIRED ]; then
	echo "requires mode: $REQUIRED"
	echo "current  mode: $MODE"
	read -p "recompile? [yn] " yn
	case $yn in
		[Yy])
			(cd $(cat PATH); make clean; make MODE=$REQUIRED)
			;;
		*)
			echo "aborting"
			exit 1
	esac
fi


TIMESTAMP=$(date +%m.%d_%H:%M:%S)

ROOT=.
OUTPUT_DIR=$ROOT/$MODE\_$TIMESTAMP\_$1
GPROF_DIR=$OUTPUT_DIR/gprof
INPUT_DIR=$ROOT/default_data

GPROF2DOT=gprof2dot.py

# creates folder structure
mkdir $GPROF_DIR -p

# copy input data
echo " --- Copying data"
cp -fv $INPUT_DIR/{foz.geo,foz.msh} $OUTPUT_DIR/
cp -fv $INPUT_DIR/foz.xml $ROOT


echo
echo " --- generating velocity.xml"
$ROOT/velocity
echo " --- generating polu.xml"
$ROOT/polu

mv foz.xml velocity.xml polution.xml $OUTPUT_DIR

echo " --- profiling polu"
gprof polu > $GPROF_DIR/polu.gprof
cat $GPROF_DIR/polu.gprof | $GPROF2DOT | dot -Tpng -o $GPROF_DIR/polu.png