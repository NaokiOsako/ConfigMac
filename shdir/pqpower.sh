restart
open_saif srrpq.saif
log_saif [get_objects /mips_hw_test/hw/* ]
log_saif [get_objects /mips_hw_test/hw2/* ]
run all
close_saif
set_switching_activity -deassert_resets
