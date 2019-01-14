restart
run 10000ns
a=10000
while [ $a -ne 20000 ]
do
    open_saif test${a}ns.saif
    log_saif [get_objects /mips_hw_test/hw/* ];
    a=$((a+1000))
    run 1000 ns;
    close_saif;

done
