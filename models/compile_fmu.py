from parsing import parser

def compile_fmu():
    '''Compile the fmu.

    Returns
    -------
    fmupath : str
        Path to compiled fmu.

    '''

    # DEFINE MODEL
    mopath = 'TwinRooms/package.mo'
    modelpath = 'TwinRooms.TwinRooms.TestCase'

    # COMPILE FMU
    fmupath = parser.export_fmu(modelpath, [mopath])

    return fmupath

if __name__ == "__main__":
    fmupath = compile_fmu()
