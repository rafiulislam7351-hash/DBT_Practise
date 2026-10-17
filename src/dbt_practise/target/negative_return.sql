SELECT *
FROM
    {{ref("bronze_return")}}
WHERE
    refund_amount<0