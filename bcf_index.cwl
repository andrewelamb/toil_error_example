#!/usr/bin/env cwl-runner
#
# Authors: Andrew Lamb

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [bcftools, index]

doc: "Index VCF file"

hints:
  DockerRequirement:
    dockerPull: sort_and_normalize

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.vcf_file)

inputs:

  vcf_file:
    type: File
    inputBinding:
      position: 1

outputs:

  vcf_index:
    type: File
    outputBinding:
      glob: $(inputs.vcf_file.basename)
    secondaryFiles:
      - .csi

arguments:
  - valueFrom: $(inputs.vcf_file.basename + ".csi")
    position: 2


