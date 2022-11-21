! Brief: This subroutine outputs the time spent in secs (cpu & wall clock) since its previous invocation
! Note: All arguments are optional and of type real
! Note: CPU usage = cpu x 100 % / wclock
! Note: #Threads = nint(cpu/wclock)

subroutine timestamp(cpu, wclock)
    implicit none
    real, intent(out), optional :: cpu, wclock
    integer, save :: sys_clock_count_prev
    integer :: sys_clock_count, sys_clock_max, sys_clock_rate, sys_clock_diff
    real, save :: cpu_sec_prev
    real :: cpu_sec
    integer :: call_count = 1 ! implicit save attribute

    call cpu_time(cpu_sec)
    
    if (present(cpu)) then
        if (call_count == 1) then
            cpu = 0.0
        else
            cpu = cpu_sec - cpu_sec_prev
         end if
    end if
    cpu_sec_prev = cpu_sec

    call system_clock(sys_clock_count, sys_clock_rate, sys_clock_max)

    if (present(wclock)) then
        if (call_count == 1) then
            sys_clock_diff = 0
        else
            sys_clock_diff = sys_clock_count - sys_clock_count_prev
        end if
        
        if (sys_clock_diff < 0) then
            wclock = real(sys_clock_diff + sys_clock_max) / sys_clock_rate
        else
            wclock = real(sys_clock_diff) / sys_clock_rate
        end if
    end if
    sys_clock_count_prev = sys_clock_count
     
    call_count = call_count + 1
end subroutine timestamp
