'http://www.uwm.edu/~dkoller
'dkoller@csd.uwm.edu

DEFINT A-Z                                     'SHIFT + F5 TO START
DECLARE SUB compch (ch, lg, no, go, z, lv, pl)
DECLARE SUB compsrch (ch, lg, no, go, lv, p3a, p3b, pl)
DECLARE SUB tally (turn, pl, r!, b!, gr!, pr!)
DECLARE SUB stall1 (secs#)
DECLARE SUB pointer (x, y, p)                  'OTHULLO (44 GAME MODES!)
DECLARE SUB scan (p, pl, turn, p3)             'BY DAVID KOLLER
DECLARE SUB instruct ()                        '2/96 - README GENERATED 1/97
DECLARE SUB ointro ()
                                               'To shut sound off, change
                                               'the "PLAY" statements to "REM"
SCREEN 12
    DEF SEG = 0
    KeyFlags = PEEK(1047)
    POKE 1047, &H0
    DEF SEG
DIM SHARED piece(-64 TO 128) AS INTEGER
DIM SHARED a1(1 TO 400)
DIM SHARED a2(1 TO 400)
DIM SHARED a3(1 TO 400)
DIM SHARED a4(1 TO 400)
DIM SHARED a5(1 TO 400)
DIM SHARED a6(1 TO 400)
DIM SHARED wood(1, 100)
DIM SHARED wood2(1, 100)
DIM SHARED sq(1, 500)
DIM SHARED rpc(1, 200)
DIM SHARED bpc(1, 200)
DIM SHARED gpc(1, 200)
DIM SHARED ppc(1, 200)
10 DATA 0,6,6,6,7,7,6,6,6,0,6,6,6,6,6,6,6,7,7,7,6,6,7,6,6,6,6,7,7,7,6,6,7,7,7,6,6,6,6,7,7,6,6,6,6,6,7,7,6,6,6,7,7,6,6,6,6,6,6,0,6,7,7,7,7,6,6,7,7,7,6,6,6,6,6,7,7,6,6,6,7,7,7,6,6,6,6,6,6,6,6,0,6,6,6,6,7,7,6,0,7,6,6,6,7,7,6,6,6,7,7,7,7,7,7,6,6,6,0,0,0,6,6,6,7,7,6,6,7,7,6,6,0,0,6,6,6,0,6,6,6,7,7,6,0,6,6,6,6,6,6,6,6,7,6,6,6,0,6,15,0,0,6,6,6,6,6,0,6,7,6,6,7,7,7,6,6,7,7,6,6,6,6,6,0,0,6,6,6,7,7,7,6,6,6,6,7,7,6,6,6,7,7,6,6,0,6,7,7,7,6,6,6,7,7,6,6,6,7,7,6,6,6,6,6,6,6,6,6,6,6,7,7,6,6,6,7,7,7,6,6,6,0,6,6,6,7,7,7,6,0,7,7,6,6,6,7,6,6,6

FOR y = 1 TO 10
FOR x = 1 TO 26
READ z
PSET (x, y), z
NEXT x
NEXT y
GET (1, 1)-(26, 10), wood
RESTORE 10
FOR x = 1 TO 10
FOR y = 1 TO 26
READ z
PSET (x, y), z
NEXT y
NEXT x
GET (1, 1)-(10, 26), wood2
LINE (25, 25)-(75, 75), 0, BF
LINE (27, 27)-(73, 73), 8, BF
LINE (29, 29)-(71, 71), 7, BF
LINE (31, 31)-(69, 69), 15, BF
GET (25, 25)-(75, 75), sq
CLS
LINE (0, 0)-(30, 30), 15, BF
CIRCLE (15, 15), 15, 0
PAINT (15, 15), 2, 0
CIRCLE (15, 15), 10, 0
PAINT (15, 15), 10, 0
GET (0, 0)-(30, 30), gpc
LINE (0, 0)-(30, 30), 15, BF
CIRCLE (15, 15), 15, 0
PAINT (15, 15), 4, 0
CIRCLE (15, 15), 10, 0
PAINT (15, 15), 12, 0
GET (0, 0)-(30, 30), rpc
LINE (0, 0)-(30, 30), 15, BF
CIRCLE (15, 15), 15, 0
PAINT (15, 15), 5, 0
CIRCLE (15, 15), 10, 0
PAINT (15, 15), 13, 0
GET (0, 0)-(30, 30), ppc
LINE (0, 0)-(30, 30), 15, BF
CIRCLE (15, 15), 15, 0
PAINT (15, 15), 1, 0
CIRCLE (15, 15), 10, 0
PAINT (15, 15), 9, 0
GET (0, 0)-(30, 30), bpc
CLS

PSET (25, 13), 0
arrow$ = "bd7 e5 f5 l3 d7 l4 u7 l3 a2"
DRAW "ta180 c14 x" + VARPTR$(arrow$)
PAINT (22, 7), 14
GET (0, 0)-(40, 15), a1
CLS
PSET (28, 13), 0
DRAW "ta205 c14 x" + VARPTR$(arrow$)
PAINT (21, 7), 14
GET (0, 0)-(40, 15), a2
CLS
PSET (25, 13), 0
DRAW "ta155 c14 x" + VARPTR$(arrow$)
PAINT (22, 7), 14
GET (0, 0)-(40, 15), a3
CLS
LINE (20, 18)-(20, 18), 0
DRAW "ta-90 c14 x" + VARPTR$(arrow$)
PAINT (10, 23), 14
GET (0, 1)-(25, 41), a4
CLS
LINE (20, 18)-(20, 18), 0
DRAW "ta-115 c14 x" + VARPTR$(arrow$)
PAINT (12, 22), 14
GET (0, 1)-(25, 41), a5
CLS
LINE (20, 18)-(20, 18), 0
DRAW "ta-65 c14 x" + VARPTR$(arrow$)
PAINT (12, 28), 14
GET (0, 1)-(25, 41), a6
CLS
CALL ointro
CALL instruct
107 FOR z = -8 TO 72
    piece(z) = 0
    NEXT z
CLS
COLOR 15
cp2 = 0
cp3 = 0
cp = 0
INPUT "ENTER THE NUMBER OF PLAYERS (0-4): ", pl
PRINT ""
IF pl = 2 THEN INPUT "DO YOU WANT TWO COMPUTER PLAYERS: (1 = YES): ", cp2
IF cp2 = 1 THEN pl = 4

IF pl = 3 THEN INPUT "DO YOU WANT A COMPUTER PLAYER (1 = YES): ", cp3
IF cp3 = 1 THEN pl = 4
PRINT ""
IF cp2 = 1 OR cp3 = 1 THEN INPUT "ENTER SKILL LEVEL OF COMPUTER (1-10): ", lv
PRINT ""
INPUT "ENTER THE TIME LIMIT FOR EACH MOVE (0 = NO LIMIT): ", time

IF pl = 1 THEN
  cp = 1
  PRINT ""
  PRINT "ENTER THE SKILL LEVEL DESIRED (1-10 FOR 1 OPPONENT / 11-20 FOR 3 OPPONENTS): "
  PRINT ""
  INPUT lv
END IF
IF pl = 1 AND lv > 10 THEN pl = 4: lv = lv - 10
IF pl = 1 AND lv < 10 THEN pl = 2

CLS

FOR x = 0 TO 200 STEP 10
  LINE (0, x + 2)-(60, 0), 15
  LINE (0, x + 3)-(60, 0), 7
  LINE (0, x + 4)-(60, 0), 8
  LINE (0, x + 1)-(60, 0), 7
  LINE (0, x)-(60, 0), 8
NEXT x

FOR x = 0 TO 200 STEP 10
  LINE (640, x + 2)-(580, 0), 15
  LINE (640, x + 3)-(580, 0), 7
  LINE (640, x + 4)-(580, 0), 8
  LINE (640, x + 1)-(580, 0), 7
  LINE (640, x)-(580, 0), 8
NEXT x

FOR x = 480 TO 280 STEP -10
  LINE (640, x + 2)-(580, 480), 15
  LINE (640, x + 3)-(580, 480), 7
  LINE (640, x + 4)-(580, 480), 8
  LINE (640, x + 1)-(580, 480), 7
  LINE (640, x)-(580, 480), 8
NEXT x

FOR x = 480 TO 280 STEP -10
  LINE (0, x + 2)-(60, 480), 15
  LINE (0, x + 3)-(60, 480), 7
  LINE (0, x + 4)-(60, 480), 8
  LINE (0, x + 1)-(60, 480), 7
  LINE (0, x)-(60, 480), 8
NEXT x

IF pl <> 3 THEN
LINE (120, 40)-(520, 440), 15, BF
p3 = 0
p3a = 0
p3b = 0
END IF

IF pl = 3 THEN
LINE (120, 40)-(570, 440), 15, BF
p3 = 50
p3a = 8
p3b = 1
END IF

FOR y = 41 TO 440 STEP 26
  PUT (99, y), wood2, PSET
  PUT (531 + p3 + p3b, y), wood2, PSET
  PUT (110, y), wood2, PSET
  PUT (520 + p3 + p3b, y), wood2, PSET
NEXT y

  LINE (99, 440)-(120, 451), 0, BF
  LINE (520, 440)-(585, 451), 0, BF

FOR x = 99 TO 519 + p3 STEP 26
  PUT (x, 19), wood, PSET
  PUT (x, 452), wood, PSET
  PUT (x, 30), wood, PSET
  PUT (x, 441), wood, PSET
NEXT x

IF pl = 3 THEN
  LINE (592, 41)-(592, 439), 0
  LINE (592, 40)-(592, 19), 8
  LINE (592, 440)-(592, 461), 8
END IF

FOR x = 9 TO 60 STEP 26
  PUT (x, 102), wood, PSET
  PUT (x, 162), wood, PSET
  PUT (x, 227), wood, PSET
  PUT (x, 292), wood, PSET
  PUT (x, 352), wood, PSET
NEXT x

FOR y = 102 TO 350 STEP 26
  PUT (9, y), wood2, PSET
  PUT (59, y), wood2, PSET
NEXT y

  FOR x = 120 TO 470 + p3 STEP 50
  FOR y = 40 TO 390 STEP 50
    PUT (x, y), sq, PSET
  NEXT y
  NEXT x

IF cp2 = 1 THEN LOCATE 1, 27: PRINT "COMPUTER IS BLUE AND PURPLE"
IF cp3 = 1 THEN LOCATE 1, 33: PRINT "COMPUTER IS BLUE"

turn = 1
IF pl < 3 THEN
piece(27) = 1
piece(28) = 2
piece(35) = 2
piece(36) = 1
END IF
IF pl = 3 THEN
piece(21) = 2
piece(22) = 1
piece(23) = 3
piece(30) = 3
piece(31) = 2
piece(32) = 1
piece(39) = 1
piece(40) = 3
piece(41) = 2
piece(48) = 2
piece(49) = 1
piece(50) = 3
END IF
IF pl > 3 THEN
piece(18) = 3
piece(19) = 4
piece(20) = 4
piece(21) = 2
piece(26) = 2
piece(27) = 1
piece(28) = 1
piece(29) = 3
piece(34) = 3
piece(35) = 4
piece(36) = 4
piece(37) = 2
piece(42) = 2
piece(43) = 1
piece(44) = 1
piece(45) = 3
END IF

CALL tally(turn, pl, r!, b!, gr!, pr!)
CALL scan(p, pl, turn, p3)

ti# = TIMER
x = 295
y = 215
p = 27 + p3b * 3
b = 0
r = 0
gr = 0
pr = 0
co = 4
c = 14

KEY 15, CHR$(128) + CHR$(72) 'U
KEY 16, CHR$(128) + CHR$(80) 'D
KEY 17, CHR$(128) + CHR$(77) 'R
KEY 18, CHR$(128) + CHR$(75) 'L
KEY 19, CHR$(0) + CHR$(28)
KEY 20, CHR$(0) + CHR$(25) 'P
KEY 21, CHR$(0) + CHR$(20) 'T
KEY 22, CHR$(0) + CHR$(35) 'H
KEY(15) ON
KEY(16) ON
KEY(17) ON
KEY(18) ON
KEY(19) ON
KEY(20) ON
KEY(21) ON
KEY(22) ON
  ON KEY(15) GOSUB 102
  ON KEY(16) GOSUB 103
  ON KEY(17) GOSUB 104
  ON KEY(18) GOSUB 105
  ON KEY(19) GOSUB 106
  ON KEY(20) GOSUB 116
  ON KEY(21) GOSUB 117
  ON KEY(22) GOSUB 119
  loseturn# = TIMER

101 IF time <> 0 THEN
      IF time - (TIMER - loseturn#) < 5.5 THEN
        COLOR 12
        IF time - (TIMER - loseturn#) > 5.4 THEN PLAY "o0l64bcb"
      END IF
      LOCATE 1, 27: PRINT " TIME REMAINING TO MOVE:"; CINT(time - (TIMER - loseturn#))
      IF (TIMER - time > loseturn#) THEN GOSUB 116
    END IF
 
    IF (cp > 0 AND turn <> 1) OR (pl = 0) OR (cp2 = 1 AND (turn = 2 OR turn = 4)) OR (cp3 = 1 AND turn = 4) THEN
      CALL compsrch(ch, lg, no, go, lv, p3a, p3b, pl)
      IF lg = 0 THEN GOSUB 116
      p = go
      GOSUB 106
      x = 295
      y = 215
      p = 27 + 3 * p3b
    END IF

    IF b + r + gr + pr = 64 + p3a THEN GOTO 107
    LINE (x - 24, y - 24)-(x + 24, y - 21), c, BF
    LINE (x + 21, y - 24)-(x + 24, y + 24), c, BF
    LINE (x - 24, y + 24)-(x + 24, y + 21), c, BF
    LINE (x - 24, y - 24)-(x - 21, y + 24), c, BF
    cc = cc + 1
    IF cc = 50 THEN
    cc = 1
      IF (TIMER - .75 > ti#) THEN
        ti# = TIMER
        IF c = co THEN
          c = 14
        ELSE
          c = co
        END IF
        FOR w = 130 TO 319 STEP 63
          IF POINT(48, w) = co AND POINT(51, w) = 0 THEN CIRCLE (39, w), 12, 14: zz = 1
          IF POINT(51, w) = 14 AND zz <> 1 THEN CIRCLE (39, w), 12, 0
        NEXT w
        zz = 0
      END IF
    END IF
GOTO 101

102 CALL pointer(x, y, p)
  IF y > 65 THEN
    y = y - 50
    p = p - 8 - p3b
  END IF
  RETURN
103 CALL pointer(x, y, p)
  IF y < 415 THEN
    y = y + 50
    p = p + 8 + p3b
  END IF
  RETURN
104 CALL pointer(x, y, p)
  IF x < (465 + p3) THEN
    x = x + 50
    p = p + 1
  END IF
  RETURN
105 CALL pointer(x, y, p)
  IF x > 165 THEN
    x = x - 50
    p = p - 1
  END IF
  RETURN

106
  CALL pointer(x, y, p)
  IF piece(p) = 1 OR piece(p) = 2 OR piece(p) = 3 OR piece(p) = 4 THEN RETURN
  chk = 0

  CIRCLE (39, 130), 12, 0
  CIRCLE (39, 193), 12, 0
  CIRCLE (39, 256), 12, 0
  CIRCLE (39, 319), 12, 0
 
  IF piece(p - 9 - p3b) = 2 OR piece(p - 9 - p3b) = 3 OR piece(p - 9 - p3b) = 4 THEN
    FOR z = 1 TO p MOD (8 + p3b)
      IF piece(p - z * (9 + p3b)) = 0 THEN GOTO 108
        IF piece(p - z * (9 + p3b)) = 1 THEN
          chk = 1
          FOR chg = 1 TO z
            piece(p - chg * (9 + p3b)) = 1
          NEXT chg
          GOTO 108
        END IF
    NEXT z
  END IF
108
  IF piece(p - 8 - p3b) = 2 OR piece(p - 8 - p3b) = 3 OR piece(p - 8 - p3b) = 4 THEN
    FOR z = 1 TO FIX(p / (8 + p3b))
      IF piece(p - z * (8 + p3b)) = 0 THEN GOTO 109
        IF piece(p - z * (8 + p3b)) = 1 THEN
          chk = 1
          FOR chg = 1 TO z
            piece(p - chg * (8 + p3b)) = 1
          NEXT chg
          GOTO 109
        END IF
    NEXT z
  END IF
109
  IF piece(p - 7 - p3b) = 2 OR piece(p - 7 - p3b) = 3 OR piece(p - 7 - p3b) = 4 THEN
    FOR z = 1 TO 7 + p3b - p MOD (8 + p3b)
      IF piece(p - z * (7 + p3b)) = 0 THEN GOTO 110
        IF piece(p - z * (7 + p3b)) = 1 THEN
          chk = 1
          FOR chg = 1 TO z
            piece(p - chg * (7 + p3b)) = 1
          NEXT chg
          GOTO 110
        END IF
    NEXT z
  END IF
110
  IF piece(p - 1) = 2 OR piece(p - 1) = 3 OR piece(p - 1) = 4 THEN
    FOR z = 1 TO p MOD (8 + p3b)
      IF piece(p - z) = 0 THEN GOTO 111
        IF piece(p - z) = 1 THEN
          chk = 1
          FOR chg = 1 TO z
            piece(p - chg) = 1
          NEXT chg
          GOTO 111
        END IF
    NEXT z
  END IF
111
  IF piece(p + 1) = 2 OR piece(p + 1) = 3 OR piece(p + 1) = 4 THEN
    FOR z = 1 TO 7 + p3b - p MOD (8 + p3b)
      IF piece(p + z) = 0 THEN GOTO 112
        IF piece(p + z) = 1 THEN
          chk = 1
          FOR chg = 1 TO z
            piece(p + chg) = 1
          NEXT chg
          GOTO 112
        END IF
    NEXT z
  END IF
112
  IF piece(p + 7 + p3b) = 2 OR piece(p + 7 + p3b) = 3 OR piece(p + 7 + p3b) = 4 THEN
    FOR z = 1 TO p MOD (8 + p3b)
      IF piece(p + z * (7 + p3b)) = 0 THEN GOTO 113
        IF piece(p + z * (7 + p3b)) = 1 THEN
          chk = 1
          FOR chg = 1 TO z
            piece(p + chg * (7 + p3b)) = 1
          NEXT chg
          GOTO 113
        END IF
    NEXT z
  END IF
113
  IF piece(p + 8 + p3b) = 2 OR piece(p + 8 + p3b) = 3 OR piece(p + 8 + p3b) = 4 THEN
    FOR z = 1 TO 8 - FIX(p / (8 + p3b))
      IF piece(p + z * (8 + p3b)) = 0 THEN GOTO 114
        IF piece(p + z * (8 + p3b)) = 1 THEN
          chk = 1
          FOR chg = 1 TO z
            piece(p + chg * (8 + p3b)) = 1
          NEXT chg
          GOTO 114
        END IF
    NEXT z
  END IF
114
  IF piece(p + 9 + p3b) = 2 OR piece(p + 9 + p3b) = 3 OR piece(p + 9 + p3b) = 4 THEN
    FOR z = 1 TO 7 + p3b - p MOD (8 + p3b)
      IF piece(p + z * (9 + p3b)) = 0 THEN GOTO 115
        IF piece(p + z * (9 + p3b)) = 1 THEN
          chk = 1
          FOR chg = 1 TO z
            piece(p + chg * (9 + p3b)) = 1
          NEXT chg
          GOTO 115
        END IF
    NEXT z
  END IF
115

IF chk = 0 THEN RETURN
piece(p) = 1

116
turn = turn + 1
IF turn = 5 AND pl > 3 THEN turn = 1
IF turn = 4 AND pl = 3 THEN turn = 1
IF turn = 3 AND pl < 3 THEN turn = 1
g = 0
FOR z = 0 TO 63 + p3a
  IF pl > 3 AND piece(z) = 1 THEN
     piece(z) = 2
  ELSEIF pl > 3 AND piece(z) = 2 THEN
     piece(z) = 3
  ELSEIF pl > 3 AND piece(z) = 3 THEN
     piece(z) = 4
  ELSEIF pl > 3 AND piece(z) = 4 THEN
     piece(z) = 1
  ELSEIF pl > 3 THEN
     g = g + 1
  END IF
 
  IF pl = 3 AND piece(z) = 1 THEN
     piece(z) = 2
  ELSEIF pl = 3 AND piece(z) = 2 THEN
     piece(z) = 3
  ELSEIF pl = 3 AND piece(z) = 3 THEN
     piece(z) = 1
  ELSEIF pl = 3 THEN
     g = g + 1
  END IF
 
  IF pl < 3 AND piece(z) = 1 THEN
     piece(z) = 2
  ELSEIF pl < 3 AND piece(z) = 2 THEN
     piece(z) = 1
  ELSEIF pl < 3 THEN
     g = g + 1
  END IF
NEXT z

CALL scan(p, pl, turn, p3)
CALL tally(turn, pl, r!, b!, gr!, pr!)

118
IF g = 0 THEN
      LOCATE 1, 10, 0
      PRINT "                                                   "
      LOCATE 1, 26, 0
      COLOR 14
        r! = FIX(r!)
        b! = FIX(b!)
        gr! = FIX(gr!)
        pr! = FIX(pr!)
        IF r! > pr! AND r! > b! AND r! > pr! THEN PRINT "RED IS THE WINNER WITH"; FIX(r!); "!!": FOR z = 1 TO 200 STEP 2: CIRCLE (320 + p3 / 2, 240), z, 4: NEXT z: w = 1
        IF b! > r! AND b! > gr! AND b! > pr! THEN PRINT "BLUE IS THE WINNER WITH"; FIX(b!); "!!": FOR z = 1 TO 200 STEP 2: CIRCLE (320 + p3 / 2, 240), z, 1: NEXT z: w = 1
        IF gr! > r! AND gr! > b! AND gr! > pr! THEN PRINT "GREEN IS THE WINNER WITH"; FIX(gr!); "!!": FOR z = 1 TO 200 STEP 2: CIRCLE (320 + p3 / 2, 240), z, 2: NEXT z: w = 1
        IF pr! > r! AND pr! > b! AND pr! > gr! THEN PRINT "PURPLE IS THE WINNER WITH"; FIX(pr!); "!!": FOR z = 1 TO 200 STEP 2: CIRCLE (320 + p3 / 2, 240), z, 5: NEXT z: w = 1
        IF (w = 0) AND (r! = b! OR r! = gr! OR r! = pr! OR b! = gr! OR b! = pr! OR gr! = pr!) THEN LOCATE 1, 34, 0: PRINT "IT'S A DRAW !!"
      w = 0
      KEY(19) OFF
      r = 64 + p3a: b = 0: gr = 0: pr = 0
      cp = 0
      WHILE INKEY$ <> CHR$(13)
      WEND
  RETURN
END IF
  IF turn = 1 THEN co = 4
IF pl < 3 THEN
  IF turn = 2 THEN co = 1
END IF

IF pl = 3 THEN
  IF turn = 2 THEN co = 2
  IF turn = 3 THEN co = 1
END IF

IF pl > 3 THEN
  IF turn = 2 THEN co = 5
  IF turn = 3 THEN co = 2
  IF turn = 4 THEN co = 1
END IF
ch = 0
lg = 0
no = 0
go = 0
z = 0
movep = 0
loseturn# = TIMER
RETURN

117 g = 0
   GOTO 118

119 IF pl > 2 THEN RETURN
KEY(21) OFF
KEY(19) OFF
temp = lv
lv = 10
CALL compsrch(ch, lg, no, go, lv, p3a, p3b, pl)
u = ((go MOD 8) + 1) * 50 + 65
v = FIX(go / 8) * 50 + 37
secs# = .001
DO
s = INT(RND * 15) + 1
r = INT(RND * 3) + 1
PUT (u + s, 0), a1, PSET
CALL stall1(secs#)
s = INT(RND * 5) + 1
r = INT(RND * 15) + 1
PUT (68 + s, v + r), a4, PSET
CALL stall1(secs#)
s = INT(RND * 15) + 1
r = INT(RND * 3) + 1
PUT (u + s, 0), a2, PSET
CALL stall1(secs#)
s = INT(RND * 5) + 1
r = INT(RND * 15) + 1
PUT (68 + s, v + r), a5, PSET
CALL stall1(secs#)
s = INT(RND * 15) + 1
r = INT(RND * 3) + 1
PUT (u + s, 0), a3, PSET
CALL stall1(secs#)
s = INT(RND * 5) + 1
r = INT(RND * 15) + 1
PUT (68 + s, v + r), a6, PSET
CALL stall1(secs#)
LOOP UNTIL INKEY$ = CHR$(13)
KEY(19) ON
KEY(21) ON
lv = temp
LINE (u + 5, 0)-(u + 55, 18), 0, BF
LINE (74, v + 5)-(94, v + 55), 0, BF
RETURN

SUB compch (ch, lg, no, go, z, lv, pl)
IF pl <> 3 THEN
  IF lv > 3 THEN IF ((ch <> 9) AND (ch <> 14) AND (ch <> 49) AND (ch <> 54)) AND no > 0 THEN no = no + 200
  IF lv > 3 THEN IF ((ch = 9) OR (ch = 14) OR (ch = 49) OR (ch = 54)) AND no > 0 THEN no = 1
  IF lv > 1 THEN IF ((ch < 8) OR (ch > 55) OR (ch MOD 8 = 0) OR (ch MOD 8 = 7)) AND no > 0 THEN no = no + 100
  IF lv > 4 THEN IF (ch > 56) AND (ch < 63) AND (z < 56) AND ((piece(ch + 1) = 2) OR (piece(ch - 1) = 2)) THEN no = no - 300
  IF lv > 4 THEN IF (ch > 0) AND (ch < 8) AND (z > 8) AND ((piece(ch + 1) = 2) OR (piece(ch - 1) = 2)) THEN no = no - 300
  IF lv > 4 THEN IF ((ch > 0) AND (ch MOD 8 = 0) AND (z MOD 8) <> 0) AND (ch < 56) AND ((piece(ch - 8) = 2) OR (piece(ch + 8) = 2)) THEN no = no - 300
  IF lv > 4 THEN IF ((ch > 7) AND (ch MOD 8 = 7) AND (z MOD 8) <> 7) AND (ch < 63) AND ((piece(ch - 8) = 2) OR (piece(ch + 8) = 2)) THEN no = no - 300
  IF lv > 2 THEN IF ((ch = 0) OR (ch = 7) OR (ch = 56) OR (ch = 63)) AND no > 0 THEN no = no + 500
  IF lv > 5 THEN IF ((ch = 18) OR (ch = 21) OR (ch = 42) OR (ch = 45)) AND no > 0 THEN no = no + 75
  IF lv > 5 THEN IF ((z < 8) OR (z > 55) OR (z MOD 8 = 0) OR (z MOD 8 = 7)) AND ((ch < 8) OR (ch > 55) OR (ch MOD 8 = 0) OR (ch MOD 8 = 7)) AND no > 0 THEN no = no + 50
  IF lv > 6 THEN IF ((ch < 7) AND (ch > 0)) AND ((piece(1) = 2) OR (piece(7) = 2)) AND no > 0 THEN no = 2
  IF lv > 6 THEN IF ((ch > 56) AND (ch < 63)) AND ((piece(56) = 2) OR (piece(63) = 2)) AND no > 0 THEN no = 2
  IF lv > 6 THEN IF (ch MOD 8 = 0) AND (ch <> 0) AND (ch <> 56) AND ((piece(0) = 2) OR (piece(56) = 2)) AND no > 0 THEN no = 2
  IF lv > 6 THEN IF (ch MOD 8 = 7) AND (ch <> 7) AND (ch <> 63) AND ((piece(7) = 2) OR (piece(63) = 2)) AND no > 0 THEN no = 2
  IF lv > 7 THEN IF ((ch = 24) OR (ch = 32) OR (ch = 31) OR (ch = 39)) AND ((piece(ch - 16) = 1) AND (piece(ch - 8) = 0)) AND no > 0 THEN no = 1
  IF lv > 7 THEN IF ((ch = 24) OR (ch = 32) OR (ch = 31) OR (ch = 39)) AND ((piece(ch + 16) = 1) AND (piece(ch + 8) = 0)) AND no > 0 THEN no = 1
  IF lv > 7 THEN IF ((ch = 3) OR (ch = 4) OR (ch = 59) OR (ch = 60)) AND ((piece(ch - 2) = 1) AND (piece(ch - 1) = 0)) AND no > 0 THEN no = 1
  IF lv > 7 THEN IF ((ch = 3) OR (ch = 4) OR (ch = 59) OR (ch = 60)) AND ((piece(ch + 2) = 1) AND (piece(ch + 1) = 0)) AND no > 0 THEN no = 1
  IF lv > 8 THEN IF ((ch MOD 8 = 0) OR (ch MOD 8 = 7)) AND ((piece(ch - 8) = 2) AND (piece(ch + 8) = 2)) AND no > 0 THEN no = no + 100
  IF lv > 8 THEN IF (ch < 7 OR ch > 56) AND (piece(ch - 1) = 2) AND (piece(ch + 1) = 2) AND no > 0 THEN no = no + 100
  IF lv > 9 THEN IF (ch < 56) AND (ch MOD 8 = z MOD 8) AND (ch > z) AND (piece(z - 8) = 2) AND (piece(ch + 8) = 0) AND no > 0 THEN no = 1
  IF lv > 9 THEN IF (ch > 7) AND (ch MOD 8 = z MOD 8) AND (ch < z) AND (piece(z + 8) = 2) AND (piece(ch - 8) = 0) AND no > 0 THEN no = 1
  IF lv > 9 THEN IF (ch MOD 8 <> 7) AND ((ch > z) AND (ABS(ch - z) < 8) AND (ch MOD 8 > z MOD 8)) AND (piece(z - 1) = 2) AND (piece(ch + 1) = 0) AND no > 0 THEN no = 1
  IF lv > 9 THEN IF (ch MOD 8 <> 0) AND ((ch < z) AND (ABS(ch - z) < 8) AND (ch MOD 8 < z MOD 8)) AND (piece(z + 1) = 2) AND (piece(ch - 1) = 0) AND no > 0 THEN no = 1
  IF lv > 9 THEN IF (ch MOD 8 <> 7 AND ch < 56) AND ((ch > z) AND (ABS(ch - z) MOD 9 = 0) AND (ch MOD 8 > z MOD 8)) AND (piece(z - 9) = 2) AND (piece(ch + 9) = 0) AND no > 0 THEN no = 1
  IF lv > 9 THEN IF (ch MOD 8 <> 0 AND ch > 7) AND ((ch < z) AND (ABS(ch - z) MOD 9 = 0) AND (ch MOD 8 < z MOD 8)) AND (piece(z + 9) = 2) AND (piece(ch - 9) = 0) AND no > 0 THEN no = 1
  IF lv > 9 THEN IF (ch MOD 8 <> 7 AND ch > 7) AND ((ch < z) AND (ABS(ch - z) MOD 7 = 0) AND (ch MOD 8 > z MOD 8)) AND (piece(z + 7) = 2) AND (piece(ch - 7) = 0) AND no > 0 THEN no = 1
  IF lv > 9 THEN IF (ch MOD 8 <> 0 AND ch < 56) AND ((ch > z) AND (ABS(ch - z) MOD 7 = 0) AND (ch MOD 8 < z MOD 8)) AND (piece(z - 7) = 2) AND (piece(ch + 7) = 0) AND no > 0 THEN no = 1
  IF lv > 9 THEN IF ((ch = 1 AND z > 8) OR (ch = 6 AND z > 8) OR (ch = 8 AND z MOD 8 <> 0) OR (ch = 15 AND z MOD 8 <> 7) OR (ch = 48 AND z MOD 8 <> 0) OR (ch = 55 AND z MOD 8 <> 7) OR (ch = 57 AND z < 56) OR (ch = 62 AND z < 56)) AND no > 0 THEN no = 3
END IF
IF pl = 3 THEN
  IF lv > 3 THEN IF ((ch <> 10) AND (ch <> 16) AND (ch <> 55) AND (ch <> 61)) AND no > 0 THEN no = no + 200
  IF lv > 3 THEN IF ((ch = 10) OR (ch = 16) OR (ch = 55) OR (ch = 61)) AND no > 0 THEN no = 1
  IF lv > 1 THEN IF ((ch < 9) OR (ch > 62) OR (ch MOD 9 = 0) OR (ch MOD 9 = 8)) AND no > 0 THEN no = no + 100
  IF lv > 4 THEN IF (ch > 63) AND (ch < 71) AND (z < 63) AND ((piece(ch + 1) > 1) OR (piece(ch - 1) > 1)) THEN no = no - 300
  IF lv > 4 THEN IF (ch > 0) AND (ch < 9) AND (z > 9) AND ((piece(ch + 1) > 1) OR (piece(ch - 1) > 1)) THEN no = no - 300
  IF lv > 4 THEN IF ((ch > 0) AND (ch MOD 9 = 0) AND (z MOD 9) <> 0) AND (ch < 63) AND ((piece(ch - 8) > 1) OR (piece(ch + 8) > 1)) THEN no = no - 300
  IF lv > 4 THEN IF ((ch > 8) AND (ch MOD 9 = 8) AND (z MOD 9) <> 8) AND (ch < 71) AND ((piece(ch - 8) > 1) OR (piece(ch + 8) > 1)) THEN no = no - 300
  IF lv > 2 THEN IF ((ch = 0) OR (ch = 8) OR (ch = 63) OR (ch = 71)) AND no > 0 THEN no = no + 500
  IF lv > 5 THEN IF ((ch = 20) OR (ch = 24) OR (ch = 47) OR (ch = 51)) AND no > 0 THEN no = no + 75
  IF lv > 5 THEN IF ((z < 9) OR (z > 62) OR (z MOD 9 = 0) OR (z MOD 9 = 8)) AND ((ch < 9) OR (ch > 62) OR (ch MOD 9 = 0) OR (ch MOD 9 = 8)) AND no > 0 THEN no = no + 50
  IF lv > 6 THEN IF ((ch < 8) AND (ch > 0)) AND ((piece(1) > 1) OR (piece(8) > 1)) AND no > 0 THEN no = 2
  IF lv > 6 THEN IF ((ch > 63) AND (ch < 71)) AND ((piece(63) > 1) OR (piece(71) > 1)) AND no > 0 THEN no = 2
  IF lv > 6 THEN IF (ch MOD 9 = 0) AND (ch <> 0) AND (ch <> 63) AND ((piece(0) > 1) OR (piece(63) > 1)) AND no > 0 THEN no = 2
  IF lv > 6 THEN IF (ch MOD 9 = 8) AND (ch <> 8) AND (ch <> 71) AND ((piece(8) > 1) OR (piece(71) > 1)) AND no > 0 THEN no = 2
  IF lv > 7 THEN IF ((ch = 27) OR (ch = 36) OR (ch = 35) OR (ch = 44)) AND ((piece(ch - 16) = 1) AND (piece(ch - 8) = 0)) AND no > 0 THEN no = 1
  IF lv > 7 THEN IF ((ch = 27) OR (ch = 36) OR (ch = 35) OR (ch = 44)) AND ((piece(ch + 16) = 1) AND (piece(ch + 8) = 0)) AND no > 0 THEN no = 1
  IF lv > 7 THEN IF ((ch = 3) OR (ch = 4) OR (ch = 5) OR (ch = 66) OR (ch = 67) OR (ch = 68)) AND ((piece(ch - 2) = 1) AND (piece(ch - 1) = 0)) AND no > 0 THEN no = 1                                                                                                     'DAVID KOLLER :)
  IF lv > 7 THEN IF ((ch = 3) OR (ch = 4) OR (ch = 5) OR (ch = 66) OR (ch = 67) OR (ch = 68)) AND ((piece(ch + 2) = 1) AND (piece(ch + 1) = 0)) AND no > 0 THEN no = 1
  IF lv > 8 THEN IF ((ch MOD 9 = 0) OR (ch MOD 9 = 8)) AND ((piece(ch - 8) > 1) AND (piece(ch + 8) > 1)) AND no > 0 THEN no = no + 100
  IF lv > 8 THEN IF (ch < 8 OR ch > 63) AND (piece(ch - 1) > 1) AND (piece(ch + 1) > 1) AND no > 0 THEN no = no + 100
  IF lv > 9 THEN IF (ch < 63) AND (ch MOD 9 = z MOD 9) AND (ch > z) AND (piece(z - 8) > 1) AND (piece(ch + 8) = 0) AND no > 0 THEN no = 1
  IF lv > 9 THEN IF (ch > 8) AND (ch MOD 9 = z MOD 9) AND (ch < z) AND (piece(z + 8) > 1) AND (piece(ch - 8) = 0) AND no > 0 THEN no = 1
  IF lv > 9 THEN IF (ch MOD 9 <> 8) AND ((ch > z) AND (ABS(ch - z) < 8) AND (ch MOD 8 > z MOD 8)) AND (piece(z - 1) = 2) AND (piece(ch + 1) = 0) AND no > 0 THEN no = 1
  IF lv > 9 THEN IF (ch MOD 9 <> 0) AND ((ch < z) AND (ABS(ch - z) < 8) AND (ch MOD 8 < z MOD 8)) AND (piece(z + 1) = 2) AND (piece(ch - 1) = 0) AND no > 0 THEN no = 1
  IF lv > 9 THEN IF (ch MOD 9 <> 8 AND ch < 63) AND ((ch > z) AND (ABS(ch - z) MOD 9 = 0) AND (ch MOD 9 > z MOD 9)) AND (piece(z - 9) = 2) AND (piece(ch + 9) = 0) AND no > 0 THEN no = 1
  IF lv > 9 THEN IF (ch MOD 9 <> 0 AND ch > 8) AND ((ch < z) AND (ABS(ch - z) MOD 9 = 0) AND (ch MOD 9 < z MOD 9)) AND (piece(z + 9) = 2) AND (piece(ch - 9) = 0) AND no > 0 THEN no = 1
  IF lv > 9 THEN IF (ch MOD 9 <> 8 AND ch > 8) AND ((ch < z) AND (ABS(ch - z) MOD 7 = 0) AND (ch MOD 9 > z MOD 9)) AND (piece(z + 7) = 2) AND (piece(ch - 7) = 0) AND no > 0 THEN no = 1
  IF lv > 9 THEN IF (ch MOD 9 <> 0 AND ch < 63) AND ((ch > z) AND (ABS(ch - z) MOD 7 = 0) AND (ch MOD 9 < z MOD 9)) AND (piece(z - 7) = 2) AND (piece(ch + 7) = 0) AND no > 0 THEN no = 1
  IF lv > 9 THEN IF ((ch = 1 AND z > 9) OR (ch = 7 AND z > 9) OR (ch = 9 AND z MOD 9 <> 0) OR (ch = 17 AND z MOD 9 <> 8) OR (ch = 54 AND z MOD 9 <> 0) OR (ch = 62 AND z MOD 9 <> 8) OR (ch = 64 AND z < 63) OR (ch = 70 AND z < 63)) AND no > 0 THEN no = 3
END IF
  IF no > lg THEN lg = no: go = ch
END SUB

SUB compsrch (ch, lg, no, go, lv, p3a, p3b, pl)
  FOR z = 0 TO (63 + p3a)
    IF piece(z) = 1 THEN
      FOR w = 1 TO z MOD (8 + p3b)
        IF piece(z - w * 9) < 2 THEN
          no = w - 1
          ch = z - w * 9
          IF (piece(z - w * 9) = 1) OR (z - w * 9) < 0 OR (z - w * 9) > (63 + p3a) THEN no = 0
          w = z MOD (8 + p3b)
        END IF
      NEXT w
      CALL compch(ch, lg, no, go, z, lv, pl)
    
      FOR w = 1 TO FIX(z / (8 + p3b))
        IF piece(z - w * 8) < 2 THEN
          no = w - 1
          ch = z - w * 8
          IF (piece(z - w * 8) = 1) OR (z - w * 8) < 0 OR (z - w * 8) > (63 + p3a) THEN no = 0
          w = FIX(z / (8 + p3b))
        END IF
      NEXT w
      CALL compch(ch, lg, no, go, z, lv, pl)
    
      FOR w = 1 TO 7 + p3b - z MOD (8 + p3b)
        IF piece(z - w * 7) < 2 THEN
          no = w - 1
          ch = z - w * 7
          IF (piece(z - w * 7) = 1) OR (z - w * 7) < 0 OR (z - w * 7) > (63 + p3a) THEN no = 0
          w = 7 + p3b - z MOD (8 + p3b)
        END IF
      NEXT w
      CALL compch(ch, lg, no, go, z, lv, pl)
    
      FOR w = 1 TO z MOD (8 + p3b)
        IF piece(z - w) < 2 THEN
          no = w - 1
          ch = z - w
          IF (piece(z - w) = 1) OR (z - w) < 0 OR (z - w) > (63 + p3a) THEN no = 0
          w = z MOD (8 + p3b)
        END IF
      NEXT w
      CALL compch(ch, lg, no, go, z, lv, pl)
    
      FOR w = 1 TO 7 + p3b - z MOD (8 + p3b)
        IF piece(z + w) < 2 THEN
          no = w - 1
          ch = z + w
          IF (piece(z + w) = 1) OR (z + w) < 0 OR (z + w) > (63 + p3a) THEN no = 0  'DAVID KOLLER
          w = 7 + p3b - z MOD (8 + p3b)
        END IF
      NEXT w
      CALL compch(ch, lg, no, go, z, lv, pl)
    
      FOR w = 1 TO z MOD (8 + p3b)
        IF piece(z + w * 7) < 2 THEN
          no = w - 1
          ch = z + w * 7
          IF (piece(z + w * 7) = 1) OR (z + w * 7) < 0 OR (z + w * 7) > (63 + p3a) THEN no = 0
          w = z MOD (8 + p3b)
        END IF
      NEXT w
      CALL compch(ch, lg, no, go, z, lv, pl)
    
      FOR w = 1 TO 7 + p3b - FIX(z / (8 + p3b))
        IF piece(z + w * 8) < 2 THEN
          no = w - 1
          ch = z + w * 8
          IF (piece(z + w * 8) = 1) OR (z + w * 8) < 0 OR (z + w * 8) > (63 + p3a) THEN no = 0
          w = 7 + p3b - FIX(z / (8 + p3b))
        END IF
      NEXT w
      CALL compch(ch, lg, no, go, z, lv, pl)
    
      FOR w = 1 TO 7 + p3b - z MOD (8 + p3b)
        IF piece(z + w * 9) < 2 THEN
          no = w - 1
          ch = z + w * 9
          IF (piece(z + w * 9) = 1) OR (z + w * 9) < 0 OR (z + w * 9) > (63 + p3a) THEN no = 0
          w = 7 + p3b - z MOD (8 + p3b)
        END IF
      NEXT w
      CALL compch(ch, lg, no, go, z, lv, pl)
    END IF
  NEXT z
END SUB

SUB instruct
  CLS
  COLOR 15
  PRINT "OTHULLO KEYBOARD COMMANDS"
  PRINT "*************************"
  PRINT ""
  PRINT "ARROWS .. MOVE POINTER"
  PRINT ""
  PRINT "H ....... HINT! COMPUTER SUGGESTS MOVE (1 & 2 PLAYER MODES)"
  PRINT "P ....... PASS TURN IF YOU CAN'T MOVE"
  PRINT "T ....... TALLY SCORES IF NOBODY CAN MOVE"
  PRINT ""
  PRINT "ENTER ... PLACES CHIPS / RETURNS FROM HINT MODE"
  PRINT ""
  INPUT "", dud
  COLOR 14
END SUB

SUB ointro
  CIRCLE (60, 240), 50, 1
  PAINT (60, 240), 1
  CIRCLE (580, 240), 50, 1
  PAINT (580, 240), 1
  x = 90
  y = 480
  WHILE y > 240
    LINE (x + 40, y + 2)-(x + 100, y + 2), 0        't top
    LINE (x + 40, y)-(x + 100, y), 1
    LINE (x + 70, y + 51)-(x + 70, y + 52), 0   ' t mid
    LINE (x + 70, y)-(x + 70, y + 50), 1
    y = y - 2
  WEND
  y = 0
  WHILE y < 240
    LINE (x + 120, y + 38)-(x + 180, y + 38), 0     ' h mid
    LINE (x + 120, y + 40)-(x + 180, y + 40), 1
    LINE (x + 120, y - 1)-(x + 120, y - 2), 0    ' h left
    LINE (x + 120, y)-(x + 120, y + 50), 1
    LINE (x + 180, y - 1)-(x + 180, y - 2), 0   ' h right
    LINE (x + 180, y)-(x + 180, y + 50), 1
    y = y + 2
  WEND
  y = 480
  WHILE y > 240
    LINE (x + 200, y + 52)-(x + 260, y + 52), 0  ' u bot
    LINE (x + 200, y + 50)-(x + 260, y + 50), 1
    LINE (x + 200, y + 51)-(x + 200, y + 52), 0    ' u left
    LINE (x + 200, y)-(x + 200, y + 50), 1
    LINE (x + 260, y + 51)-(x + 260, y + 52), 0    ' u right
    LINE (x + 260, y)-(x + 260, y + 50), 1
    y = y - 2
  WEND
  y = 0
  WHILE y < 240
    LINE (x + 280, y + 48)-(x + 340, y + 48), 0' l bot
    LINE (x + 280, y + 50)-(x + 340, y + 50), 1
    LINE (x + 280, y - 1)-(x + 280, y - 2), 0  ' l left
    LINE (x + 280, y)-(x + 280, y + 50), 1
    y = y + 2
  WEND
  y = 640
  WHILE y > 240
    LINE (x + 360, y + 52)-(x + 420, y + 52), 0  ' l bot
    LINE (x + 360, y + 50)-(x + 420, y + 50), 1
    LINE (x + 360, y + 51)-(x + 360, y + 52), 0    ' l left
    LINE (x + 360, y)-(x + 360, y + 50), 1
    y = y - 2
  WEND

  LOCATE 14, 27
  PRINT "DAVID KOLLER GAMING PRESENTS"
y = 0
WHILE INKEY$ <> CHR$(13)
y = y + 2
IF y = 640 THEN y = 0
FOR x = 0 TO 180 STEP 10
  LINE (0 + y, x + 2)-(260, 0), 15
  LINE (0 + y, x + 3)-(260, 0), 7
  LINE (0 + y, x + 4)-(260, 0), 8
  LINE (0 + y, x + 1)-(260, 0), 7
  LINE (0 + y, x)-(260, 0), 8
NEXT x

FOR x = 0 TO 180 STEP 10
  LINE (640 - y, x + 2)-(380, 0), 15
  LINE (640 - y, x + 3)-(380, 0), 7
  LINE (640 - y, x + 4)-(380, 0), 8
  LINE (640 - y, x + 1)-(380, 0), 7
  LINE (640 - y, x)-(380, 0), 8
NEXT x

FOR x = 480 TO 300 STEP -10
  LINE (640 - y, x + 2)-(380, 480), 15
  LINE (640 - y, x + 3)-(380, 480), 7
  LINE (640 - y, x + 4)-(380, 480), 8
  LINE (640 - y, x + 1)-(380, 480), 7
  LINE (640 - y, x)-(380, 480), 8
NEXT x

FOR x = 480 TO 300 STEP -10
  LINE (0 + y, x + 2)-(260, 480), 15
  LINE (0 + y, x + 3)-(260, 480), 7
  LINE (0 + y, x + 4)-(260, 480), 8
  LINE (0 + y, x + 1)-(260, 480), 7
  LINE (0 + y, x)-(260, 480), 8
NEXT x
WEND
SLEEP 1
END SUB

SUB pointer (x, y, p)
  LINE (x - 24, y - 24)-(x + 24, y - 21), 15, BF
  LINE (x + 21, y - 24)-(x + 24, y + 24), 15, BF
  LINE (x - 24, y + 24)-(x + 24, y + 21), 15, BF
  LINE (x - 24, y - 24)-(x - 21, y + 24), 15, BF
  PUT (x - 25, y - 25), sq, AND
END SUB

SUB scan (p, pl, turn, p3)
  pp = -1
  PLAY "mb o1 l25 ef"
  FOR yy = 65 TO 415 STEP 50
    FOR xx = 145 TO 495 + p3 STEP 50
      pp = pp + 1
      IF turn = 1 THEN
        IF piece(pp) = 1 THEN PUT (xx - 15, yy - 15), rpc, PSET
        IF piece(pp) = 2 THEN PUT (xx - 15, yy - 15), bpc, PSET
        IF piece(pp) = 3 THEN PUT (xx - 15, yy - 15), gpc, PSET
        IF piece(pp) = 4 THEN PUT (xx - 15, yy - 15), ppc, PSET
      ELSEIF turn = 2 THEN
        IF piece(pp) = 1 AND pl > 3 THEN PUT (xx - 15, yy - 15), ppc, PSET
        IF piece(pp) = 2 AND pl > 3 THEN PUT (xx - 15, yy - 15), rpc, PSET
        IF piece(pp) = 3 AND pl > 3 THEN PUT (xx - 15, yy - 15), bpc, PSET
        IF piece(pp) = 4 AND pl > 3 THEN PUT (xx - 15, yy - 15), gpc, PSET
        IF piece(pp) = 1 AND pl = 3 THEN PUT (xx - 15, yy - 15), gpc, PSET
        IF piece(pp) = 2 AND pl = 3 THEN PUT (xx - 15, yy - 15), rpc, PSET
        IF piece(pp) = 3 AND pl = 3 THEN PUT (xx - 15, yy - 15), bpc, PSET
        IF piece(pp) = 1 AND pl < 3 THEN PUT (xx - 15, yy - 15), bpc, PSET
        IF piece(pp) = 2 AND pl < 3 THEN PUT (xx - 15, yy - 15), rpc, PSET
      ELSEIF turn = 3 THEN
        IF piece(pp) = 1 AND pl > 3 THEN PUT (xx - 15, yy - 15), gpc, PSET
        IF piece(pp) = 2 AND pl > 3 THEN PUT (xx - 15, yy - 15), ppc, PSET
        IF piece(pp) = 3 AND pl > 3 THEN PUT (xx - 15, yy - 15), rpc, PSET
        IF piece(pp) = 4 AND pl > 3 THEN PUT (xx - 15, yy - 15), bpc, PSET
        IF piece(pp) = 1 AND pl = 3 THEN PUT (xx - 15, yy - 15), bpc, PSET
        IF piece(pp) = 2 AND pl = 3 THEN PUT (xx - 15, yy - 15), gpc, PSET
        IF piece(pp) = 3 AND pl = 3 THEN PUT (xx - 15, yy - 15), rpc, PSET
      ELSEIF turn = 4 THEN
        IF piece(pp) = 1 THEN PUT (xx - 15, yy - 15), bpc, PSET
        IF piece(pp) = 2 THEN PUT (xx - 15, yy - 15), gpc, PSET
        IF piece(pp) = 3 THEN PUT (xx - 15, yy - 15), ppc, PSET
        IF piece(pp) = 4 THEN PUT (xx - 15, yy - 15), rpc, PSET
      END IF
    NEXT xx
  NEXT yy
END SUB

SUB stall1 (secs#)
  a# = TIMER
  WHILE TIMER - secs# < a#
  WEND
END SUB

SUB tally (turn, pl, r!, b!, gr!, pr!)

r! = .4
b! = .3
gr! = .2
pr! = .1

IF pl < 3 THEN
FOR z = 0 TO 72
SELECT CASE turn
  CASE 1:
    IF piece(z) = 1 THEN r! = r! + 1
    IF piece(z) = 2 THEN b! = b! + 1
  CASE 2:
    IF piece(z) = 2 THEN r! = r! + 1
    IF piece(z) = 1 THEN b! = b! + 1
END SELECT
NEXT z
END IF

IF pl = 3 THEN
FOR z = 0 TO 72
SELECT CASE turn
  CASE 1:
    IF piece(z) = 1 THEN r! = r! + 1
    IF piece(z) = 2 THEN b! = b! + 1
    IF piece(z) = 3 THEN gr! = gr! + 1
  CASE 2:
    IF piece(z) = 2 THEN r! = r! + 1
    IF piece(z) = 3 THEN b! = b! + 1
    IF piece(z) = 1 THEN gr! = gr! + 1
  CASE 3:
    IF piece(z) = 3 THEN r! = r! + 1
    IF piece(z) = 1 THEN b! = b! + 1
    IF piece(z) = 2 THEN gr! = gr! + 1
END SELECT
NEXT z
END IF

IF pl = 4 THEN
FOR z = 0 TO 72
SELECT CASE turn
  CASE 1:
    IF piece(z) = 1 THEN r! = r! + 1
    IF piece(z) = 2 THEN b! = b! + 1
    IF piece(z) = 3 THEN gr! = gr! + 1
    IF piece(z) = 4 THEN pr! = pr! + 1
  CASE 2:
    IF piece(z) = 2 THEN r! = r! + 1
    IF piece(z) = 3 THEN b! = b! + 1
    IF piece(z) = 4 THEN gr! = gr! + 1
    IF piece(z) = 1 THEN pr! = pr! + 1
  CASE 3:
    IF piece(z) = 3 THEN r! = r! + 1
    IF piece(z) = 4 THEN b! = b! + 1
    IF piece(z) = 1 THEN gr! = gr! + 1
    IF piece(z) = 2 THEN pr! = pr! + 1
  CASE 4:
    IF piece(z) = 4 THEN r! = r! + 1
    IF piece(z) = 1 THEN b! = b! + 1
    IF piece(z) = 2 THEN gr! = gr! + 1
    IF piece(z) = 3 THEN pr! = pr! + 1
END SELECT
NEXT z
END IF

rrk = 4
brk = 4
grk = 4
prk = 4

IF r! > b! THEN rrk = rrk - 1
IF r! > gr! THEN rrk = rrk - 1
IF r! > pr! THEN rrk = rrk - 1
IF b! > r! THEN brk = brk - 1
IF b! > gr! THEN brk = brk - 1
IF b! > pr! THEN brk = brk - 1
IF gr! > b! THEN grk = grk - 1
IF gr! > r! THEN grk = grk - 1
IF gr! > pr! THEN grk = grk - 1
IF pr! > b! THEN prk = prk - 1
IF pr! > gr! THEN prk = prk - 1
IF pr! > r! THEN prk = prk - 1

COLOR 15
CIRCLE (39, 67 + rrk * 63), 10, 4
PAINT (39, 67 + rrk * 63), 4
CIRCLE (39, 67 + rrk * 63), 7, 0
PAINT (39, 67 + rrk * 63), 12, 0
LOCATE 6 + rrk * 4, 4
PRINT FIX(r!)
CIRCLE (39, 67 + brk * 63), 10, 1
PAINT (39, 67 + brk * 63), 1
CIRCLE (39, 67 + brk * 63), 7, 0
PAINT (39, 67 + brk * 63), 9, 0
LOCATE 6 + brk * 4, 4
PRINT FIX(b!)
IF pl > 2 THEN
  CIRCLE (39, 67 + grk * 63), 10, 2
  PAINT (39, 67 + grk * 63), 2
  CIRCLE (39, 67 + grk * 63), 7, 0
  PAINT (39, 67 + grk * 63), 10, 0
  LOCATE 6 + grk * 4, 4
  PRINT FIX(gr!)
END IF
IF pl > 3 THEN
  CIRCLE (39, 67 + prk * 63), 10, 5
  PAINT (39, 67 + prk * 63), 5
  CIRCLE (39, 67 + prk * 63), 7, 0
  PAINT (39, 67 + prk * 63), 13, 0
  LOCATE 6 + prk * 4, 4
  PRINT FIX(pr!)
END IF
END SUB

