#!/bin/bash

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46; do
    folder="peptide-$i"
    
    cd "$folder"
    #cd replica-1
    cd analysis/
    rm -r mmpbsa
    mkdir mmpbsa
    cd mmpbsa
    cp ../energy/Sum-surf-prot.xvg .
    cp ../../../100frames.py .

    python3 100frames.py
    #cd ../../
    #cp analysis/energy/fr.ndx .
    

    echo 0 | gmx trjconv -f ../../production.xtc -s ../../production.tpr -o frame.xtc -fr fr.ndx

    cp ../../../pbsa-new.mdp .
    /home/system/miniconda3/bin/g_mmpbsa run -i pbsa-new.mdp -f frame.xtc -s ../../production.tpr -n ../../../index.ndx -pdie 1 -decomp -pbsa -unit1 Other -unit2 Protein
    
    mv polar.xvg polar_og.xvg
    mv apolar.xvg apolar_og.xvg 
    cp ../../../edit-polar.sh .
    cp ../../../edit-apolar.sh .
    bash edit-polar.sh
    bash edit-apolar.sh 

    cp ../../../MmPbSaStat.py .
    python3 MmPbSaStat.py -m energy_MM.xvg -p polar.xvg -a apolar.xvg -of full_energy.dat -os summary_energy.dat

    cd ../../../

    echo "Done with principle of $folder."
done
