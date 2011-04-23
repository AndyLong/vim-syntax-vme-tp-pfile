" VIM Syntax File
" Language:	ICL/Fujitsu TPMS Parameter files
" Maintainer:	Andy Long (Andrew.Long@Yahoo.com)
" LastChange:	$Date$
" Version:	$Revision$
" Remarks:	TPMS is the Transaction Processing system for VME mainframe
"		systems.
" $Log$
"
if version<600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

syntax	case	ignore

syntax	match	pfileError
	\	oneline
	\	/\S\{-}\ze,/

syntax	match	pfileIdentifier
	\	contained
	\	/\<\a\k\{,11\}\>/

syntax	match	pfileNumber
	\	contained
	\	/\(-\)\=\s*\<\d\+\>/

syntax	match	pfileHexNumber
	\	contained
	\	/\<[0-9a-f]\{1,16}\>/

syntax	match	pfileStringEsc
	\	contained
	\	/""/
syntax	match	pfileStringEsc
	\	contained
	\	/''/

syntax	region	pfileStringError
	\	oneline keepend extend contains=pfileStringEsc
	\	start=/"/ end=/"/ end=/$/
syntax	region	pfileStringError
	\	oneline keepend extend contains=pfileStringEsc
	\	start=/'/ end=/'/ end=/$/
syntax	region	pfileStringConst
	\	oneline keepend extend contains=pfileStringEsc
	\	start=/"/ skip=/""/ end=/"/
syntax	region	pfileStringConst
	\	oneline keepend extend contains=pfileStringEsc
	\	start=/'/ skip=/''/ end=/'/

syntax	keyword	pfileTodo
	\	containedin=pfileComment
	\	TODO	FIXME	FIXTHIS

syntax	region	pfileComment
	\	oneline extend
	\	start=/@/ end=/$/ 

syntax	match	pfileEquals
	\	contained
	\	/=/

syntax	match	pfileComma
	\	contained
	\	/,/

syntax	match	pfileAmpersand
	\	contained
	\	/&/
"
"	These contstructs occur in several places within a parameter file,
"	and are declared here for convenience
"
syntax	match	pfileYesYNoN
	\	contained
	\	/\<\(y\(es\)\=\|n\(o\)\=\)\>/

syntax	match	pfileAllocationName
	\	contained
	\	/\<\a\k\{,5}\>/

syntax	match	pfileDocumentName
	\	contained
	\	/\<\a\k\{,7\}\>/

syntax	match	pfileLocalName
	\	contained
	\	/\<\a\k\{,31\}\>/

syntax	match	pfileFileName
	\	contained
	\	/\(:\a\k\{,31}\.\)\=\(\a\k\{,31}\(\/\a\k\{,31}\)*\.\)\=\(\a\k\{,31}\.\)\=\a\k\{,31}/

syntax	match	pfileProgramName
	\	contained
	\	/\<\a\k\{,31\}\>/
"
"	These fields may occur in more than one Parameter File record,
"	and are declared here for convenience
"
syntax	match	pfileAvmName
	\	contained
	\	/\a\k\{,31}/
syntax	match	pfileAvmNa
	\	contained contains=pfileReservedWords,pfileAvmName,@pfileSingleValue
	\	/\<avmna\>\s*=\_.\{-},/

"
"	The following fields must be included on a DB record to describe the
"	IDMS(X) database service and it's associated logical files
"
"	They MUST be included on any AVM record that accesses the relevant
"	IDMS(X) Database
"
syntax	cluster	pfileDbCommonFields
	\	contains=pfileDbserv,pfileLNa
"
"	An IDMSX Database Service is accessed by a name that is from one to 8
"	ALPHANUMERIC characters, commwencing with an ALPHA character
"
syntax	match	pfileDbName
	\	contained
	\	/\<\a\k\{0,7\}\>/
syntax	match	pfileDbserv
	\	contained contains=pfileReservedWords,pfileDbName,@pfileSingleValue
	\	/\<dbserv\>\s*=\_.\{-},/
"
"	The LNA field is a list of the IDMS(X) Logical FIle Names associated
"	with a particular database.
"
syntax	match	pfileIdmsLNa
	\	contained
	\	/\<[A-Z][A-Z0-9-]\{,14}[A-Z]\>/
syntax	match	pfileLNa
	\	contained contains=pfileReservedWords,pfileIdmsLNa,@pfileMultiValue
	\	/\<lna\>\s*=\_.\{-},/
"
"	The following fields must be included on a FILE record to describe the
"	conventional file.
"
"	They MUST be included on any AVM record that accesses the relevant
"	conventional file
"
syntax	cluster	pfileFileCommonFields
	\	contains=pfileFNa,pfileLFN,pfileAccess,pfileLock,pfileCobOrg,
	\	pfileCobAcc,pfileCobMode
syntax	match	pfileFNa
	\	contained contains=pfileReservedWords,pfileFileName,@pfileSingleValue
	\	/\<fna\>\s*=\_.\{-},/
syntax	match	pfileLFN
	\	contained contains=pfileReservedWords,pfileLocalName,@pfileSingleValue
	\	/\<lfn\>\s*=\_.\{-},/
syntax	match	pfileAccessLimits
	\	contained
	\	/\<[NRWL]\>/
syntax	match	pfileAccess
	\	contained contains=pfileReservedWords,pfileAccessLimits,@pfileSingleValue
	\	/\<access\>\s*=\_.\{-},/
syntax	match	pfileLockLimits
	\	contained
	\	/\<[RWX]\>/
syntax	match	pfileLock
	\	contained contains=pfileReservedWords,pfileLockLimits,@pfileSingleValue
	\	/\<lock\>\s*=\_.\{-},/
syntax match	pfileCobOrgLimits
	\	contained
	\	/\<[SIR]\>/
syntax	match	pfileCobOrg
	\	contained contains=pfileReservedWords,pfileCobOrgLimits,@pfileSingleValue
	\	/\<coborg\>\s*=\_.\{-},/
syntax	match	pfileCobAccLimits
	\	contained
	\	/\<[SDR]\>/
syntax	match	pfileCobAcc
	\	contained contains=pfileReservedWords,pfileCobAccLimits,@pfileSingleValue
	\	/\<cobacc\>\s*=\_.\{-},/
syntax	match	pfileCobModeLimits
	\	contained
	\	/\<\(i\|io\|ir\|o\|e\)\>/
syntax	match	pfileCobMode
	\	contained contains=pfileReservedWords,pfileCobModeLimits,@pfileSingleValue
	\	/\<cobmode\>\s*=\_.\{-},/
"
"	A Hardware Key is a four-character mnemonic, starting with an ALPHA
"	character and followed by three ALPHANUMERIC characters
"
syntax	match	pfileHardwareKey
	\	contained
	\	/\<\a\k\{3\}\>/
syntax	match	pfileHKey
	\	contained contains=pfileReservedWords,pfileHardwareKey,@pfileSingleValue
	\	/\<hkey\>\s*=\_.\{-},/
syntax	match	pfileHKeys
	\	contained contains=pfileReservedWords,pfileHardwareKey,@pfileMultiValue
	\	/\<hkeys\>\s*=\_.\{-},/
"
"	INH may take a value of either YES, Y, NO or N
"
syntax	match	pfileInh
	\	contained contains=pfileReservedWords,pfileYesYNoN,@pfileSingleValue
	\	/\<inh\>\s*=\_.\{-},/
"
"	SYSMESS may take a value of either YES, Y, NO or N
"
syntax	match	pfileSysmess
	\	contained contains=pfileReservedWOrds,pfileYesYNoN,@pfileSingleValue
	\	/\<sysmess\>\_.\{-},/
"
"	OUTCON on RAVMTYPE or RTL records may be either YES, Y, NO or N
"
syntax	match	pfileDTSOutCon
	\	contained contains=pfileReservedWords,pfileYesYNoN,@pfileSingleValue
	\	/\<outcon\>\s*\_.\{-},/
"
"	RSCON may take either of the values YES or NO
"
syntax	match	pfileRSCon
	\	contained contains=pfileReservedWords,pfileYesYNoN,@pfileSingleValue
	\	/\<rscon\>\s*\_.\{-},/
"
"	CLEARDAT may take a value of Y or N
"
syntax	match	pfileCleardat
	\	contained contains=pfileReservedWords,pfileYesYNoN,@pfileSingleValue
	\	/\<cleardat\>\_.\{-},/
"
"	DTSLINK may take eithe of the values VIDEO, STANDAD or SUBSET
"
syntax	match	pfileDtsLinkLimits
	\	contained
	\	/\<\(video\|standard\|subset\)\>/
"
"	LOG may be either YES, Y, NO, N, SECURE or S
"
syntax	match	pfileLogLimits
	\	contained
	\	/\<\(y\(es\)\=\|n\(o\)\=\|s\(ecure\)\)\>/
syntax	match	pfileLog
	\	contained contains=pfileReservedWords,pfileLogLimits,@pfileSingleValue
	\	/\<log\>\s*=\_.\{-},/
"
"	A Message Name is any sequence of between 1 and 12 characters from the
"	set A-Z, 0-9 and -, starting with an ALPHANUMERIC character
"
syntax	match	pfileMessageName
	\	contained
	\	/\<[a-zA-Z0-9][a-zA-Z0-9-]\{,11}\>/
syntax	match	pfileMsgCl
	\	contained contains=pfileReservedWords,pfileMessageName,@pfileSingleValue
	\	/\<msgcl\>\s*=\_.\{-},/
syntax	match	pfileMsgNa
	\	contained contains=pfileReservedWords,pfileMessageName,@pfileSingleValue
	\	/\<msgna\>\s*=\_.\{-},/
"
"	A Printer Name is any sequence of between 1 and 8 characters from the
"	set A-Z, 0-9 and -, starting with an ALPHANUMERIC character
"
syntax	match	pfilePrinterName
	\	contained
	\	/\<\a\k\{,7\}\>/
syntax	match	pfilePrNa
	\	contained contains=pfileReservedWords,pfilePrinterName,@pfileSingleValue
	\	/\<prna\>\s*=\_.\{-},/
"
"	A Terminal Name is any sequence of between 1 and 12 characters from the
"	set A-Z, 0-9 and -, starting with an ALPHANUMERIC character
"
syntax	match	pfileTerminalName
	\	contained
	\	/\<[a-z0-9][a-z0-9\-]\{1,11}\>/
syntax	match	pfileTermNa
	\	contained contains=pfileReservedWords,pfileTerminalName,@pfileSingleValue
	\	/\<termna\>\s*\_.\{-},/
syntax	match	pfileTermCl
	\	contained contains=pfileReservedWords,pfileTerminalName,@pfileSingleValue
	\	/\<termcl\>\s*\_.\{-},/
"
"	A VME User Name is from 1 to 32 characters long, starting with an
"	ALPHA character, and optionally prefixed with a Colon
"
syntax	match	pfileUserName
	\	contained
	\	/\(:\)\=\a\k\{,31}/
syntax	match	pfileUserNa
	\	contained contains=pfileReservedWords,pfileUserName,@pfileSingleValue
	\	/\<userna\>\s*=\_.\{-},/

syntax	match	pfileReservedWords
	\	contained
	\	/\<\(1stcall\|access\|action\|actlim\|actmax\|aftlog\|altna\|aparams\|applibs\|autorec\|avmlim\|avmmax\|avmmin\|avmna\|avmtime\|batch\|bcline\|bdg\|bdgcl\|bdgna\|buffsize\|cfrecov\|frecov\|mrecov\|urecov\|chckpt\|cleardat\|cobacc\|cobmode\|cobnames\|coborg\|codeset\|conondem\|convlim\|copies\|cparams\|ctllibs\|dbclose\|dbserv\|dbstart\|default\|descname\|device\|diag\|disonidl\|docna\|docnum\|docphase\|dtslink\|dupd\|dupdbuf\|duplex\|errors\|final\|firstmsg\|lastmsg\|fldrall\|fldrmax\|fldrsze\|fmsgtext\|lmsgtext\|text\|fna\|format\|formna\|freq\|func\|hddrname\|heldqmax\|heldqtim\|heldq\|heldqueue\|hkey\|hkeys\|holddisc\|iclmods\|idms\|idmsx\|inbuf\|inh\|initial\|keepbdg\|keylen\|keys\|klen\|kpos\|label\|lfn\|lna\|lock\|locprint\|log\|logfail\|logmax\|logno\|maxpri\|maxtime\|mayday\|mclist\|mdlimit\|mdsev\|minpri\|mlog\|mode\|msgan\|msgcl\|msgna\|msgslots\|msgtime\|mslotmin\|mslotmax\|msn\|ncotype\|offload\|offlog\|oncon\|outbuf\|outcon\|overload\|ovfkb\|plslots\|prefix\|presbuf\|print\|printnum\|prdest\|prna\|procna\|procrply\|prop\|qna\|qnames\|qorder\|queue\|[rw]dcl\|recr\|respt\|rmax\|router\|[rs]quota\|rscon\|rscr\|rscrdef\|rsecure\|rtype\|runopt\|save\|scl[12]na\|scr\|scrmods\|share\|slot\|slotall\|splrvm\|sprq\|starlog\|sysmess\|tem\|templ\|termcl\|termna\|testsw\|timeout\|tlmsg\|tlreply\|train\|String\|tsin\|tsout\|tsrecov\|tterm\|ttmaxr\|ttmaxt\|ttnum\|ttpool\|ttrec\|ttsize\|type\|unittime\|urgency\|urstrt\|userna\|userview\)\>/
"
"	This is the definition of the CTRLDAT Record
"
"	There MUST be only one CTRLDAT record in the file, and it must be
"	the first record in the file
"
syntax	region	pfileCtrldat
	\	contains=pfileComment,pfileError,@pfileCtrldatFields
	\	matchgroup=pfileCtrldat 
	\	start=/^\<ctrldat\>/ 
	\	end=/^\_s*\ze\<\(userlog\|db\|file\|avmtype\|splr\|ravmtype\|mt\|format\|mclass\|bdgclass\|rtl\|tldesc\|convdat\|tclass\|pr\|doc\)\>/

syntax	cluster	pfileCtrldatFields
	\	contains=pfileFunc,pfileOverload,pfileLog,pfileLogFail,pfileRouter,pfileKeyLen,
	\	pfileTrainOpt,pfileSlotAll,pfileTestSw,pfileRScrDef,pfileUnitTimes,pfileMsgTime,
	\	pfileInBuf,pfileOutBuf,pfileTTNum,pfileMdSev,pfileMdLimit,pfileCleardat,
	\	pfileCtrldatNumberClauses,pfileCtrldatYesNoClauses,pfileCtrldatSingleFileNameClauses,
	\	pfileCtrldatMultiFileNameClauses,pfileCtrldatSingleProgramNameClauses,
	\	pfileCtrldatMultiProgramNameClauses
"
"	The following fields occur only on the CTRLDAT record
"
"	AVMTIME and UNITTIME may take any value between 0 and 3,600 seconds
"
syntax	match	pfileOneHour
	\	contained
	\	/\<0*\([0-9]\|[1-9][0-9]\|[1-9][0-9]\{2}\|[1-2][0-9]\{3}\|3[0-5][0-9]\{2}\|3600\)\>/
syntax	match	pfileUnitTimes
	\	contained contains=pfileReservedWords,pfileOneHour,@pfileSingleValue
	\	/\<\(avm\|unit\)time\>\s*=\_.\{-},/
"
"	FUNC may be any number between 0 and 4
"
syntax	match	pfileFuncLimits
	\	contained contains=pfileNumber
	\	/\<0*[0-4]\>/
syntax	match	pfileFunc skipwhite skipempty nextgroup=pfile1stCall,pfileFreq
	\	contained contains=pfileReservedWords,pfileFuncLimits,@pfileSingleValue 
	\	/\<func\>\s*=\_.\{-},/
"
"	1STCALL and FREQ may be any number between 0 and 168
"
syntax	match	pfilePeriodicityLimits
	\	contained contains=pfileNumber
	\	/\<0*\([0-9]\|[1-9][0-9]\|1[0-5][0-9]\|16[0-8]\)\>/
syntax	match	pfile1stCall skipwhite skipempty nextgroup=pfileFreq
	\	contained contains=pfileReservedWords,pfilePeriodicityLimits,@pfileSingleValue
	\	/\<1stcall\>\s*=\_.\{-},/
syntax	match	pfileFreq skipwhite skipempty nextgroup=pfile1stCall
	\	contained contains=pfileReservedWords,pfilePeriodicityLimits,@pfileSingleValue
	\	/\<freq\>\s*=\_.\{-},/
"
"	INBUF may take any value between 40 and 8,016 Bytes
"
syntax	match	pfileInBufLimits
	\	contained contains=pfileNumber
	\	/\<0*\([4-9][0-9]\|[1-9][0-9]\{2\}\|[1-7][0-9]\{3\}\|800[0-9]\|801[0-6]\)\>/
syntax	match	pfileInBuf
	\	contained contains=pfileReservedWords,pfileInBufLimits,@pfileSingleValue
	\	/\<inbuf\>\s*=\_.\{-},/
"
"	KEYLEN may take any value between 1 and 12 Bytes
"
syntax	match	pfileKeyLenLimits
	\	contained contains=pfileNumber
	\	/\<0*\([1-9]\|1[0-2]\)\>/
syntax	match	pfileKeylen
	\	contained contains=pfileReservedWords,pfileKeyLenLimits,@pfileSingleValue
	\	/\<keylen\>\s*=\_.\{-},/
"
"	LOGFAIL may take either the value CONTINUE or CLOSE
"
syntax	match	pfileLogFailLimits
	\	contained
	\	/\<\(continue\|close\)\>/
syntax	match	pfileLogFail
	\	contained contains=pfileReservedWords,pfileLogFailLimits,@pfileSingleValue
	\	/\<logfail\>\s*=\_.\{-},/
"
"	MDLIMIT may take any value between 20 and 999 lines
"
syntax	match	pfileMdLimitLimits
	\	contained contains=pfileNumber
	\	/\<0*\([2-9][0-9]\|[1-9][0-9]\{2}\)\>/
syntax	match	pfileMdLimit
	\	contained contains=pfileReservedWords,pfileMdLimitLimits,@pfileSingleValue
	\	/\<mdlimit\>\s*=\_.\{-},/
"
"	MDSEV may take any value between 1 and 9
"
syntax	match	pfileMdSevLimits
	\	contained contains=pfileNumber
	\	/\<0*[1-9]\>/
syntax	match	pfileMdSev
	\	contained contains=pfileReservedWords,pfileMdSevLimits,@pfileSingleValue
	\	/\<mdsev\>\s*=\_.\{-},/
"
"	MSGTIME may take any value between -1 and 223
"
syntax	match	pfile223Seconds
	\	contained contains=pfileNumber
	\	/\(\-0*1\>\|\<0*\([0-9]\|[1-9][0-9]\|2[0-1][0-9]\|22[0-3]\)\)\>/
syntax	match	pfileMsgTime
	\	contained contains=pfileReservedWords,pfile223Seconds,@pfileSingleValue
	\	/\<msgtime\>\s*=\_.\{-},/
"
"	OUTBUF may take any value between 48 and 8024 Bytes
"
syntax	match	pfileOutBufLimits
	\	contained contains=pfileNumber
	\	/\<0*\(48\|49\|[5-9][0-9]\|[1-9][0-9]\{2\}\|[1-7][0-9]\{3\}\|800[0-9]\|801[0-9]\|802[0-4]\)\>/
syntax	match	pfileOutBuf
	\	contained contains=pfileReservedWords,pfileOutBufLimits,@pfileSingleValue
	\	/\<outbuf\>\s*=\_.\{-},/
"
"	OVERLOAD may take either the value REJECT or QUEUE
"
syntax	match	pfileOverloadLimits
	\	contained
	\	/\<\(reject\|queue\)\>/
syntax	match	pfileOverload
	\	contained contains=pfileReservedWords,pfileOverloadLimits,@pfileSingleValue
	\	/\<overload\>\s*=\_.\{-},/
"
"	ROUTER may take either the value MESSAGE or TEMPLATE
"
syntax	match	pfileRouterLimits
	\	contained
	\	/\<\(message\|template\)\>/
syntax	match	pfileRouter
	\	contained contains=pfileReservedWords,pfileRouterLimits,@pfileSingleValue
	\	/\<router\>\s*=\_.\{-},/
"
"	RSCRDEF itakes the name of a DRS file to which screen tamplates will
"	be downloaded
"
syntax	match	pfileRScrDef
	\	contained contains=pfileReservedWords,pfileDrsFileName,@pfileSingleValue
	\	/\<rscrdef\>\s*=\_.\{-},/
"
"	SLOTALL is the name of (up to two) Disc Allocations that will be used
"	to hold the recovery Slot File (SLOT)
"
syntax	match	pfileSlotAll
	\	contained contains=pfileReservedWords,pfileAllocationName,@pfileMultiValue
	\	/\<slotall\>\s*=\_.\{-},/
"
"	TESTSW is set to control diagnostic tracing
"
syntax	match	pfileTestSw
	\	contained contains=pfileReservedWords,pfileHexNumber,@pfileSingleValue
	\	/\<testsw\>\s*=\_.\{-},/
"
"	TRAINOPT may take the values M, F or R
"
syntax	match	pfileTrainOptLimits
	\	contained
	\	/\<[mfr]\>/
syntax	match	pfileTrainOpt
	\	contained contains=pfileReservedWords,pfileTrainOptLimits,@pfileSingleValue
	\	/\<trainopt\>\s*=\_.\{-},/
"
"	TTNUM may take any value between 0 and 1000
"
syntax	match	pfileOneThousand
	\	contained contains=pfileNumber
	\	/\<0*\([0-9]\|[1-9][0-9]\|[1-9][0-9]\{2}\|1000\)/
syntax	match	pfileTTNum
	\	contained contains=pfileReservedWords,pfileOneThousand,@pfileSingleValue
	\	/\<ttnum\>\s*=\_.\{-},/
"
"	These fields may take any numeric value
"
syntax	match	pfileCtrldatNumberClauses
	\	contained contains=pfileReservedWords,pfileNumber,@pfileSingleValue
	\	/\<\(\(msg\|pl\)slots\|\(out\|pres\)buf\|ovfkb\|tt\(pool\|size\|max[rt]\)\|rquota\)\>\s*=\_.\{-},/
"
"	These fields may take the value Y or N
"
syntax	match	pfileCtrldatYesNoClauses
	\	contained contains=pfileReservedWords,pfileYesYNoN,@pfileSingleValue
	\	/\<\(ttrec\|keepbdg\|tlmsg\)\>\s*=\_.\{-},/
"
"	These fields may take the value YES or NO
"
syntax	match	pfileCtrldatYesNoClauses
	\	contained contains=pfileReservedWords,pfileYesYNoN,@pfileSingleValue
	\	/\<cfrecov\>\s*=\_.\{-},/
"
"	These fields may take the value Y, YES, N or NO
"
syntax	match	pfileCtrldatYesNoClauses
	\	contained contains=pfileReservedWords,pfileYesYNoN,@pfileSingleValue
	\	/\<\(starlog\|tsrecov\)\>\s*=\_.\{-},/
"
"	These fields may take as a value a single VME File Name
"
syntax	match	pfileCtrldatSingleFileNameClauses
	\	contained contains=pfileReservedWords,pfileFileName,@pfileSingleValue
	\	/\<\(recr\|offlog\|ts\(in\|out\)\)\>\s*=\_.\{-},/
"
"	These fields may take as a value multiple VME File Names
"
syntax	match	pfileCtrldatMultiFileNameClauses
	\	contained contains=pfileReservedWords,pfileFileName,@pfileMultiValue
	\	/\<\(mlog\|ctllibs\|slot\)\>\s*=\_.\{-},/
"
"	These fields may take as a value a single Program Name
"
syntax	match	pfileCtrldatSingleProgramNameClauses
	\	contained contains=pfileReservedWords,pfileProgramName,@pfileSingleValue
	\	/\<\(msgan\|procrply\|urstrt\|dbstart\|dbclose\|cparams\)\>\s*=\_.\{-},/
"
"	These fields may take a a value multiple Program Names
"
syntax	match	pfileCtrldatMultiProgramNameClauses
	\	contained contains=pfileReservedWords,pfileProgramName,@pfileMultiValue
	\	/\<\(\(icl\|scr\)mods\)\>\s*=\_.\{-},/
"
"	This is the definition of the USERLOG Record
"
"	There MUST be AT MOST one CTRLDAT record in the file, and it should
"	follow on from the CTRLDAT record
"
syntax	region	pfileUserLog
	\	contains=pfileComment,pfileError,@pfileUserLogFields
	\	matchgroup=pfileUserLog 
	\	start=/^\<userlog\>/ 
	\	end=/^\_s*\ze\<\(db\|file\|avmtype\|splr\|ravmtype\|mt\|format\|mclass\|bdgclass\|rtl\|tldesc\|convdat\|tclass\|pr\|doc\)\>/

syntax	cluster	pfileUserLogFields
	\	contains=pfileLogNo
"
"	The LOGNO and LOGMAX fields may take any value between 100 and 255,
"	with the LOGMAX field being at least as large as it's corresponding
"	LOGNO field
"
"	There may be more than one LOGNO field, and each one may have an
"	accompanying LOGMAX and LOG field
"
syntax	match	pfileLogNoLimits
	\	contained contains=pfileNumber
	\	/\<0*\(1[0-9]\{2}\|2[0-4][0-9]\|25[0-5]\)\>/
syntax	match	pfileLogNo skipwhite skipempty nextgroup=pfileLogMax,pfileLog
	\	contained contains=pfileReservedWords,pfileLogNoLimits,@pfileSingleValue
	\	/\<logno\>\s*=\_.\{-},/
syntax	match	pfileLogMax skipwhite skipempty nextgroup=pfileLog
	\	contained contains=pfileReservedWords,pfileLogNoLimits,@pfileSingleValue
	\	/\<logmax\>\s*=\_.\{-},/
"
"	This is the definition of the DB Record
"
"	There MUST be one DB record for each IDMS(X) Database accesed by the
"	TP Service, and they should follow on from the USERLOG record (if any)
"
syntax	region	pfileDB
	\	contains=pfileComment,pfileError,@pfileDbFields
	\	matchgroup=pfileDB 
	\	start=/^\<db\>/ 
	\	end=/^\_s*\ze\<\(db\|file\|avmtype\|splr\|ravmtype\|mt\|format\|mclass\|bdgclass\|rtl\|tldesc\|convdat\|tclass\|pr\|doc\)\>/

syntax	cluster	pfileDbFields
	\	contains=@pfileDbCommonFields,pfileInhLNa
"
"	The INH field of the DB record lists the IDMSX LNAs that are to be
"	inhibited at the start of the service
"
syntax	match	pfileInhLNa
	\	contained contains=pfileReservedWords,pfileIdmsLNa,@pfileMultiValue
	\	/\<inh\>\s*=\_.\{-},/
"
"	This is the definition of the FILE Record
"
"	There MUST be one FILE record for each conventional file accessed by
"	the TP Service, and they should all follow on from the DB records (if
"	any)
"
syntax	region	pfileFile
	\	contains=pfileComment,pfileError,@pfileFileFields
	\	matchgroup=pfileFile 
	\	start=/^\<file\>/ 
	\	end=/^\_s*\ze\<\(userlog\|db\|file\|avmtype\|splr\|ravmtype\|mt\|format\|mclass\|bdgclass\|rtl\|tldesc\|convdat\|tclass\|pr\|doc\)\>/

syntax	cluster	pfileFileFields
	\	contains=@pfileFileCommonFields,pfileFileType,pfileFldrAll,pfileFileNumberClauses,
	\	pfileFileYesNoClauses,pfileFileFileNameClauses,pfileDevice,pfileFormat,pfileRType,
	\	pfileMode,pfileLabel,pfileHddrName,pfileNCOType,pfileInh

syntax	match	pfileFileTypeLimits
	\	contained
	\	/\<[vaf]\>/
syntax	match	pfileFileType
	\	contained contains=pfileReservedWords,pfileFileTypeLimits,@pfileSingleValue
	\	/\<type\>\s*=\_.\{-},/

syntax	match	pfileFldrAll
	\	contained contains=pfileReservedWords,pfileAllocationName,@pfileMultiValue
	\	/\<fldrall\>\s*=\_.\{-},/

syntax	match	pfileDeviceLimits
	\	contained
	\	/\<\(disc\|tape\)\>/
syntax	match	pfileDevice
	\	contained contains=pfileReservedWords,pfileDeviceLimits,@pfileSingleValue
	\	/\<device\>\s*=\_.\{-},/

syntax	match	pfileFormatLimits
	\	contained
	\	/\<\(ind\|seq\|ran\((\a\k*)\)\=\|ser\|con\|sim\|new\|max\)\>/
syntax	match	pfileFormat
	\	contained contains=pfileReservedWords,pfileFormatLimits,@pfileSingleValue
	\	/\<format\>\s*=\_.\{-},/

syntax	match	pfileRTypeLimits
	\	contained
	\	/\<\(v\|u\|f\d\d\)\>/
syntax	match	pfileRType
	\	contained contains=pfileReservedWords,pfileRTypeLimits,@pfileSingleValue
	\	/\<rtype\>\s*=\_.\{-},/

syntax	match	pfileModeLimits
	\	contained
	\	/\<\(con\|tra\|shi\)\>/
syntax	match	pfileMode
	\	contained contains=pfileReservedWords,pfileModeLimits,@pfileSingleValue
	\	/\<mode\>\s*=\_.\{-},/

syntax	match	pfileLabelLimits
	\	contained
	\	/\<\(sta\|non\|label\)\>/
syntax	match	pfileLabel
	\	contained contains=pfileReservedWords,pfileLabelLimits,@pfileSingleValue
	\	/\<label\>\s*=\_.\{-},/

syntax	match	pfileHddrNameValue
	\	contained
	\	/\<\a\k\{,11}\((\(\d\+\)\=\(\/\d\+\)\=)\)\=\>/
syntax	match	pfileHddrName
	\	contained contains=pfileReservedWords,pfileHddrNameValue,@pfileSingleValue
	\	/\<hddrname\>\s*=\_.\{-},/

syntax	match	pfileNCOTypeLimits
	\	contained
	\	/\<\(\*mt\|\*da\)\>/
syntax	match	pfileNCOType
	\	contained contains=pfileReservedWords,pfileNCOTypeLimits,@pfileSingleValue
	\	/\<ncotype\>\s*=\_.\{-},/

syntax	match	pfileFileNumberClauses
	\	contained contains=pfileReservedWords,pfileNumber,@pfileSingleValue
	\	/\<\(fldr\(max\|sze\)\|docnum\|buffsize\|rmax\|k\(pos\|len\)\)\>\s*=\_.\{-},/

syntax	match	pfileFileYesNoClauses
	\	contained contains=pfileReservedWords,pfileYesYNoN,@pfileSingleValue
	\	/\<holddisc\>\s*=\_.\{-},/

syntax	match	pfileFileYesNoClauses
	\	contained contains=pfileReservedWords,pfileYesYNoN,@pfileSingleValue
	\	/\<\(batch\|outcon\|aftlog\|dupd\|runopt\|diag\)\>\s*=\_.\{-},/

syntax	match	pfileFileFileNameClauses
	\	contained contains=pfileReservedWords,pfileFileName,@pfileSingleValue
	\	/\<\(duplex\|[rw]dcl\)\>\s*=\_.\{-},/
"
"	This is the definition of the AVMTYPE record.
"
"	There should be one such record for each AVM Type to be run in the TP
"	Service
"
syntax	region	pfileAvmType
	\	contains=pfileComment,pfileError,@pfileAvmTypeFields
	\	matchgroup=pfileAvmType 
	\	start=/^\<avmtype\>/ 
	\	end=/^\_s*\ze\<\(userlog\|db\|file\|avmtype\|splr\|ravmtype\|mt\|format\|mclass\|bdgclass\|rtl\|tldesc\|convdat\|tclass\|pr\|doc\)\>/

syntax	cluster	pfileAvmTypeFields
	\	contains=pfileAvmTypeNumberClauses,pfileAvmTypeYesNoClauses,pfileAvmNa,pfileUserNa,pfileAvmCount,
	\	pfileAvmTypeMultiFileNameClauses,pfileAvmTypeProgramNameClauses,pfileAvmTypeMultiIdClauses,
	\	@pfileDbCommonFields,@pfileFileCommonFields,pfileSplrVm,pfileInh,pfileConnectDisconnect,
	\	pfileAvmPriority,pfileDocPhase
"
"	AVMMIN/AVMMAX/AVMLIM may be any number between 0 and 50
"
syntax	match	pfileAvmCountLimits
	\	contained contains=pfileNumber
	\	/\<0*\([0-9]\|[1-4][0-9]\|50\)\>/
syntax	match	pfileAvmCount
	\	contained contains=pfileReservedWords,pfileAvmCountLimits,@pfileSingleValue 
	\	/\<avm\(min\|max\|lim\)\>\s*=\_.\{-},/
"
"	MINPRI/MAXPRI may be any number between 0 and 8
"
syntax	match	pfileAvmPriorityLimits
	\	contained contains=pfileNumber
	\	/\<0*[0-8]\>/
syntax	match	pfileAvmPriority
	\	contained contains=pfileReservedWords,pfileAvmPriorityLimits,@pfileSingleValue 
	\	/\<\(max\|min\)pri\>\s*=\_.\{-},/
"
"	DOCPHASE may be any number between 0 and 63
"
syntax	match	pfileDocPhaseLimits
	\	contained contains=pfileNumber
	\	/\<0*\([0-9]\|[1-5][0-9]\|6[0-3]\)\>/
syntax	match	pfileDocPhase
	\	contained contains=pfileReservedWords,pfileDocPhaseLimits,@pfileSingleValue 
	\	/\<docphase\>\s*=\_.\{-},/
"
"	CONONDEM/DISONIDL may be any number between 0 and 9
"
syntax	match	pfileConnectDisconnectLimits
	\	contained contains=pfileNumber
	\	/\<0*[0-9]\>/
syntax	match	pfileConnectDisconnect
	\	contained contains=pfileReservedWords,pfileConnectDisconnectLimits,@pfileSingleValue 
	\	/\<\(conondem\|disonidl\)\>\s*=\_.\{-},/

syntax	match	pfileAvmTypeNumberClauses
	\	contained contains=pfileReservedWords,pfileNumber,@pfileSingleValue
	\	/\<\([sr]quota\|mslot\(min\|max\)\|dupdbuf\|errors\)\>\s*=\_.\{-},/

syntax	match	pfileAvmTypeYesNoClauses
	\	contained contains=pfileReservedWords,pfileYesYNoN,@pfileSingleValue
	\	/\<offload\>\s*=\_.\{-},/

syntax	match	pfileAvmTypeMultiProgramNameClauses
	\	contained contains=pfileReservedWords,pfileProgramName,@pfileMultiValue
	\	/\<\(initial\|final\)\>\s*=\_.\{-},/

syntax	match	pfileAvmTypeProgramNameClauses
	\	contained contains=pfileReservedWords,pfileProgramName,@pfileSingleValue
	\	/\<\(aparams\|scl[12]na\)\>\s*=\_.\{-},/

syntax	match	pfileAvmTypeMultiIdClauses
	\	contained contains=pfileReservedWords,pfileIdentifier,@pfileMultiValue
	\	/\<cobnames\>\s*=\_.\{-},/

syntax	match	pfileAvmTypeMultiFileNameClauses
	\	contained contains=pfileReservedWords,pfileFileName,@pfileMultiValue
	\	/\<applibs\>\s*=\_.\{-},/
"
"	SPLRVM can be either N, I or U
"
syntax	match	pfileSplrVmLimits
	\	contained
	\	/\<[niu]\>/
syntax	match	pfileSplrVm
	\	contained contains=pfileReservedWords,pfileSplrVmLimits,@pfileSingleValue
	\	/\<splrvm\>\s*=\_.\{-},/
"
"	This record describes the ICL spooler for the TP service
"
"	There must be at most ONE such record in the parameter file, and it
"	must follow all the AVM records
"
syntax	region	pfileSplr
	\	contains=pfileComment,pfileError,@pfileSplrFields
	\	matchgroup=pfileSplr 
	\	start=/^\<splr\>/ 
	\	end=/^\_s*\ze\<\(userlog\|db\|file\|avmtype\|ravmtype\|mt\|format\|mclass\|bdgclass\|rtl\|tldesc\|convdat\|tclass\|pr\|doc\)\>/

syntax	cluster	pfileSplrFields
	\	contains=pfilePrintNumClauses,pfileSplrYesNoClauses,pfileSplrMultiIdClauses,pfileQOrder,
	\	pfileOnCon,pfileOutCon
"
"	ONCON describes when Printers should be attached to the TP Service
"
syntax	match	pfileOnConLimits
	\	contained
	\	/\<\(start\|wait\)\>/
syntax	match	pfileOnCon
	\	contained contains=pfileReservedWords,pfileOnConLimits,@pfileSingleValue
	\	/\<oncon\>\s*=\_.\{-},/
"
"	OUTCON describes where printers should be attached to the TP Service
"
syntax	match	pfileOutConLimits
	\	contained
	\	/\<\(tpc\|tpspooler\|userspooler\|no\)\>/
syntax	match	pfileOutCon
	\	contained contains=pfileReservedWords,pfileOutConLimits,@pfileSingleValue
	\	/\<outcon\>\s*=\_.\{-},/
"
"	PRINTNUM can contain a number between 100 and 100000
"
syntax	match	pfilePrintNumLimits
	\	contained contains=pfileReservedWords,pfileNumber,@pfileSingleValue
	\	/\<[1-9][0-9]\{2,4}\|100000\>/
syntax	match	pfilePrintNumClauses
	\	contained contains=pfileReservedWords,pfilePrintNumLimits,@pfileSingleValue
	\	/\<printnum\>\s*=\_.\{-},/
"
"	QORDER may take either of the values FULL or STANDARD
"
syntax	match	pfileQOrderLimits
	\	contained
	\	/\<\(full\|standard\)\>/
syntax	match	pfileQOrder
	\	contained contains=pfileReservedWords,pfileQOrderLimits,@pfileSingleValue
	\	/\<qorder\>\s*=\_.\{-},/

syntax	match	pfileSplrYesNoClauses
	\	contained contains=pfileReservedWords,pfileYesYNoN,@pfileSingleValue
	\	/\<\(sprq\|locprint\|share\|autorec\)\>\s*=\_.\{-},/

syntax	match	pfileSplrMultiIdClauses
	\	contained contains=pfileReservedWords,pfileIdentifier,@pfileMultiValue
	\	/\<qnames\>\s*=\_.\{-},/
"
"	This record describes the Remote AVMs connected to the service through
"	communication links.
"
"	There should be one for each remote service that THIS service can
"	submit work to. The remote service may also subkit work to THIS
"	service. If so, it shoule also be described in an RTL record
"
syntax	region	pfileRAvmType
	\	contains=pfileComment,pfileError,@pfileRAvmTypeFields
	\	matchgroup=pfileRAvmType 
	\	start=/^\<ravmtype\>/ 
	\	end=/^\_s*\ze\<\(userlog\|db\|file\|avmtype\|splr\|ravmtype\|mt\|format\|mclass\|bdgclass\|rtl\|tldesc\|convdat\|tclass\|pr\|doc\)\>/

syntax	cluster	pfileRAvmTypeFields
	\	contains=pfileAvmNa,pfileHKey,pfileRAvmTypeNumberClauses,pfileCleardat,pfileSysmess,
	\	pfileRAvmTypeYesNoClauses,pfileDtsLink,pfileInh,pfileDTSOutCon,pfileRSCon

syntax	match	pfileHKey
	\	contained contains=pfileReservedWords,pfileHardwareKey,@pfileSingleValue
	\	/\<hkey\>\s*=\_.\{-},/

syntax	match	pfileDtsLink
	\	contained contains=pfileReservedWords,pfileDtsLinkLimits,@pfileSingleValue
	\	/\<dtslink\>\s*=\_.\{-},/

syntax	match	pfileRAvmTypeNumberClauses
	\	contained contains=pfileReservedWords,pfileNumber,@pfileSingleValue
	\	/\<\(avm\(max\|lim\)\|mslot\(min\|max\)\|errors\)\>\s*=\_.\{-},/
"
"	The MT record describes a single message type that is processed by
"	this TP service
"
"	There must be one such record for each message type that the service
"	can process
"
syntax	region	pfileMt
	\	contains=pfileComment,pfileError,@pfileMtFields
	\	matchgroup=pfileMt 
	\	start=/^\<mt\>/ 
	\	end=/^\_s*\ze\<\(userlog\|db\|file\|avmtype\|splr\|ravmtype\|mt\|format\|mclass\|bdgclass\|rtl\|tldesc\|convdat\|tclass\|pr\|doc\)\>/

syntax	cluster	pfileMtFields
	\	contains=pfileMsgNa,pfileMtNumberClauses,pfileMtYesNoClauses,pfileMtTextCLauses,
	\	pfileMtSingleIdClauses,pfileMtProgramNameClauses,pfileKeys,pfileQueue,pfileMTLFNs,
	\	pfileAction,pfileLNa,pfileMRecov,pfileRSecure,pfileAvmNa,pfileCleardat,pfileMtMsgNaClauses,
	\	pfileInh

syntax	match	pfileMtNumberClauses
	\	contained contains=pfileReservedWords,pfileNumber,@pfileSingleValue
	\	/\<\(respt\|maxtime\|errors\)\>\s*=\_.\{-},/

syntax	match	pfileMtTextClauses
	\	contained contains=pfileReservedWords,pfileStringConst,@pfileSingleValue
	\	/\<\(\([fl]msg\)\=text\)\>\s*=\_.\{-},/

syntax	match	pfileMtYesNoClauses
	\	contained contains=pfileReservedWords,pfileYesYNoN,@pfileSingleValue
	\	/\<\(default\|[uf]recov\|idms\(x\)\=\|\(first\|last\)msg\)\>\s*=\_.\{-},/

syntax	match	pfileMtYesNoClauses
	\	contained contains=pfileReservedWords,pfileYesYNoN,@pfileSingleValue
	\	/\<tlreply\>\s*=\_.\{-},/

syntax	match	pfileMtMsgNaClauses
	\	contained contains=pfileReservedWords,pfileMessageName,@pfileSingleValue
	\	/\<\(formna\|train\)\>\s*=\_.\{-},/

syntax	match	pfileMtProgramNameClauses
	\	contained contains=pfileReservedWords,pfileProgramName,@pfileSingleValue
	\	/\<procna\>\s*=\_.\{-},/

syntax	match	pfileMtLFNs
	\	contained contains=pfileReservedWords,pfileLocalName,@pfileMultiValue
	\	/\<lfn\>\s*=\_.\{-},/

syntax	match	pfileKeys
	\	contained contains=pfileReservedWords,pfileIdentifier,@pfileMultiValue
	\	/\<keys\>\s*=\_.\{-},/
"
"	QUEUE may take either of the values NO or STANDARD
"
syntax	match	pfileQueueLimits
	\	contained
	\	/\<\(n\(o\)\=\|standard\)\>/
syntax	match	pfileQueue
	\	contained contains=pfileReservedWords,pfileQueueLimits,@pfileSingleValue
	\	/\<queue\>\s*=\_.\{-},/
"
"	ACTION may take either of the values MESSAGE, NEWMESSAGE, CONTROL,
"	SPOOLER, TEMPLATE, LOGOUT or USEMA
"
syntax	match	pfileActionLimits
	\	contained
	\	/\<\(m\(essage\)\=\|n\(ewmessage\)\=\|s\(pooler\)\=\|t\(emplate\)\=\|l\(ogout\)\=\|c\(ontrol\)\=\|usema\)\>/
syntax	match	pfileAction
	\	contained contains=pfileReservedWords,pfileActionLimits,@pfileSingleValue
	\	/\<action\>\s*=\_.\{-},/
"
"	MRECOV may contain either of the values ABT, RTY or VMA
"
syntax	match	pfileMRecovLimits
	\	contained
	\	/\<\(abt\|rty\|vma\)\>/
syntax	match	pfileMRecov
	\	contained contains=pfileReservedWords,pfileMRecovLimits,@pfileSingleValue
	\	/\<mrecov\>\s*\_.\{-},/
"
"	RSECURE may take either of the values FULL, UPDATE or NEVER
"
syntax	match	pfileRSecureLimits
	\	contained
	\	/\<\(f\(ull\)\=\|u\(pdate\)\=\|n\(ever\)\=\)\>/
syntax	match	pfileRSecure
	\	contained contains=pfileReservedWords,pfileRSecureLimits,@pfileSingleValue
	\	/\<rsecure\>\s*\_.\{-},/
"
"	There MUST be ONE FORMAT record for each screen template that the TP
"	Service can send to a terminal
"
syntax	region	pfileFormat
	\	contains=pfileComment,pfileError,@pfileFormatFields
	\	matchgroup=pfileFormat 
	\	start=/^\<format\>/ 
	\	end=/^\_s*\ze\<\(userlog\|db\|file\|avmtype\|splr\|ravmtype\|mt\|format\|mclass\|bdgclass\|rtl\|tldesc\|convdat\|tclass\|pr\|doc\)\>/

syntax	cluster	pfileFormatFields
	\	contains=pfileFormatSingleIdClauses

syntax	match	pfileFormatSingleIdClauses
	\	contained contains=pfileReservedWords,pfileMessageName,@pfileSingleValue
	\	/\<formna\>\s*=\_.\{-},/
"
"	There MAY be Message Class records that describe groups of messages
"	that share common characteristics of (for example) privacy
"
syntax	region	pfileMClass
	\	contains=pfileComment,pfileError,@pfileMClassFields
	\	matchgroup=pfileMClass 
	\	start=/^\<mclass\>/ 
	\	end=/^\_s*\ze\<\(userlog\|db\|file\|avmtype\|splr\|ravmtype\|mt\|format\|mclass\|bdgclass\|rtl\|tldesc\|convdat\|tclass\|pr\|doc\)\>/

syntax	cluster	pfileMClassFields
	\	contains=pfileInh,pfileMClassMultiMsgNaClauses,pfileMsgCl

syntax	match	pfileMClassMultiMsgNaClauses
	\	contained contains=pfileReservedWords,pfileMessageName,@pfileMultiValue
	\	/\<\(msgna\|mclist\)\>\s*\_.\{-},/
"
"	There MAY be Badge Class records that describe groups of badges that
"	give access to particular messages.
"
syntax	region	pfileBdgClass
	\	contains=pfileComment,pfileError,@pfileBdgCLassFields
	\	matchgroup=pfileBdgClass 
	\	start=/^\<bdgclass\>/ 
	\	end=/^\_s*\ze\<\(userlog\|db\|file\|avmtype\|splr\|ravmtype\|mt\|format\|mclass\|bdgclass\|rtl\|tldesc\|convdat\|tclass\|pr\|doc\)\>/

syntax	cluster	pfileBdgClassFields
	\	contains=pfileBdgCl,pfileInh,pfileBdgNa

syntax	match	pfileBdgCl
	\	contained contains=pfileReservedWords,pfileIdentifier,@pfileSingleValue
	\	/\<bdgcl\>\s*=\_.\{-},/

syntax	match	pfileBadgeName
	\	contained contains=pfileNumber
	\	/\<0*\([1-9]\|[1-9][0-9]\|1[0-9]\{2}\|2[0-4][0-9]\|25[0-5]\)\>/
syntax	match	pfileBadgeName
	\	contained contains=pfileIdentifier
	\	/\<\a\k\{0,13\}\>/
syntax	match	pfileBdgNa skipwhite skipempty nextgroup=pfileMsgCl,pfileInh
	\	contained contains=pfileReservedWords,pfileBadgeName,@pfileSingleValue
	\	/\<bdgna\>\s*=\_.\{-},/
"
"	RTL fields
"
syntax	region	pfileRTl
	\	contains=pfileComment,pfileError,@pfileRTlFields
	\	matchgroup=pfileRTl 
	\	start=/^\<rtl\>/ 
	\	end=/^\_s*\ze\<\(userlog\|db\|file\|avmtype\|splr\|ravmtype\|mt\|format\|mclass\|bdgclass\|rtl\|tldesc\|convdat\|tclass\|pr\|doc\)\>/

syntax	cluster	pfileRTlFields
	\	contains=pfileTermNa,pfileHKey,pfileInh,pfileRtlNumberClauses,pfileBdgCl,pfileMsgCl,
	\	pfileDtsLink,pfileRtlYesNoClauses,pfileCleardat,pfileSysmess,pfileRSCon,pfileDTSOutCon

syntax	match	pfileRTlSingleIdClauses
	\	contained contains=pfileReservedWords,pfileIdentifier,@pfileSingleValue
	\	/\<termna\>\s*\_.\{-},/

syntax	match	pfileRtlYesNoClauses
	\	contained contains=pfileReservedWords,pfileYesYNoN,@pfileSingleValue
	\	/\<\(bdg\|tem\)\>\s*\_.\{-},/

syntax	match	pfileRTlNumberClauses
	\	contained contains=pfileReservedWords,pfileNumber,@pfileSingleValue
	\	/\<\act\(max\|lim\)\>\s*=\_.\{-},/
"
"	CONVDAT fields
"
syntax	region	pfileConvDat
	\	contains=pfileComment,pfileError,@pfileConvDatFields
	\	matchgroup=pfileConvDat 
	\	start=/^\<convdat\>/ 
	\	end=/^\_s*\ze\<\(userlog\|db\|file\|avmtype\|splr\|ravmtype\|mt\|format\|mclass\|bdgclass\|rtl\|tldesc\|tclass\|pr\|doc\)\>/

syntax	cluster	pfileConvDatFields
	\	contains=pfileInh,pfileMsgCl,pfileConvDatNumberClauses

syntax	match	pfileConvDatNumberClauses
	\	contained contains=pfileReservedWords,pfileNumber,@pfileSingleValue
	\	/\<convlim\>\s*\_.\{-},/
"
"	TLDESC fields
"
syntax	region	pfileTlDesc
	\	contains=pfileComment,pfileError,@pfileTlDescFIelds
	\	matchgroup=pfileTlDesc 
	\	start=/^\<tldesc\>/ 
	\	end=/^\_s*\ze\<\(userlog\|db\|file\|avmtype\|splr\|ravmtype\|mt\|format\|mclass\|bdgclass\|rtl\|tldesc\|convdat\|tclass\|pr\|doc\)\>/

syntax	cluster	pfileTlDescFields
	\	contains=pfileTermNa,pfileHKeys,pfileBdgCl,pfileMsgCl,pfileTlType,pfilePrefix,pfileInh,
	\	pfileBCLine,pfileCodeset,pfileTimeOut,pfileRSCon,pfileDTSOutCon,
	\	pfileTlDescSingleIdClauses,pfileTlDescYesNoCLauses
"
"	PREFIX is from 1 to 8 characters that will be prepended to the
"	Hardware Key of the attached terminal
"
syntax	match	pfilePrefixLimits
	\	contained contains=pfileIdentifier
	\	/\<[a-z0-9][a-z0-9\-]\{0,7}\>/
syntax	match	pfilePrefix
	\	contained contains=pfileReservedWords,pfilePrefixLimits,@pfileSingleValue
	\	/\<prefix\>\s*=\_.\{-},/
"
"	BCLINE may take a value between 0 and 24
"
syntax	match	pfileBCLineLimits
	\	contained contains=pfileNumber
	\	/\<0*\([0-9]\|1[0-9]\|2[0-4]\)\>/
syntax	match	pfileBCLine
	\	contained contains=pfileReservedWords,pfileBCLineLimits,@pfileSingleValue
	\	/\<bcline\>\s*=\_.\{-},/
"
"	CODESET may take a value between 0 and 255
"
syntax	match	pfileCodesetLimits
	\	contained contains=pfileNumber
	\	/\<0*\([0-9]\|[1-9][0-9]\|1[0-9]\{2\}\|2[0-4][0-9]\|25[0-5]\)\>/
syntax	match	pfileCodeset
	\	contained contains=pfileReservedWords,pfileCodesetLimits,@pfileSingleValue
	\	/\<codeset\>\s*=\_.\{-},/
"
"	TLTYPE may be either R, S or T
"
syntax	match	pfileTlTypeLimits
	\	contained
	\	/\<[rst]\>/
syntax	match	pfileTlType
	\	contained contains=pfileReservedWords,pfileTlTypeLimits,@pfileSingleValue
	\	/\<type\>\s*\_.\{-},/
"
"	TIMEOUT may be a value between 0 and 30
"
syntax	match	pfileTimeOutLimits
	\	contained contains=pfileNumber
	\	/\<0*\([0-9]\|1[0-9]\|2[0-9]\|30\)\>/
syntax	match	pfileTimeOut
	\	contained contains=pfileReservedWords,pfileTimeOutLimits,@pfileSingleValue
	\	/\<timeout\>\s*=\_.\{-},/

syntax	match	pfileTlDescYesNoClauses
	\	contained contains=pfileReservedWords,pfileYesYNoN,@pfileSingleValue
	\	/\<mayday\>\s*\_.\{-},/
syntax	match	pfileTlDescYesNoClauses
	\	contained contains=pfileReservedWords,pfileYesYNoN,@pfileSingleValue
	\	/\<\(tterm\|bdg\|scr\|tem\|rscr\)\>\s*\_.\{-},/

syntax	match	pfileTlDescSingleIdClauses
	\	contained contains=pfileReservedWords,pfileTerminalName,@pfileSingleValue
	\	/\<\(descname\|templ\)\>\s*\_.\{-},/
"
"	TCLASS fields
"
syntax	region	pfileTClass
	\	contains=pfileComment,pfileError,@pfileTClassFields
	\	matchgroup=pfileTClass 
	\	start=/^\<tclass\>/ 
	\	end=/^\_s*\ze\<\(userlog\|db\|file\|avmtype\|splr\|ravmtype\|mt\|format\|mclass\|bdgclass\|rtl\|tldesc\|convdat\|tclass\|pr\|doc\)\>/

syntax	cluster	pfileTClassFields
	\	contains=pfileTermCl,pfileTClassMultiIdClauses,pfilePrNa

syntax	match	pfileTClassMultiIdClauses
	\	contained contains=pfileReservedWords,pfileTerminalName,@pfileMultiValue
	\	/\<termna\>\s*=\_.\{-},/
"
"	PR fields
"
syntax	region	pfilePr
	\	contains=pfileComment,pfileError,@pfilePrFields
	\	matchgroup=pfilePr 
	\	start=/^\<pr\>/ 
	\	end=/^\_s*\ze\<\(userlog\|db\|file\|avmtype\|splr\|ravmtype\|mt\|format\|mclass\|bdgclass\|rtl\|tldesc\|convdat\|tclass\|pr\|doc\)\>/

syntax	cluster	pfilePrFields
	\	contains=pfileOutCon,pfileOnCon,pfilePrTermNa,pfileProp,pfileHKey,
	\	pfilePrNumberClauses,pfilePrYesNoClauses,pfilePrYesYNoNClauses,pfilePrPrNaClauses

syntax	match	pfilePrPrNaClauses
	\	contained contains=pfileReservedWords,pfilePrinterName,@pfileSingleValue
	\	/\<\(\(pr\|alt\|q\)na\)\>\s*=\_.\{-},/

syntax	match	pfileProp
	\	contained contains=pfileReservedWords,pfileSpecial,@pfileSingleValue
	\	/\<prop\>\s*=\_.\{-},/

syntax	match	pfilePrTermNa
	\	contained contains=pfileReservedWords,pfileTerminalName,@pfileSingleValue
	\	/\<termna\>\s*=\_.\{-},/

syntax	match	pfileHeldQLimits
	\	contained contains=pfileNumber
	\	/\<0*\([0-9]\|[1-9][0-9]\|[1-9][0-9]\{2}\|[1-9][0-9]\{3}\|[1-5][0-9]\{4}\|6[0-4][0-9]\{3}\|65[0-4][0-9]\{2}\|655[0-2][0-9]\|6553[0-5]\)\>/
syntax	match	pfilePrNumberClauses
	\	contained contains=pfileReservedWords,pfileHeldQLimits,@pfileSingleValue
	\	/\<heldq\(max\|tim\)\>\s*\_.\{-},/

syntax	match	pfilePrYesYNoNClauses
	\	contained contains=pfileReservedWords,pfileYesYNoN,@pfileSingleValue
	\	/\<heldq\(ueue\)\=\>\s*=\_.\{-},/

syntax	match	pfilePrYesNoClauses
	\	contained contains=pfileReservedWords,pfileYesYNoN,@pfileSingleValue
	\	/\<\(autorec\|locprint\|share\)\s*=\_.\{-},/
"
"	DOC fields
"
syntax	region	pfileDoc
	\	contains=pfileComment,pfileError,@pfileDocFields
	\	matchgroup=pfileDoc 
	\	start=/^\<doc\>/ 
	\	end=/^\_s*\ze\<\(userlog\|db\|file\|avmtype\|splr\|ravmtype\|mt\|format\|mclass\|bdgclass\|rtl\|tldesc\|convdat\|tclass\|pr\|doc\)\>/

syntax	cluster	pfileDocFields
	\	contains=pfileDocNa,pfilePrDest,pfileDocYesNoClauses,pfileUrgency,pfileCopies,pfileChkpt

syntax	match	pfileDocNa
	\	contained contains=pfileReservedWords,pfileDocumentName,@pfileSingleValue
	\	/\<docna\>\s*\_.\{-},/

syntax	match	pfilePrDest
	\	contained contains=pfileReservedWords,pfilePrinterName,@pfileSingleValue
	\	/\<prdest\>\s*\_.\{-},/

syntax	match	pfileUrgencyLimits
	\	contained contains=pfileNumber
	\	/\<[1-9]\>/
syntax	match	pfileUrgency
	\	contained contains=pfileReservedWords,pfileUrgencyLimits,@pfileSingleValue
	\	/\<urgency\>\s*=\_.\{-},/

syntax	match	pfileCopiesLimits
	\	contained contains=pfileNumber
	\	/\<0*\([1-9]\|[1-9][0-9]\)\>/
syntax	match	pfileCopies
	\	contained contains=pfileReservedWords,pfileCopiesLimits,@pfileSingleValue
	\	/\<copies\>\s*=\_.\{-},/

syntax	match	pfileDocYesNoClauses
	\	contained contains=pfileReservedWords,pfileYesYNoN,@pfileSingleValue
	\	/\<\(print\|save\)\>\s*=\_.\{-},/

syntax	match	pfileChkpt
	\	contained contains=pfileReservedWords,pfileNumber,@pfileSingleValue
	\	/\<chckpt\>\s*=\_.\{-},/
"
"	Any characters after column 72 are ignored and treated as COMMENTS,
"	regardless of the presence or absence of comment delimiters
"
"	TODO
"		This doesn't seem to work AT ALL!
"
syntax	match	pfileComment
	\	/^.\{72}\zs.*/
"
"	Any characters after column 80 are ignored and treated as ERRORS.
"
"syntax	match	pfileError
"	\	/^.\{80,}/
"
"	Since the Comment (above) isn't working, and we're going to have
"	errors when we try to compile a parameter file with values after
"	column 72, let's treat column 73 as the error column!
"
"syntax	match	pfileError
"	\	/^.\{73,}/
"
syntax	cluster	pfileSingleValue
	\	contains=pfileEquals,pfileComma,pfileComment,pfileError

syntax	cluster	pfileMultiValue
	\	contains=@pfileSingleValue,pfileAmpersand

"syntax	sync	match	pfileComment
"	\	grouphere pfileComment
"	\	/^@/
"
syntax	sync	match	pfileCtrldat
	\	grouphere pfileCtrldat
	\	/^\<ctrldat\>/

syntax	sync	match	pfileUserLog
	\	grouphere pfileUserLog
	\	/^\<userlog\>/

syntax	sync	match	pfileDb
	\	grouphere pfileDb
	\	/^\<db\>/

syntax	sync	match	pfileFile
	\	grouphere pfileFile
	\	/^\<file\>/

syntax	sync	match	pfileAvmType
	\	grouphere pfileAvmType
	\	/^\<avmtype\>/

syntax	sync	match	pfileSplr
	\	grouphere pfileSplr
	\	/^\<splr\>/

syntax sync	maxlines=2000

"syntax	sync 	fromstart

if version >= 508 || !exists("did_c_syn_inits")
	if version < 508
		let did_c_syn_inits = 1
		command -nargs=+ HiLink hi link <args>
	else
		command -nargs=+ HiLink hi def link <args>
	endif

	HiLink	pfileAvmName		Identifier
	HiLink	pfileDocumentName	Identifier
	HiLink	pfileIdentifier		Identifier
	HiLink	pfileIdmsLNa		Identifier
	HiLink	pfileLocalName		Identifier
	HiLink	pfileMessageName	Identifier
	HiLink	pfilePrinterName	Identifier
	HiLink	pfileTerminalName	Identifier

	HiLink	pfileNumber		Number
	HiLink	pfileHexNumber		Number
	HiLink	pfileOneHour		Number

	HiLink	pfileComment		Comment

	HiLink	pfileLimits		Constant
	HiLink	pfileAccessLimits	Constant
	HiLink	pfileActionLimits	Constant
	HiLink	pfileAllocationName	COnstant
	HiLink	pfileCobAccLimits	Constant
	HiLink	pfileCobModeLimits	Constant
	HiLink	pfileCobOrgLimits	Constant
	HiLink	pfileDbName		Constant
	HiLink	pfileDeviceLimits	Constant
	HiLink	pfileDtsLinkLimits	Constant
	HiLink	pfileFileName		COnstant
	HiLink	pfileFileTypeLimits	Constant
	HiLink	pfileFormatLimits	Constant
	HiLink	pfileHardwareKey	Constant
	HiLink	pfileLabelLimits	Constant
	HiLink	pfileLockLimits		Constant
	HiLink	pfileLogLimits		Constant
	HiLink	pfileLogFailLimits	Constant
	HiLink	pfileModeLimits		Constant
	HiLink	pfileMRecovLimits	Constant
	HiLink	pfileNCOTypeLimits	Constant
	HiLink	pfileOnConLimits	Constant
	HiLink	pfileOutConLimits	Constant
	HiLink	pfileOverloadLimits	Constant
	HiLink	pfileProgramName	Constant
	HiLink	pfileQOrderLimits	Constant
	HiLink	pfileQueueLimits	Constant
	HiLink	pfileRouterLimits	Constant
	HiLink	pfileRSecureLimits	Constant
	HiLink	pfileRTypeLimits	Constant
	HiLink	pfileSplrVmLimits	Constant
	HiLink	pfileTlTypeLimits	Constant
	HiLink	pfileTrainOptLimits	Constant
	HiLink	pfileUserName		Constant
	HiLink	pfileYesYNoN		Constant

	HiLink	pfileStringConst	String

	HiLink	pfileStatement		Statement
	HiLink	pfileCtrldat		Statement
	HiLink	pfileUserLog		Statement
	HiLink	pfileDB			Statement
	HiLink	pfileFile		Statement
	HiLink	pfileAvmType		Statement
	HiLink	pfileSplr		Statement
	HiLink	pfileRAvmType		Statement
	HiLink	pfileMt			Statement
	HiLink	pfileFormat		Statement
	HiLink	pfileMClass		Statement
	HiLink	pfileBdgClass		Statement
	HiLink	pfileRTl		Statement
	HiLink	pfileTlDesc		Statement
	HiLink	pfileConvDat		Statement
	HiLink	pfileTClass		Statement
	HiLink	pfilePr			Statement
	HiLink	pfileDoc		Statement

	HiLink	pfileReservedWords	Statement

	HiLink	pfileSpecial		Special
	HiLink	pfileSpecialChar	SpecialChar
	HiLink	pfileStringEsc		Special
	HiLink	pfileStringEsc		Special
	HiLink	pfileTag		Tag
	HiLink	pfileDelimiter		Delimiter
	HiLink	pfileComma		Delimiter
	HiLink	pfileEquals		Delimiter
	HiLink	pfileAmpersand		Delimiter
	HiLink	pfileSpecialComment	SpecialComment
	HiLink	pfileDebug		Debug

	HiLink	pfileUnderlined		Underlined

	HiLink	pfileIgnore		Ignore

	HiLink	pfileError		Error

	HiLink	pfileTodo		Todo

	delcommand HiLink
endif

let b:current_syntax = "pfile"

