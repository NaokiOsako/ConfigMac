#
!/usr/bin/env perl
2
use v5.24;
3
use warnings;
4
use diagnostics;
5
use Path::Tiny;
6
7
use Getopt::Kingpin;
8
my $kingpin = Getopt::Kingpin->new();
9
my $f_sim
= $kingpin ->flag('sim', 'generate simlation script')->
default
(0)->bool;
10
my $f_synth
= $kingpin ->flag('synth', 'generate synthesis script')->
default
(0)->bool;
11
my $f_delete     = $kingpin ->flag('delete', 'delete script')->
short
('d')->bool;
12
my $config_file = $kingpin ->arg('config-file', 'config file name')->required->
string;
13
14
$kingpin ->parse;
15
16
my $config = require $config_file;
17
18
#
シミュレーション用設定
19
my $sim_script_name    = $config ->{sim_script_name};
20
my $workspace
= $config ->{workspace};
21
my @design_files
= @{ $config ->{design_files} };
22
my $top_module
= $config ->{top_module};
23
24
#
論理合成用設定
25
my $synth_script_name = $config ->{synth_script_name};
26
my @simulation_files  = @{ $config ->{simulation_files} };
27
my $testbench
= $config ->{testbench};
28
29
30
if
( $f_delete ) {
31
delete_sim_script()
if
$f_sim    || (!$f_sim && !$f_synth);
32
delete_synth_script()
if
$f_synth || (!$f_sim && !$f_synth);
33
}
else
{
34
make_sim_script()
if
$f_sim    || (!$f_sim && !$f_synth);
35
make_synth_script()
if
$f_synth || (!$f_sim && !$f_synth);
36
}
37
38
39
40
#
functions
41
sub delete_sim_script {
42
path("${sim_script_name}.sh")->remove();
43
path("${sim_script_name}.prj")->remove();
7
44
path("${sim_script_name}.tcl")->remove();
45
}
46
47
48
sub delete_synth_script {
49
path("${synth_script_name}.sh")->remove();
50
path("${synth_script_name}.tcl")->remove();
51
}
52
53
54
sub make_synth_script {
55
# sh
ファイル生成
56
my @sh = ();
57
push @sh, "vivado -mode batch -nolog -nojournal -source ./${synth_script_name}.
tcl\n";
58
path("${synth_script_name}.sh")->spew(@sh);
59
path("${synth_script_name}.sh")->chmod(0775);
60
61
# tcl
ファイル生成
62
my @tcl = ();
63
push @tcl, "read_verilog " . (join ' ', @design_files) . "\n";
64
push @tcl, "synth_design -top ${top_module}\n";
65
push @tcl, "report_utilization -file report_utilization.txt\n";
66
path("${synth_script_name}.tcl")->spew(@tcl);
67
}
68
69
70
sub make_sim_script {
71
# sh
ファイル生成
72
my @sh = ();
73
push @sh, "rm -rf xsim.dir/${workspace}\n\n";
74
push @sh, "xelab ${workspace}.${testbench} --prj ${sim_script_name}.prj -s ${
workspace} -timescale '1ns/1ns' -nolog\n";
75
push @sh, "xsim --noieeewarnings ${workspace} -tclbatch ${sim_script_name}.tcl
-nolog\n\n";
76
push @sh, "rm -f webtalk*.jou webtalk*.log xsim*.jou\n";
77
path("${sim_script_name}.sh")->spew(@sh);
78
path("${sim_script_name}.sh")->chmod(0775);
79
80
# prg
ファイル生成
81
my @prg = ();
82
push @prg, qq/verilog ${workspace} "$_"\n/
for
@design_files;
83
push @prg, qq/verilog ${workspace} "$_"\n/
for
@simulation_files;
84
path("${sim_script_name}.prj")->spew(@prg);
85
86
# tcl
ファイル生成
87
my @tcl = ();
88
push @tcl, "run all\n";
89
push @tcl, "quit\n";
90
path("${sim_script_name}.tcl")->spew(@tcl);
91
}
