# Promiscuous-Binding-Peptides---Database
This repository contains the scripts used to perform the molecular dynamics simulations including home bash script and gromacs commands. This research article is titled as "Promiscuous Binding Peptides - Computational Screening Reveals Higher-Affinity Peptides  for Gold Binding Beyond Phage Display Selections".

**Abstract** for the article is as follows:
Peptides that selectively bind to inorganic surfaces play a crucial role in nanobiotechnology, biomaterials, and biosensing applications. While phage display has been the predominant method for identifying such peptides, its selection process is influenced by propagation biases and experimental constraints, which may lead to the exclusion of peptides with superior binding affinity. In this study, we implement a molecular dynamics (MD) simulation to systematically assess the binding affinity of 46 solid-binding peptides (SBPs), which were manually curated from literature with previously identified affinities to various surfaces to Au(111). We perform a comprehensive analysis, including interaction energy calculations, root mean square deviation and distance of each residue with Au(111) to elucidate the molecular determinants of solid binding peptide-Au(111) interactions. Our results reveal that while phage display-derived peptides exhibit affinity, several peptides not previously categorized as Au(111)-binding show stronger affinity than the experimentally identified gold-binding sequences. We propose the term "promiscuous binding peptides" to describe these sequences, which demonstrate high affinity for surfaces beyond their original selection targets. Our findings highlight the limitations of experimental selection techniques and emphasise the potential of computational screening in identifying higher-affinity peptides towards the target metal interfaces. This study establishes a foundation for advancing the rational design of functional surface-binding peptides.

**This repository contains:**
1. A README and a small note on how to use the script and which script belongs to which step of the MD Simulation.
2. All the required scripts including tleap.sh, pep-equilibration.sh, pep-surf.sh, system.sh and analysis.sh
3. All the python scripts written for performing the analysis including
4. All the parameters files (.mdp files) which were used to perform the simulations.

**NOTE**
pep-surface.sh file contains TCL script also which can used in VMD using the command: vmd -dispdev text -e <file_name.tcl>

**NOTE**
The bash scripts written by us are according to our folders made for our convience. Any other replicating our method should look at that.
