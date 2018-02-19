#!/usr/bin/env cwl-runner
#
# Authors: Andrew Lamb

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [vcf-sort, -c]

stdout: $(inputs.vcf_file.path.split("/").slice(-1)[0].split(".").slice(0,-1) + ".sorted.vcf")

requirements:
- class: InlineJavascriptRequirement

hints:
  DockerRequirement:
    dockerPull: sort_and_normalize


inputs:

  vcf_file:
    type: File
    inputBinding:
      position: 1
    doc: Path to vcf file
    
outputs:

  sorted_vcf:
    type: File
    outputBinding:
      glob: $(inputs.vcf_file.path.split("/").slice(-1)[0].split(".").slice(0,-1) + ".sorted.vcf")