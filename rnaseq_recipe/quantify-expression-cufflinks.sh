#!/bin/bash
# quantify-expression-cufflinks.sh

script_name="quantify-expression-cufflinks.sh"
script_ver="1.0.0"

#Help function
usage() {
  echo "-h  --Help documentation for $script_name"
  echo "-o  --Path to the output directory"
  echo "-a  --File path to alignment"
  echo "-g  --File path to merged transcripts"
  echo "-v  --Version of script"
  echo "Example: $script_name -o 'experiment_152_merge' -a '/path/to/alignment/foo_rep1.bam' -g '/path/to/merged.gtf'"
  exit 1
}

# Version function
version(){
    echo "$script_name $script_ver"
    exit 1
}

main(){

    # Load required modules
    module load cufflinks/2.2.1
    module load python/2.7.x-anaconda

    # Parsing options
    OPTIND=1 # Reset OPTIND
    while getopts :o:a:g:vh opt
        do
            case $opt in
                o) out=$OPTARG;;
                a) alignment=$OPTARG;;
                g) transcript=$OPTARG;;
                v) version;;
                h) usage;;
            esac
        done

    shift $(($OPTIND -1))

    # Check for mandatory options
    if [[ -z $out ]] || [[ -z $alignment ]] || [[ -z $transcript ]]; then
        usage
    fi

    # Make Out directory if doesn't exist
    if [ ! -e $out ]; then
        mkdir $out
    fi

    # Compare expression if not already done so
    alignment_fn=$(basename "${alignment}")
    out_dir=$out\/$script_name-$script_ver
    if [ ! -e $out_dir/$alignment_fn.abundances.cxb ]; then

        echo "* Value of alignment: '$alignment_fn'"
        echo "* Quantify Expression... "
        cuffquant -p 10 --library-type fr-firststrand  -o $out_dir $transcript $alignment

        # Rename abundances.cxb file
        mv $out_dir\/abundances.cxb $out_dir\/$alignment_fn.abundances.cxb

        # Get input and output files and then print out metadata.json file
        input_files=("$alignment" "$transcript")
        printf -v input "\"%s\"," "${input_files[@]}"
        input=${input%,}
        output_file=($out_dir\/$alignment_fn.abundances.cxb)
        printf -v output "\"%s\"," "${output_file[@]}"
        output=${output%,}
        printf '{"script name":"%s","script version":"%s", "input files": [%s], "output files": [%s]}' "$script_name" "$script_ver" "$input" "$output"  | python -m json.tool > $out_dir\/$alignment_fn.metadata.json
        echo "* Finished."
    else
        echo "* Expression quantifying has been made."
    fi
}

main "$@"
