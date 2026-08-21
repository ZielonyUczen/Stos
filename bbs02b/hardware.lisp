;; BBS02B VESC Package - hardware abstraction layer
;;
;; IMPORTANT:
;; GPIO/ICU mappings are intentionally NOT hard-coded here.
;; They must be filled only after the exact MKS 75200 V2 revision,
;; electrical levels and VESC firmware API have been verified.

(defun hw-status ()
  (list
    (cons 'pas1 'unmapped)
    (cons 'pas2 'unmapped)
    (cons 'speed 'unmapped)))

;; Returns a normalized hardware state used by higher layers.
;; Sensor acquisition will be implemented after pin/API verification.
(defun hw-read ()
  (list
    (cons 'pas1-valid false)
    (cons 'pas2-valid false)
    (cons 'speed-valid false)
    (cons 'pas1 0)
    (cons 'pas2 0)
    (cons 'speed-period 0)
    (cons 'speed-width 0)))

;; Safe placeholder: no physical output is driven here.
(defun hw-safe-state ()
  true)
