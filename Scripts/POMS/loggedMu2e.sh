#!/bin/bash -x
echo mu2e "$@"
pwd
ls
# file name is taken as input arguement:
filename=`basename ${@: -1}` 
echo $filename
logFilename=${filename/cnf./log.}
logExtension=${logFilename/.fcl/.txt}
tbzFilename=${filename/cnf./bck.}
tbzExtension=${tbzFilename/.fcl/.tbz}
# write output to logExtension
mu2e "$@" |& tee ${logExtension}
# what does grep return? save as status
mu2e_exit_status=${PIPESTATUS[0]}
# tar files including logs
tar -cvjf ${tbzExtension} ${logExtension}
tar_exit_status=${?}
exit ${mu2e_exit_status}
