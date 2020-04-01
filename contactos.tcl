#
#
set selec1 "protein within 3.5 of resname LIG"
#
#
set num_steps [molinfo top get numframes]
# total list
set a_out [list]
#
for {set frame 0} {$frame < $num_steps } {incr frame} {
	# Get the correct frame
	set sel [atomselect top $selec1 frame $frame]
  # To get the residue and id
	set d_out [lsort -unique [$sel get {resname resid}]]
	#
  set num_length [llength $d_out]
	#
	for {set j 0} {$j < $num_length} {incr j} {
		set residname [lindex $d_out $j]
		#
		set name  [lindex $residname 0]
		set resid [lindex $residname 1]
		#
		set all "$name$resid"
		lappend a_out $all
  }
	#
	# delete variable
	$sel delete
	unset sel
}
# Count number of unique element in a list
set  outfile [open contact.txt w]
set counters {}
foreach item $a_out {
    dict incr counters $item
}
dict for {item count} $counters {
    puts $outfile "${item}\t$count"
}
close $outfile
#
#exit
