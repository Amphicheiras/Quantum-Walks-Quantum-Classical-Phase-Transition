##############################################
################## IMPORTS ###################
##############################################

import math
import numpy as np
from qiskit import *
from qiskit.tools.monitor import job_monitor
from qiskit.visualization import plot_histogram    
aer_sim = Aer.get_backend('qasm_simulator')

n = 3
pi = math.pi
q = QuantumRegister(4,'q')
cw = ClassicalRegister(3,"walker")
cc = ClassicalRegister(1,'coin')
qc = QuantumCircuit(q, cw)

#qc.x(2)     # Starting walker position
#qc.x(1)     # Starting walker position
#qc.x(0)     # Starting walker position

# Custom multiple control not gate
def cnx(qc, *qubits):
    if len(qubits) >= 3:
        last = qubits[-1]
        # A matrix: (made up of a  and Y rotation, lemma4.3)
        qc.crz(np.pi/2, qubits[-2], qubits[-1])
        qc.cu(np.pi/2, 0, 0, 0, qubits[-2],qubits[-1])
        
        # Control not gate
        cnx(qc,*qubits[:-2],qubits[-1])
        
        # B matrix (pposite angle)
        qc.cu(-np.pi/2, 0, 0, 0, qubits[-2], qubits[-1])
        
        # Control
        cnx(qc,*qubits[:-2],qubits[-1])
        
        # C matrix (final rotation)
        qc.crz(-np.pi/2,qubits[-2],qubits[-1])
    elif len(qubits)==3:
        qc.ccx(*qubits)
    elif len(qubits)==2:
        qc.cx(*qubits)

# Increment circuit for cyclical crossing
increment_circuit = QuantumCircuit(4, name = "Increment")
cnx(increment_circuit,q[3],q[2],q[1],q[0])
cnx(increment_circuit,q[3],q[2],q[1])
cnx(increment_circuit,q[3],q[2])
custom_increment = increment_circuit.to_instruction()

# Decrement circuit for cyclical crossing
decrement_circuit = QuantumCircuit(4, name = "Decrement")
decrement_circuit.x(q[3])
decrement_circuit.x(q[2])
decrement_circuit.x(q[1])
cnx(decrement_circuit,q[3],q[2],q[1],q[0])
decrement_circuit.x(q[1])
cnx(decrement_circuit,q[3],q[2],q[1])
decrement_circuit.x(q[2])
cnx(decrement_circuit,q[3],q[2])
decrement_circuit.x(q[3])
custom_decrement = decrement_circuit.to_instruction()

def runQWC(qc, times):
    for i in range(times):
        qc.h(q[3])
        qc.append(custom_increment, [0,1,2,3])
        qc.append(custom_decrement, [0,1,2,3])
    return qc

for step in range(1,19):               # Display histograms for 1-19 steps
#    step = 1                          # Steps of walker 'N'
    qc = QuantumCircuit(q, cw)            
    qc = runQWC(qc, step)
    qc.measure([2,1,0], [0,1,2])       # Inverse matching for better histogram understanding
    #qc.measure(q[3], cc)               # In case we want to see last coin value
    display(qc.draw(output = 'mpl'))
    print('\nExecuting job for step =',step,'....\n')
    job = execute(qc, aer_sim, shots=1000)
    job_monitor(job)
    counts = job.result().get_counts()
    display(plot_histogram(counts))