#!/usr/bin/env cwl-runner
#
# Authors: Andrew Lamb

cwlVersion: v1.0
class: Workflow

requirements:
- class: MultipleInputFeatureRequirement

inputs:
  VCF_FILE: File
  REF_FILE: File

outputs:

  OUTPUT_ARRAY:
    type:
      type: array
      items: File
    outputSource: [bgzip_vcf/sorted_bgzip_vcf, index_sorted_vcf/vcf_index, stats_sorted_vcf/stats_text, normalize_sorted_vcf/normalized_vcf, normalize_sorted_vcf/norm_text, index_normalized_vcf/vcf_index, stats_vcf/stats_text]

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

  stats_sorted_vcf:
    run: bcf_stats.cwl
    in: 
      vcf_file: bgzip_vcf/sorted_bgzip_vcf
    out: [stats_text]
    
  normalize_sorted_vcf:
    run: bcf_norm.cwl
    in: 
      ref_file: REF_FILE
      vcf_file: bgzip_vcf/sorted_bgzip_vcf
    out: [normalized_vcf, norm_text]
    
  index_normalized_vcf:
    run: bcf_index.cwl
    in: 
      vcf_file: normalize_sorted_vcf/normalized_vcf
    out: [vcf_index]
    
  stats_vcf:
    run: bcf_stats2.cwl
    in: 
      vcf_file: index_sorted_vcf/vcf_index
      vcf_file2: index_normalized_vcf/vcf_index
    out: [stats_text]