
!! I DID NOT CONSIDER 0th POSITION OF ARRAY

PROGRAM TEST
    REAL :: MIN_X, MAX_X, MIN_Y, MAX_Y    ! MAX and MIN values in DATA
    REAL :: SHIFT_X, SHIFT_Y              ! AMOUNTS BY WHICH X AND Y DATAS SHIFTED
    REAL :: NORMER
    REAL, DIMENSION(15000) :: X, Y        ! DATA Points
    INTEGER :: I, LINE, STAT, FILE_No     ! I = iteration counter; LINE = new line counter
    CHARACTER*12 :: INFILE, OUTFILE
    
    DO FILE_No = 1,200  !! NUMBER OF FILES 200
    
        !!=====================!!
        !! INPUT FILE READING  !!
        !!=====================!!
        WRITE (INFILE, FMT='(a,I4.4,a)') 'TEST',FILE_No,'.DAT' !! FILE NAME FORMATTING
        OPEN(1,FILE=INFILE)
        LINE = 0 !! INITIAL LINE COUNT
        !! READING DATA FROM FILE
        DO I = 1,15000
            READ (1,*, IOSTAT=STAT) X(I), Y(I)  !! IOSTAT FOR EOF DETERMINATION
            IF (STAT /=0) THEN  !! EOF REACHED !!
                EXIT
            END IF
            LINE = LINE + 1 !! COUNTING NUMBER OF NEW LINES BEFORE EOF
            WRITE (*,*) "READING LINE", LINE !! CONSOLE DISPLAY
        END DO
        CLOSE (1) !! CLOSE FILE TO SAVE MEMORY
        
        !!=======================================!!
        !! DATA SHIFTING : REMOVE NEGATIVE VALUE !!
        !! Y NORMALIZATION                       !!
        !!=======================================!!
        
        !==>  MINIMA MAXIMA DETERMINATION  <==!
        
        ! -> FOR X
        MIN_X = X(1)
        MAX_X = X(1)
        DO I = 1, LINE
            IF (X(I) < MIN_X) THEN
                MIN_X = X(I)
            ELSE IF (X(I) > MAX_X) THEN
                MAX_X = X(I)
            END IF
        END DO
        
        
        ! -> FOR Y
        MIN_Y = Y(1)
        MAX_Y = Y(1)
        DO I = 1, LINE
            IF (Y(I) < MIN_Y) THEN
                MIN_Y = Y(I)
            ELSE IF (Y(I) > MAX_Y) THEN
                MAX_Y = Y(I)
            END IF
        END DO
        
        !==> SHIFTING <==!
        ! -> FOR X
        IF (MIN_X < 0) THEN
            SHIFT_X = 0 - MIN_X
        ELSE
            SHIFT_X = 0
        END IF
        DO I = 1, LINE
            X(I) = X(I) + SHIFT_X
        END DO
        
        ! -> FOR Y
        IF (MIN_Y < 0) THEN
            SHIFT_Y = 0 - MIN_Y
        ELSE
            SHIFT_Y = 0
        END IF
        DO I = 1, LINE
            Y(I) = Y(I) + SHIFT_Y
        END DO
        
        
        !==> NORMALIZATION <==!
        ! NORMALIZE Y DATA TO 0-1 RANGE
        NORMER = 1.0/(MAX_Y - MIN_Y)
        DO I = 1, LINE
            Y(I) = NORMER * Y(I)
        END DO
        
        WRITE (*,*) MIN_X, MAX_X, MIN_Y, MAX_Y, NORMER
        
        !!========================!!
        !! OUTPUT FILE GENERATION !!
        !!========================!!
        
        WRITE (OUTFILE, FMT='(a,I4.4,a)') 'OUT',FILE_No,'.DAT' !! FILE NAME FORMATTING
        OPEN (2,FILE=OUTFILE)
        DO I = 1,LINE
            WRITE (2,FMT='(f8.6,a,f8.6)') X(I),"	", Y(I)
        END DO
        CLOSE(2)
    END DO

END PROGRAM TEST
