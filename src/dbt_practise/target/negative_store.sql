SELECT *
FROM
    {{ref("bronze_store")}}
WHERE
    sq_ft<0 AND sq_ft=0