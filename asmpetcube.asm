*=$0801                 ;2025 sys2061
        byte $0b,$08,$e9,$07            ;line number (year)
        byte $9e, "2","0","6","1",0,0,0 ;sys 2061


*=$080D                 ;this is address 2061 (not rly needed)
        ;jsr $e544       ;clear screen sys call
        ;rts
        ;fill screen with #160
        
        sei
        lda #$35
        sta $01
        
        ldx #0
        lda #160
filoop
        sta $0400,x
        sta $0500,x
        sta $0600,x
        sta $0700,x
        inx
        bne filoop

        ;set start of data
        lda #<mydata
        sta $fb
        lda #>mydata
        sta $fc

        ;set start of color map
        lda #$00
        sta $fd
        lda #$d8
        sta $fe
        ;rts

        ldy #0
        sty $02 ;framecounter
        ;read a byte and decode to 2 color chars
mainloop
        lda ($fb),y
        ;sta $0400
        ;rts
        tax
        and #$f0
        lsr
        lsr
        lsr
        lsr
        sta ($fd),y
        
        inc $fd
        bne nxtnib
        inc $fe
;        lda $fe
;        cmp #$db
;        bne nxtnib
;        lda $fd
;        cmp #$e8
;        beq frameend
        
        
nxtnib
        ;rts
        txa
        and #$0f
        sta ($fd),y

        inc $fd
        bne goahead
        inc $fe
goahead
        lda $fe
        cmp #$db
        bne outofbyte
        lda $fd
        cmp #$ea
        beq frameend

outofbyte
        inc $fb
        bne getiton
        inc $fc
        ;lda $fc
        ;cmp #$db
        ;beq endofprg

getiton
        ;decode next byte
        jmp mainloop
        
frameend
        inc $02 ; add framecounter+1
        lda $02
        cmp #101
        bne gofrahead
        lda #00
        sta $02
        ;rts
        ;reset data pointer
        lda #<mydata
        sta $fb
        lda #>mydata
        sta $fc
        

gofrahead
        ;reset color mem pointer
        lda #$00
        sta $fd
        lda #$d8
        sta $fe
        ;add datapointer+1
;        inc $fb
;        bne goraster
;        inc $fc

goraster
        lda #200
        ldx #8
rastlop
        cmp $d012
        bne rastlop
        dex
        bne rastlop
        jmp mainloop
        rts
        ;sei             ;disable interrupts

mydata
;       byte $ee
incbin "petcubedata.seq"