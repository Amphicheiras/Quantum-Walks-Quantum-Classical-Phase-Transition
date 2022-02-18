import time
import numpy as np
from qiskit import *
from qiskit.tools.monitor import job_monitor
from qiskit.visualization import plot_histogram
aer_sim = Aer.get_backend('qasm_simulator')

n=6                             # Number of system walker qubits
q = QuantumRegister(n+1,'q')    # +1 ancillary qubit for coin..
c = ClassicalRegister(n+1,'c')  # .. same.
qc = QuantumCircuit(q, c)

# Custom multiple-control single-not gate
def cnx(qc, *qubits):
    if len(qubits) >= 3:
        # last = qubits[-1]
        # A matrix: (made up of a  and Y rotation, lemma4.3)
        qc.crz(np.pi/2, qubits[-2], qubits[-1])
        qc.cu(np.pi/2, 0, 0, 0, qubits[-2],qubits[-1])
        
        # Control not gate
        cnx(qc,*qubits[:-2],qubits[-1])
        
        # B matrix (opposite angle)
        qc.cu(-np.pi/2, 0, 0, 0, qubits[-2], qubits[-1])
        
        # Control
        cnx(qc,*qubits[:-2],qubits[-1])
        
        # C matrix (final rotation)
        qc.crz(-np.pi/2,qubits[-2],qubits[-1])
    elif len(qubits)==3:
        qc.ccx(*qubits)
    elif len(qubits)==2:
        qc.cx(*qubits)
        
# Increment circuit for linear crossing
def increment_circuit(qc, q):
    for i in range(len(q)-1):
        cnx(qc, *q[i+1:],q[i])
    return qc

# Decrement circuit for linear crossing
def decrement_circuit(qc, q):
    qc.x(q[1:n+1])
    for i in range(len(q)-1):
        cnx(qc, *q[i+1:],q[i])
        qc.x(q[i+1])
    return qc

# QW Top-level algorithm (without measurements)
def runQWC(qc, times):
    for i in range(times):
        qc.h(q[n])
        increment_circuit(qc, q)
        decrement_circuit(qc, q)
    return qc

# Int -> binary with length = n
def to_binary(num,n):
    b = []
    b_str = ''
    while(num>0):
        d = num%2
        b.append(d)
        num = num//2
    while(len(b)<n):
        b.append(0)
    b.reverse()
    for i in b:
        b_str += str(i)
    return b_str 

# Display histograms for x steps individually
x = 100
for step in range(1,x+1):              
    qc = QuantumCircuit(q, c)
    
    qc.x(0)                        # Starting walker position  MSD
    #qc.x(1)                       # Starting walker position
                                   # ....
    #qc.x(2)                       # Starting walker position
    #qc.x(n-1)                     # Starting walker position  LSD
    
    start = time.time()
    qc = runQWC(qc, step)          # Run QW for 'step' steps
    qc.measure(q, c)

    #display(qc.draw(output = 'mpl'))

    print('\nExecuting job....\n')
    tr = transpile(qc, aer_sim)
    qobj = assemble(tr)
    results = aer_sim.run(qobj).result()
    counts = results.get_counts()
    #print(counts)
    print("Quantum walk finished in {0} seconds.".format(time.time()-start))
    
    # Initialize dictionaries 
    ls = {}
    ys = {}
    for i in range(2**(n)):
        ls[to_binary(i,n)] = 0 
        ys[to_binary(i,n)] = 0         

    # Insert coin = '0' values to dictionary 
    for i in ls:
        try:
            ls[i] = counts['0'+i]
        except KeyError:
            ls[i] = 0
        
    # Insert coin = '1' values to dictionary
    for i in ls:
        try:
            ls[i] += counts['1'+i] 
        except KeyError:
            ls[i] = ls[i]
        
    # Inverse key order for better plot readability
    for i,j in ls.items():
        ys[i[::-1]] = ls[i]
        
    display(plot_histogram(ys, title = "Walker position after "+str(step)+" steps!"))
    print('\nExecuted job....\n')
