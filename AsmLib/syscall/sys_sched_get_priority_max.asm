;--------------------------------------------------------------
;>1 syscall
; sys_sched_get_priority_max - kernel function              
;
;    INPUTS 
;     see AsmRef function -> sys_sched_get_priority_max                          
;
;    Note: functon call consists of four instructions
;          
;          sys_sched_get_priority_max:                       
;              mov  eax,159    
;              int  byte 80h
;              or   eax,eax
;              ret
;<;
;------------------------------------------------------------------
  [section .text align=1]

  global sys_sched_get_priority_max
sys_sched_get_priority_max:
	mov	eax,159
	int	byte 80h
	or	eax,eax
	ret