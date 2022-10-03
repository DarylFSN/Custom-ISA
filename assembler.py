registers = {
    'r0': '000',
    'r1': '001',
    'r2': '010',
    'r3': '011',
    'r4': '100',
    'r5': '101',
    'r6': '110',
    'r7': '111'
}

ADD = '000'
AND = '001'
XOR = '010'
SRL = '011'
LB  = '100'
SB  = '101'
BEQ = '110'
LUT = '111'

with open('assembly.txt', 'r') as a, open('machinecode.txt', 'w') as m:
    line = a.readline()

    while(line):
        inst = line.split()
        writeLine = ''

        if (line.isspace()):
            line = a.readline()
            continue

        if (inst[0] == 'add'):
            writeLine += ADD
        elif (inst[0] == 'and'):
            writeLine += AND
        elif (inst[0] == 'xor'):
            writeLine += XOR
        elif (inst[0] == 'srl'):
            writeLine += SRL
        elif (inst[0] == 'lb'):
            writeLine += LB
        elif (inst[0] == 'sb'):
            writeLine += SB
        elif (inst[0] == 'beq'):
            writeLine += BEQ
        elif (inst[0] == 'lut'):
            writeLine += LUT
        else:
            line = a.readline()
            continue

        if (inst[0] == 'lut'):
            writeLine += bin(int(inst[1][1:])).replace("0b", "").zfill(6)
        else:
            writeLine += registers[inst[1]]
            writeLine += registers[inst[2]]

        writeLine += '\n'
        m.write(writeLine)
        line = a.readline()

print("done")