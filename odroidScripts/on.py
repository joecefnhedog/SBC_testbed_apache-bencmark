import pistack.comms, pistack.conversions
import sys
C = pistack.comms.Comms("/dev/ttyUSB0", 9600)
#C = pistack.comms.Comms("/dev/ttyUSB1", 9600)
C.pi_on(int(sys.argv[1]), int(sys.argv[2]))
#C.pi_on(9, 1)
