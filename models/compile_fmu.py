from parsing import parser

def compile_fmu():
    '''Compile the fmu.

    Returns
    -------
    fmupath : str
        Path to compiled fmu.

    '''

    # DEFINE MODEL
    mopath = 'Adrenalin2_training/package.mo'
    modelpath = 'Adrenalin2_training.Adrenalin2'

    # COMPILE FMU
    fmupath = parser.export_fmu(modelpath, [mopath])

    return fmupath

if __name__ == "__main__":
    fmupath = compile_fmu()
