#!/usr/bin/env cwl-runner
#
# Authors: Andrew Lamb

cwlVersion: v1.0
class: Workflow

requirements:
- class: MultipleInputFeatureRequirement

inputs:
  VCF_FILE: File

outputs:

  OUTPUT_ARRAY:
    type:
      type: array
      items: File
    outputSource: [bgzip_vcf/sorted_bgzip_vcf, index_sorted_vcf/vcf_index]

steps:

  sort_vcf:
    run: vcf_sort.cwl
    in: 
      vcf_file: VCF_FILE
    out: [sorted_vcf]

  bgzip_vcf:
    run: bgzip.cwl
    in: 
      vcf_file: sort_vcf/sorted_vcf
    out: [sorted_bgzip_vcf]
    
  index_sorted_vcf:
    run: bcf_index.cwl
    in: 
      vcf_file: bgzip_vcf/sorted_bgzip_vcf
    out: [vcf_index]