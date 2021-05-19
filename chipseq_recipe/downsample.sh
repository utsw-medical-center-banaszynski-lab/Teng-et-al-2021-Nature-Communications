#!/bin/bash
# downsample.sh


script_name="downsample.sh"
script_ver="1.1.0"

#Help function
usage() {
  echo "-h Help documentation for $script_name"
  echo "-a  --Path to bam file"
  echo "-p  --Probability of reads to keep"
  echo "-o  --Path to output directory"
  echo "-v  --Version of script"
  echo "Example: $script_name -a 'foo_1.bam' -p 1  [-o '/path/to/output/dir/']"
  exit 1
}

# Version function
version(){
    echo "$script_name $script_ver"
    exit 1
}

main(){
module load picard/2.10.3
module load samtools/1.6

# Parsing options
    OPTIND=1 # Reset OPTIND
    while getopts :a:p:o:vh opt
        do
            case $opt in
                a) aln_file=$OPTARG;;
                p) probability=$OPTARG;;
                o) out=$OPTARG;;
                v) version;;
                h) usage;;
            esac
        done

    shift $(($OPTIND -1))

# Check for mandatory options
    if [[ -z $aln_file ]] || [[ -z $probability ]];  then
        usage
    fi
    if [ -z $out ]; then
        one_parent=$(dirname "${aln_file}")
        out_dir=$(dirname "${one_parent}")\/$script_name-$script_ver/
    else
        out_dir=$out\/$script_name-$script_ver
    fi

    if [ ! -d $out_dir ]; then
        mkdir $out_dir
    fi

# Define the output file name, based on the file
    raw_fn=$(basename "${aln_file}" .bam)
    output_fp=${raw_fn}

java -Xmx4G -jar $PICARD/picard.jar DownsampleSam I=$aln_file O=$out_dir/$output_fp.downsampled.bam RANDOM_SEED=1 P=$probability VALIDATION_STRINGENCY=LENIENT M=$out_dir/$output_fp.downsampled.txt
samtools index $out_dir/$output_fp.downsampled.bam $out_dir/$output_fp.downsampled.bai

}

main "$@"


