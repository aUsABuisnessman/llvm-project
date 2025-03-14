; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

declare void @use(i8)

define i8 @sub_not(i8 %x, i8 %y) {
; CHECK-LABEL: @sub_not(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    [[R:%.*]] = add i8 [[Y:%.*]], [[TMP1]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %s = sub i8 %x, %y
  %r = xor i8 %s, -1
  ret i8 %r
}

define i8 @sub_not_extra_use(i8 %x, i8 %y) {
; CHECK-LABEL: @sub_not_extra_use(
; CHECK-NEXT:    [[S:%.*]] = sub i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = xor i8 [[S]], -1
; CHECK-NEXT:    call void @use(i8 [[S]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %s = sub i8 %x, %y
  %r = xor i8 %s, -1
  call void @use(i8 %s)
  ret i8 %r
}

define <2 x i8> @sub_not_vec(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @sub_not_vec(
; CHECK-NEXT:    [[TMP1:%.*]] = xor <2 x i8> [[X:%.*]], splat (i8 -1)
; CHECK-NEXT:    [[R:%.*]] = add <2 x i8> [[Y:%.*]], [[TMP1]]
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %s = sub <2 x i8> %x, %y
  %r = xor <2 x i8> %s, <i8 -1, i8 poison>
  ret <2 x i8> %r
}

define i8 @dec_sub(i8 %x, i8 %y) {
; CHECK-LABEL: @dec_sub(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], -1
; CHECK-NEXT:    [[R:%.*]] = add i8 [[X:%.*]], [[TMP1]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %s = sub i8 %x, %y
  %r = add i8 %s, -1
  ret i8 %r
}

define i8 @dec_sub_extra_use(i8 %x, i8 %y) {
; CHECK-LABEL: @dec_sub_extra_use(
; CHECK-NEXT:    [[S:%.*]] = sub i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = add i8 [[S]], -1
; CHECK-NEXT:    call void @use(i8 [[S]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %s = sub i8 %x, %y
  %r = add i8 %s, -1
  call void @use(i8 %s)
  ret i8 %r
}

define <2 x i8> @dec_sub_vec(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @dec_sub_vec(
; CHECK-NEXT:    [[TMP1:%.*]] = xor <2 x i8> [[Y:%.*]], splat (i8 -1)
; CHECK-NEXT:    [[R:%.*]] = add <2 x i8> [[X:%.*]], [[TMP1]]
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %s = sub <2 x i8> %x, %y
  %r = add <2 x i8> %s, <i8 -1, i8 poison>
  ret <2 x i8> %r
}

define i8 @sub_inc(i8 %x, i8 %y) {
; CHECK-LABEL: @sub_inc(
; CHECK-NEXT:    [[S_NEG:%.*]] = xor i8 [[X:%.*]], -1
; CHECK-NEXT:    [[R:%.*]] = add i8 [[Y:%.*]], [[S_NEG]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %s = add i8 %x, 1
  %r = sub i8 %y, %s
  ret i8 %r
}

define i8 @sub_inc_extra_use(i8 %x, i8 %y) {
; CHECK-LABEL: @sub_inc_extra_use(
; CHECK-NEXT:    [[S:%.*]] = add i8 [[X:%.*]], 1
; CHECK-NEXT:    [[R:%.*]] = sub i8 [[Y:%.*]], [[S]]
; CHECK-NEXT:    call void @use(i8 [[S]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %s = add i8 %x, 1
  %r = sub i8 %y, %s
  call void @use(i8 %s)
  ret i8 %r
}

define <2 x i8> @sub_inc_vec(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @sub_inc_vec(
; CHECK-NEXT:    [[S_NEG:%.*]] = xor <2 x i8> [[X:%.*]], splat (i8 -1)
; CHECK-NEXT:    [[R:%.*]] = add <2 x i8> [[Y:%.*]], [[S_NEG]]
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %s = add <2 x i8> %x, <i8 poison, i8 1>
  %r = sub <2 x i8> %y, %s
  ret <2 x i8> %r
}

define i8 @sub_dec(i8 %x, i8 %y) {
; CHECK-LABEL: @sub_dec(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], -1
; CHECK-NEXT:    [[R:%.*]] = add i8 [[X:%.*]], [[TMP1]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %s = add i8 %x, -1
  %r = sub i8 %s, %y
  ret i8 %r
}

define i8 @sub_dec_extra_use(i8 %x, i8 %y) {
; CHECK-LABEL: @sub_dec_extra_use(
; CHECK-NEXT:    [[S:%.*]] = add i8 [[X:%.*]], -1
; CHECK-NEXT:    [[R:%.*]] = sub i8 [[S]], [[Y:%.*]]
; CHECK-NEXT:    call void @use(i8 [[S]])
; CHECK-NEXT:    ret i8 [[R]]
;
  %s = add i8 %x, -1
  %r = sub i8 %s, %y
  call void @use(i8 %s)
  ret i8 %r
}

define <2 x i8> @sub_dec_vec(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @sub_dec_vec(
; CHECK-NEXT:    [[TMP1:%.*]] = xor <2 x i8> [[Y:%.*]], splat (i8 -1)
; CHECK-NEXT:    [[R:%.*]] = add <2 x i8> [[X:%.*]], [[TMP1]]
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %s = add <2 x i8> %x, <i8 poison, i8 -1>
  %r = sub <2 x i8> %s, %y
  ret <2 x i8> %r
}

