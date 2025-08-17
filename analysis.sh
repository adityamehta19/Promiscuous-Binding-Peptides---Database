##CREATION OF INDEX FILES##
Index Files were created for all the systems using simple GROMACS Command only

##ANALYSIS##
for i in p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p27 p28 p29 p30 p31 p32 p33 p34 p35 p36 p37 p38 p39 p40 p41 p42 p43 p44 p45 p46
do
        cd "$i"

        mkdir analysis
        cd analysis

        mkdir rmsd
        cd rmsd
        echo 5 5 | gmx_d rms -f ../../production.xtc -s ../../production.tpr -o rmsd-"$i".xvg
        gmx_d analyze -f rmsd-"$i".xvg | grep "SS1" | awk '{print $2,"\t",$3}' >> avg-rmsd-"$i".txt
        cd ..

        mkdir rg
        cd rg
        echo 5 | gmx_d gyrate -f ../../production.xtc -s ../../production.tpr -o rg-"$i".xvg
        echo 5 | gmx_d gyrate -f ../../production-100-150.xtc -s ../../production.tpr -o rg-100-150-"$i".xvg
        gmx_d analyze -f rg-100-150-"$i".xvg | grep "SS1" | awk '{print $2, "\t", $3}' >> avg-rg-"$i".txt
        cd ..

        mkdir rmsf
        cd rmsf
        echo 5 | gmx_d rmsf -f ../../production.xtc -s ../../production.tpr -o rmsf-"$i".xvg
        cd ..

        cd ..
        cd ..
done
