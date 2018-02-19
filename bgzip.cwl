#!/usr/bin/env cwl-runner
# https://github.com/genome/cancer-genomics-workflow/blob/master/detect_variants/bgzip.cwl
# Authors: Andrew Lamb

cwlVersion: v1.0
class: CommandLineTool
label: "bgzip VCF"
baseCommand: ["bgzip"]
requirements:
    - class: InlineJavascriptRequirement
    - class: DockerRequirement
      dockerPull: sort_and_normalize
      
stdout: $(inputs.vcf_file.basename).gz
arguments: ["-c"]

inputs:
  vcf_file:
    type: File
    inputBinding:
      position: 1
      
outputs:
  sorted_bgzip_vcf:
    type: stdout
