-- name: CreateTransfer :one
INSERT INTO transfers (
  from_account_id,
  to_account_id,
  amount
) VALUES (
    $1, $2, $3
)
RETURNING *;

-- name: GetTransfer :one
SELECT * FROM transfers
WHERE id = $1 LIMIT 1;

-- name: ListTransfers :many
SELECT * FROM transfers
ORDER BY id
LIMIT $1
OFFSET $2;

-- name: UpdateTransfer :one
-- UPDATE transfers SET balance = $2
-- WHERE id = $1
-- RETURNING *;


-- name: DeleteAccount :exec
-- DELETE FROM accounts
-- WHERE id = $1;