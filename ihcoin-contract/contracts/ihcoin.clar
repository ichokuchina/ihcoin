;; ihcoin: a simple fungible-like token implemented in Clarity
;; This contract is intentionally minimal and suitable for local development

(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-INSUFFICIENT-BALANCE (err u101))

(define-data-var total-supply uint u0)

(define-map balances
  { owner: principal }
  { amount: uint })

(define-read-only (get-total-supply)
  (ok (var-get total-supply)))

(define-read-only (get-balance (owner principal))
  (ok (default-to u0 (get amount (map-get? balances { owner: owner })))))

(define-public (transfer (amount uint) (sender principal) (recipient principal))
  (begin
    (asserts! (> amount u0) (err u1))
    (let
      (
        (sender-balance (default-to u0 (get amount (map-get? balances { owner: sender }))))
      )
      (asserts! (>= sender-balance amount) ERR-INSUFFICIENT-BALANCE)
      (map-set balances { owner: sender } { amount: (- sender-balance amount) })
      (let
        (
          (recipient-balance (default-to u0 (get amount (map-get? balances { owner: recipient }))))
        )
        (map-set balances { owner: recipient } { amount: (+ recipient-balance amount) })
        (ok true)))))

(define-public (mint (amount uint) (recipient principal))
  (begin
    ;; Simple authorization: only allow minting to yourself
    (asserts! (is-eq tx-sender recipient) ERR-NOT-AUTHORIZED)
    (asserts! (> amount u0) (err u2))
    (let
      (
        (current-balance (default-to u0 (get amount (map-get? balances { owner: recipient }))))
      )
      (map-set balances { owner: recipient } { amount: (+ current-balance amount) })
      (var-set total-supply (+ (var-get total-supply) amount))
      (ok true))))
