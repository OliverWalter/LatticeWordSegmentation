#!/bin/bash
#########################################################################################################################
### Call: StartSim_htk_lattice_export_NodeTimes.bash FileListPath PruneFactor                                          ##
### e.g.: ./StartSim_htk_lattice_export_NodeTimes.bash WSJCAM0_WSJ0+1_Cross_Lattice/WSJCAM0_Phoneme_Lattice.htk.txt 16 ##
###                                                                                                                    ##
### Note this scipt mainly demonstrates the LPER calculationa and lattice export.                                      ##
### The lattice phoneme error rate (PER) is claculated for pruning steps from 16 to 0.                                 ##
### Due to dataset size only a small subset (278 utterances) are included in this example.                             ##
###                                                                                                                    ##
### Timing informations are read from the HTK slf node list to output the start end end times of found words           ##
###                                                                                                                    ##
### Exported lattices are saved in openfst format are saved to ${Path}/lattice_export/                                 ##
### Addidionally the filne ${Path}/lattice_export/input_arcs.txt is created to save node/arc timings                   ##
###                                                                                                                    ##
### For input file format see WSJCAM0_WSJ0+1_Cross_Lattice/WSJCAM0_Phoneme_Lattice.htk.txt (file list)                 ##
### WSJCAM0_WSJ0+1_Cross_Lattice/htk/*.lat (the htk slf lattices)                                                      ##
### WSJCAM0_WSJ0+1_Cross_Lattice/WSJCAM0_Phoneme_Lattice.htk.txt.ref (the reference word transcription)                ##
#########################################################################################################################

### parse some parameters ###
FileListPath="${1}"
Path="$(dirname $FileListPath)"
FileList="$(basename $FileListPath '.txt')"
PostFix='_htk_export_NodeTimes'

### Global Options ###
# KnownN="-KnownN ${2}"                                                                     # The n-gram length of the word language model (-KnownN N (1))
# UnkN="-UnkN ${3}"                                                                         # The n-gram length of the character language model (-UnkN N (1))
# NoThreads='-NoThreads 1'                                                                  # The number of threads used for sampling (-NoThreads N (1))
# Debug='-Debug 0'                                                                          # Set debug level (-Debug N (0))
# NumIter="-NumIter ${4}"                                                                   # Maximum number of iterations (-NumIter N (0))
# OutputDirectoryBasename="-OutputDirectoryBasename Results/${Path}${PostFix}/${FileList}/" # The basename for result outpt Directory (Parameter: -OutputDirectoryBasename OutputDirectoryBasename ())
# OutputFilesBasename="-OutputFilesBasename ${dir}_"                                        # The basename for result outpt files (Parameter: -OutputFilesBasename OutputFilesBasename ())
CalculateLPER='-CalculateLPER'                                                              # Calcualte lattice phoneme error rate (Parameter: -CalculateLPER (false))
# CalculatePER='-CalculatePER'                                                              # Calculate phoneme error rate (Parameter: -CalculatePER (false))
# CalculateWER='-CalculateWER'                                                              # Calculate word error rate (Parameter: -CalculateWER (false))
# OutputEditOperations='-OutputEditOperations'                                              # Output edit operations after LPER, PER and WER calculation (false) (-OutputEditOperations (false))
# EvalInterval='-EvalInterval 1'                                                            # Evaluation interval (-EvalInterval EvalInterval (1))
# SwitchIter="-SwitchIter ${6} ${7} ${8} ${9}"                                              # iteration before which the language model orders are switched (Parameter: -SwitchIter SwitchIterIdx NewKnownN NewUnkN NewLMNumIters (0 1 1 0))
# InitLmNumIterations="-InitLmNumIterations ${10}"                                          # Number of iterations for language model initialization (Parameter: -InitLmNumIterations NumIterations (0))
# BeamWidth="-BeamWidth ${11}"
# WordLengthModulation='-WordLengthModulation -1'                                           # Set word length modulation. -1: off, 0: automatic, >0 set mean word length (-WordLengthModulation WordLength (-1))
# UseViterby='-UseViterby 151'
# DeactivateCharacterModel='-DeactivateCharacterModel 175'

### Options when using text ###
InputFilesList="-InputFilesList ${FileListPath}"                                            # A list of input files, one file per line. (-InputFilesList InputFileListName (NULL))
ReferenceTranscription="-ReferenceTranscription ${FileListPath}.ref"                        # File containing the reference transcriptions (Parameter: -ReferenceTranscription ReferenceTranscriptionFilename ())
# InitLM='-InitLM Text/text_ws_no_duplicates.txt.ref'                                       # initialize language model from initialization fsts (Parameter: -InitLM InitTranscriptionFilename ())

### additional Options when using lattices ###
InputType='-InputType fst'                                                                  # The type of the input (-InputType [text|fst] (text))
PruningStep='-PruningStep 16 1 0'                                                           # stepsize through pruning values during lper calculation (Parameter: -PruningStep PruningStart PruningStep PruningEnd (inf 0 inf)
PruneFactor="-PruneFactor ${2}"                                                             # Prune paths in the input that have a PruneFactor times higher score than the lowest scoring path (-PruneFactor X (inf))
# AmScale="-AmScale ${5}"                                                                   # acoustic model scaling factor (Parameter: -AmScale AcousticModelScalingFactor (1))

### Reading from HTK lattices (mostly just for conversion) ###
LatticeFileType='-LatticeFileType htk'                                                      # Format of lattice files (-LatticeFileType [cmu|htk|openfst] (text))
ExportLattices="-ExportLattices ${Path}/lattice_export/"                                    # Export the input lattices to openfst format (-ExportLattices)
HTKLMScale='-HTKLMScale 0'
ReadNodeTimes='-ReadNodeTimes'

./LatticeWordSegmentation ${KnownN} \
                          ${UnkN} \
                          ${NoThreads} \
                          ${PruneFactor} \
                          ${InputFilesList} \
                          ${InputType} \
                          ${SymbolFile} \
                          ${Debug} \
                          ${LatticeFileType} \
                          ${ExportLattices} \
                          ${NumIter} \
                          ${OutputDirectoryBasename} \
                          ${OutputFilesBasename} \
                          ${ReferenceTranscription} \
                          ${CalculateLPER} \
                          ${CalculatePER} \
                          ${CalculateWER} \
                          ${SwitchIter} \
                          ${AmScale} \
                          ${InitLM} \
                          ${InitLmNumIterations} \
                          ${PruningStep} \
                          ${BeamWidth} \
                          ${OutputEditOperations} \
                          ${EvalInterval} \
                          ${WordLengthModulation} \
                          ${UseViterby} \
                          ${DeactivateCharacterModel} \
                          ${HTKLMScale} \
                          ${ReadNodeTimes}
