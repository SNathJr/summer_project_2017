PROGRAM DFT
  IMPLICIT NONE
  COMPLEX(KIND=8), PARAMETER :: i = (0,1)     ! sqrt(-1)
  REAL(KIND=8), PARAMETER :: PI = 4.d0 * DATAN(1.d0)
  INTEGER, PARAMETER :: MAX = 15000
  REAL(KIND=8), DIMENSION(MAX) :: T, V
  COMPLEX(KIND=8), DIMENSION(:), ALLOCATABLE :: Y
  INTEGER :: IO, No, C, D, N
  CHARACTER*20 :: INFILE, MAGFILE, PHAFILE
  
  DO No = 1,1
    !--- file reading ---!
    WRITE(INFILE, FMT='(A,I4.4,A)') 'OUT',No,'.DAT'
    OPEN(1,FILE=INFILE)
    N = 0
    DO C = 1, MAX
      READ (1,*, IOSTAT=IO) T(C), V(C)
      IF (IO /=0) THEN
        EXIT
      END IF
      N = N+1
    END DO
    CLOSE(1)
    !--- DFT calculation ---!
    ALLOCATE(Y(N))
    DO C = 0,N-1
      Y(C+1) = (0,0)
      DO D = 0, N-1
        Y(C+1) = Y(C+1) + V(D+1)*EXP(-2.0*i*PI*C*D/REAL(N))
      END DO
    END DO
    !--- file writing ---!
    WRITE(MAGFILE, FMT='(A,I4.4,A)') 'MAG', No, '.DAT'
    OPEN(2, FILE=MAGFILE)
    DO C = 1,N
      WRITE(2,*) ABS(Y(C))
    END DO
    CLOSE(2)
  END DO
END PROGRAM DFT
      
          