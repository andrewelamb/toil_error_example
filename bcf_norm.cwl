#!/usr/bin/env cwl-runner
#
# Authors: Andrew Lamb

cwlVersion: v1.0
class: CommandLineTool

baseCommand: [bcftools, norm, -c, w, -O, z]

arguments:
  - prefix: "-o"
    valueFrom: $(inputs.vcf_file.path.split("/").slice(-1)[0].split(".").slice(0,-3).join(".") + ".normalized.vcf.gz") 

stderr: $(inputs.vcf_file.path.split("/").slice(-1)[0].split(".").slice(0,-3).join(".") + ".ref_mismatch.txt")

requirements:
- class: InlineJavascriptRequirement

hints:
  DockerRequirement:
    dockerPull: sort_and_normalize

inputs:

  ref_file:
    type: File
    inputBinding:
      position: 1
      prefix: -f
    secondaryFiles:
      .fai

  vcf_file:
    type: File
    inputBinding:
      position: 2
      
outputs: 

  norm_text:
    type: File
    outputBinding:
      glob: $(inputs.vcf_file.path.split("/").slice(-1)[0].split(".").slice(0,-3).join(".") + ".ref_mismatch.txt")

  normalized_vcf:
    type: File
    outputBinding:
      glob: $(inputs.vcf_file.path.split("/").slice(-1)[0].split(".").slice(0,-3).join(".") + ".normalized.vcf.gz")
      




