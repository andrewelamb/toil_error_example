#!/usr/bin/env cwl-runner
#
# Authors: Andrew Lamb

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [bcftools, stats]

stdout: $(inputs.vcf_file.path.split("/").slice(-1)[0].split(".").slice(0,-2).join(".") + ".stats.txt")

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

  stats_text:
    type: File
    outputBinding:
      glob: $(inputs.vcf_file.path.split("/").slice(-1)[0].split(".").slice(0,-2).join(".") + ".stats.txt")
    doc: see output_string



